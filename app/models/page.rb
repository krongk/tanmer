class Page < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  validates :title, :short_title, :content, presence: true

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
end
