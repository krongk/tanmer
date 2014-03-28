class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :phone
  validate do
    (m = !self.phone.to_s.strip.match(/^(1(([35][0-9])|(47)|[8][01236789]))\d{8}$/)) &&
      errors.add(:base, "手机号码格式错误")
  end

  belongs_to :user
  has_many :page_rates
  has_many :books
end
