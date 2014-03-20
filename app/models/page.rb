class Page < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  validates :title, :content, presence: true
  after_create :create_unique_short_title

  #extract image url from content
  def image
    if self.content =~ /<img\s+.*src\s*=\s*"(.*\.(?:jpg|png|gif))"/i
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
        self.short_title = 'p' + SecureRandom.hex(5)
      end while self.class.exists?(:short_title => short_title)
    end

end
