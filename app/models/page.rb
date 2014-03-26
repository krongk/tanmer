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

 
  private
    def create_unique_short_title
      begin
        self.short_title = SecureRandom.hex(5)
      end while self.class.exists?(:short_title => short_title)
    end

end
