#encoding: utf-8
class Page < ActiveRecord::Base
  belongs_to :user
  has_one :page_content, :dependent => :destroy, :autosave => true
  has_many :page_rates, :dependent => :destroy
  acts_as_taggable
  validates :title, presence: true
  before_create :create_unique_short_title

  #page content
  attr_accessor :content

  def content= text
    if self.page_content
      self.page_content.content = text
    end
  end
  
  def content
    self.page_content.try(:content)
  end

  #extract image url from content
  def image
    if !self.extend_url.blank?
      self.qrcode
    elsif self.page_content.try(:content) =~ /<img\s+.*src\s*=\s*"(.*\.(?:jpg|png|gif))"/i
      $1
    else
      "/assets/avatar.jpg"
    end
  end

  #get pages from user and user's followers
  #this function is called on User model
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    #where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
    where("user_id IN (#{followed_user_ids})", user_id: user.id)
  end

  #get recuent record
  def self.recent(count = 10)
    self.order("updated_at DESC").limit(count)
  end

  #搜索
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end
  
  #喜欢/IP/PV数据 typo = [fav ip pv]
  def self.increment_rate_count(typo, page_id, amount = 1)
    self.incremented_rate_count(typo, page_id)
  end

  def self.decrement_rate_count(typo, page_id, amount = -1)
    self.incremented_rate_count(typo, page_id)
  end

  def self.incremented_rate_count(typo, page_id, amount = 1)
    Page.transaction do
      ks = self.find_by(id: page_id)
      return if ks.nil?
      case typo
      when 'fav'
        ks.fav_count = ks.fav_count.to_i + amount
      when 'ip'
        ks.ip_count = ks.ip_count.to_i + amount
      when 'pv'
        ks.pv_count = ks.pv_count.to_i + amount
      else
        raise "incorrect typo, typo should has value of [fav ip pv]"
      end
      ks.save!
    end
  end
 
  private
    def create_unique_short_title
      begin
        self.short_title = SecureRandom.hex(5)
      end while self.class.exists?(:short_title => short_title)
    end

end
