class SubscriptionMailer < ActionMailer::Base
  default from: "noreply@sellyaparts.com"

  def renew_subscription(subscription)
    @subscription = subscription
    mail :to => @subscription.user.email, :subject => "Payment is done for monthly subscription plan- #{@subscription.plan.name}"
  end

  def failed_subscription(subscription)
    @subscription = subscription
    mail :to => @subscription.user.email, :subject => "Payment has failed for plan- #{@subscription.plan.name} ."
  end
  
end
