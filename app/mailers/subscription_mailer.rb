class SubscriptionMailer < ActionMailer::Base
  default from: "noreply@sellyaparts.com"

  def renew_subscription(subscription)
    @subscription = subscription
    mail :to => @subscription.user.email, :subject => "Payment is done for #{@subscription.subscriptionable.class.name} - #{@subscription.subscriptionable.name} as monthly basis."
  end

  def failed_subscription(subscription)
    @subscription = subscription
    mail :to => @subscription.user.email, :subject => "Payment has failed for #{@subscription.subscriptionable.class.name} - #{@subscription.subscriptionable.name} ."
  end
  
end
