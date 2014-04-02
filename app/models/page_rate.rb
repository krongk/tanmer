class PageRate < ActiveRecord::Base
  belongs_to :page
  belongs_to :member
  #validates :phone, presence: true
  
  attr_accessor :name, :email, :phone, :address, :message

  #喜欢/IP/PV数据 typo = [ip pv]
  def self.increment_rate_count(typo, page_id, amount = 1)
    self.incremented_rate_count(typo, page_id)
  end

  def self.decrement_rate_count(typo, page_id, amount = -1)
    self.incremented_rate_count(typo, page_id)
  end

  def self.incremented_rate_count(typo, page_id, amount = 1)
    PageRate.transaction do
      ks = self.find_by(id: page_id)
      return if ks.nil?
      case typo
      when 'ip'
        ks.ip_count = ks.ip_count.to_i + amount
      when 'pv'
        ks.pv_count = ks.pv_count.to_i + amount
      else
        raise "incorrect typo, typo should has value of [ip pv]"
      end
      ks.save!
    end
  end

end
