class Subscriber < ActiveRecord::Base
  def self.fetch_emails
    h = Hominid::API.new(MAILCHIMP_API_KEY)
    members = h.listMembers(WORKSHOP_LIST_ID, 'subscribed', 100.years.ago, 0, 15000)
    if members.present? && data = members['data']
      data.map { |v| v['email'] } 
    end
  end
end
