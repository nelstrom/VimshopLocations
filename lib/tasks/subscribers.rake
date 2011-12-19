namespace :subscribers do
  desc "Fetch subscribers from MailChimp API, then normalize locations"
  task :import => :environment do
    Subscriber.import_subscribers
  end
end
