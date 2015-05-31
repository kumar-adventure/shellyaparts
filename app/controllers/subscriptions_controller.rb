class SubscriptionsController < ApplicationController

  before_action :authenticate_user!

  def index
  	@subscriptions = current_user.subscriptions
  end

  def new
  end

  def create
  	return redirect_to request.referrer, alert: "Card Token can't be blank!..." if params[:subscription].blank? || params[:subscription][:card_token].blank?
    
    #Find Plan
    plan = Plan.where(name: params[:plan]).first
  	return redirect_to request.referrer, alert: "InValid Plan!!!"  if plan.blank?
    
    #Find Subscription
  	subscription = current_user.subscriptions.where(plan_id: plan.id).last

  	if subscription.blank?
  		# Create Customer on Stripe
  	  customer = Stripe::Customer.create(email: current_user.email, card: params[:subscription][:card_token])
      #Create Subscription
      subscription = current_user.subscriptions.create(plan_id: plan.id, customer_id: customer.id)
      #Create Charges on Stripe
      charge = Stripe::Charge.create(customer: customer.id, amount: (plan.price * 100).to_i, description: plan.name, currency: plan.currency)
      #Check payment is done or not!
      if charge.paid
      	# Set paid status
      	subscription.update_attributes(paid: true, is_active: true)
      	SubscriptionSuccessWorker.perform(subscription)
      	#SubscriptionMailer.renew_subscription(subscription).deliver
      	flash[:notice] = "Payment is done successfully and you have subscribed for plan-#{plan.name}"

      else
      	subscription.update_attributes(paid: false, is_active: false)
      	SubscriptionFailedWorker.perform(subscription)
      	#SubscriptionMailer.failed_subscription(subscription).deliver
      	flash[:alert] = "Payment is not done yet, here is problem with your card to make the payment!!!"
      	return redirect_to request.referrer
      end
  	else
  		#Create Charges on Stripe
      charge = Stripe::Charge.create(customer: subscription.customer_id, amount: (plan.price * 100).to_i, description: plan.name, currency: plan.currency)
      #Check payment is done or not!
      if charge.paid
      	# Set paid status
      	#subscription.update_attributes(paid: true, is_active: true)
      	subs = current_user.subscriptions.create(plan_id: subscription.plan.id, customer_id: subscription.customer_id, paid: true, is_active: true)
      	SubscriptionSuccessWorker.perform(subs)
      	flash[:notice] = "Payment is done successfully and you have subscribed for plan-#{plan.name}"
      else
      	subscription.update_attributes(paid: false, is_active: false)
      	SubscriptionFailedWorker.perform(subscription)
      	flash[:alert] = "Payment is not done yet, here is problem with your card to make the payment!!!"
      	return redirect_to request.referrer
      end
  	end
  	redirect_to root_path
  end

end
