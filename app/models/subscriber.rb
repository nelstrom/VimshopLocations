class Subscriber < ActiveRecord::Base

  validates_presence_of :email
  validates_uniqueness_of :email

  def self.fetch_grouped_emails(limit=50)
    emails = fetch_emails
    subs = []
    while emails.present?
      subs.push emails.slice!(0,limit)
    end
    subs
  end

  def self.fetch_emails
    h = Hominid::API.new(MAILCHIMP_API_KEY)
    members = h.listMembers(WORKSHOP_LIST_ID, 'subscribed', 100.years.ago, 0, 15000)
    if members.present? && data = members['data']
      data.map { |v| v['email'] }
    end
  end

  def self.import_subscribers
    fetch_grouped_emails.each do |group|
      info = fetch_info_for(group)
      info['data'].each do |u|
        fields = u['merges']
        unless Subscriber.find_by_email(u['email']).present?
          Subscriber.create({
            :email => u['email'],
            :city       => fields['CITY'],
            :country    => fields['COUNTRY'],
            :first_name => fields['FNAME'],
            :last_name  => fields['LNAME']
          })
        end
      end
    end
  end

  def self.fetch_info_for(emails)
    h = Hominid::API.new(MAILCHIMP_API_KEY)
    h.listMemberInfo(WORKSHOP_LIST_ID, emails)
  end
end
