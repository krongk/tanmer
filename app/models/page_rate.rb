class PageRate < ActiveRecord::Base
  belongs_to :page
  belongs_to :member
  #validates :phone, presence: true
  
  attr_accessor :name, :email, :phone, :address, :message

  def self.increment_rate_count(page_rate_id, amount = 1)
    self.incremented_rate_count(page_rate_id)
  end

  def self.decrement_rate_count(page_rate_id, amount = -1)
    self.incremented_rate_count(page_rate_id)
  end

  def self.incremented_rate_count(page_rate_id, amount = 1)
    PageRate.transaction do
      ks = self.find_by(id: page_rate_id)
      return if ks.nil?
      ks.rate_count = ks.rate_count.to_i + amount
      ks.save!
    end
  end

end
