class PageImage < ActiveRecord::Base
  belongs_to :page

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # has_attached_file :image,
  #                   :path => ":class/:id/:style.:extension",
  #                   :styles => {:original => '640x960#'} #override the original file
  #                   #:styles => { :content => '640x960>' } #standerd mobile size: 320*480 480*800 640*960
  validates :image, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :image
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 1.megabytes

end
