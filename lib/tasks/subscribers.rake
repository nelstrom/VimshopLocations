namespace :subscribers do

  desc "Fetch subscribers from MailChimp API, then normalize locations"
  task :import => :clear do
    puts "Importing subscribers"
    Subscriber.import_subscribers
  end

  desc "Clear existing subscribers (but keep locations)"
  task :clear => :environment do
    puts "Clearing existing subscriber info"
    Subscriber.delete_all
    # Must be a better way! Perhaps: Location.reset_column_information
    Location.all.each { |l| l.update_attribute('subscribers_count', 0) }
  end

end
