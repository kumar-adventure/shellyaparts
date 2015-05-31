namespace :subscription do
	
  desc "Update Subscription"
  task :check_subscription => :environment do
    puts "--------------------Start Rake task for check subscription & update subscription---------------"
    User.check_and_update_subscription
    puts "--------------------Stop Rake task for check subscription & update subscription---------------"
  end

end