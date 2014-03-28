#encoding: utf-8
class Book < ActiveRecord::Base
  belongs_to :page
  belongs_to :member
  
  attr_accessor :name, :email, :phone, :address

  def formated_updated_at
    self.updated_at.strftime("%Y-%m-%d") unless self.updated_at.nil?
  end

end
