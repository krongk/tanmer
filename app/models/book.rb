#encoding: utf-8
class Book < ActiveRecord::Base
  belongs_to :page

  validates_presence_of :phone
  validate do
    (m = !self.phone.to_s.strip.match(/^(1(([35][0-9])|(47)|[8][01236789]))\d{8}$/)) &&
      errors.add(:base, "手机号码格式错误")
  end

  def formated_updated_at
    self.updated_at.strftime("%Y-%m-%d") unless self.updated_at.nil?
  end

end
