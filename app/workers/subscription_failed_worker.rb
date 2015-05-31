class SubscriptionFailedWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
   def self.perform(subscription)
    SubscriptionMailer.failed_subscription(subscription).deliver
  end

end