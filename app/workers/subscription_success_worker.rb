class SubscriptionSuccessWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def self.perform(subscription)
    SubscriptionMailer.renew_subscription(subscription).deliver
  end

end