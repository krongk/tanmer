class IpAddress < ActiveRecord::Base
  belongs_to :page

  def self.new_ip?(remote_ip, page_id)
    ip_addr = self.find_or_initialize_by(ip: remote_ip, page_id: page_id)
    #新房客或12小时前访问过的，计数一次；12小时内访问过的，不重复计数
    if ip_addr.new_record? || ip_addr.updated_at < 12.hours.ago
      flag = true
    else
      flag = false
    end
    ip_addr.updated_at = Time.now
    ip_addr.save
    return flag
  end
end
