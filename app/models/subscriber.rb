class Subscriber < ActiveRecord::Base

  validates_presence_of :email
  validates_uniqueness_of :email

  belongs_to :location, :counter_cache => true

  def self.import_subscribers
    fetch_grouped_emails.each do |group|
      info = fetch_info_for(group)
      info['data'].each do |u|
        fields = u['merges']
        unless Subscriber.find_by_email(u['email']).present?
           Subscriber.create({
            email:       u['email'],
            first_name:  fields['FNAME'],
            last_name:   fields['LNAME'],
            location:    Location.find_or_create_normalised_location(fields["CITY"], fields["COUNTRY"])
          })
        end
      end
    end
  end

  private

  def self.fetch_grouped_emails(limit=50)
    emails = fetch_emails
    subs = []
    while emails.present?
      subs.push emails.slice!(0,limit)
    end
    subs
  end

  def self.fetch_emails
    h = Hominid::API.new(ENV['MAILCHIMP_API_KEY'])
    members = h.listMembers(ENV['WORKSHOP_LIST_ID'], 'subscribed', 100.years.ago, 0, 15000)
    if members.present? && data = members['data']
      data.map { |v| v['email'] }
    end
  end

  def self.fetch_info_for(emails)
    h = Hominid::API.new(ENV['MAILCHIMP_API_KEY'])
    h.listMemberInfo(ENV['WORKSHOP_LIST_ID'], emails)
  end

end
