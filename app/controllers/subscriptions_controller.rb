class SubscriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_plan_or_addon, only: [:new, :create]

  def index
  	@subscriptions = current_user.subscriptions.page(params[:page])
  end

  def new    
  end

  def create
  	return redirect_to request.referrer, alert: "Card Token can't be blank!..." if params[:subscription].blank? || params[:subscription][:card_token].blank?
    
    #Find Subscription
  	subscription = @plan_or_addon.subscriptions.where(user_id: current_user.id).active.last

  	if subscription.blank?
  		# Create Customer on Stripe
  	  customer = Stripe::Customer.create(email: current_user.email, card: params[:subscription][:card_token])
      #Create Subscription
      subscription = @plan_or_addon.subscriptions.create(user_id: current_user.id, customer_id: customer.id)
      #Create Charges on Stripe
      charge = Stripe::Charge.create(customer: customer.id, amount: (@plan_or_addon.price * 100).to_i, description: @plan_or_addon.name, currency: @plan_or_addon.currency)
      #Check payment is done or not!
      if charge.paid
      	# Set paid status
      	subscription.update_attributes(is_active: true, status: "activated")
      	SubscriptionSuccessWorker.perform(subscription)
      	#SubscriptionMailer.renew_subscription(subscription).deliver
      	flash[:notice] = "Payment is done successfully and you have subscribed for plan-#{@plan_or_addon.name}"

      else
      	subscription.update_attributes(is_active: false, status: "pending")
      	SubscriptionFailedWorker.perform(subscription)
      	#SubscriptionMailer.failed_subscription(subscription).deliver
      	flash[:alert] = "Payment is not done yet, here is problem with your card to make the payment!!!"
      	return redirect_to request.referrer
      end
  	else
  		#Create Charges on Stripe
      charge = Stripe::Charge.create(customer: subscription.customer_id, amount: (@plan_or_addon.price * 100).to_i, description: @plan_or_addon.name, currency: @plan_or_addon.currency)
      #Check payment is done or not!
      if charge.paid
      	# Set paid status
      	#subscription.update_attributes(paid: true, is_active: true)
      	subs = @plan_or_addon.subscriptions.create(user_id: current_user.id, customer_id: subscription.customer_id, is_active: true, status: "activated")
      	SubscriptionSuccessWorker.perform(subs)
      	flash[:notice] = "Payment is done successfully and you have subscribed for plan-#{@plan_or_addon.name}"
      else
      	subscription.update_attributes(is_active: false, status: "pending")
      	SubscriptionFailedWorker.perform(subscription)
      	flash[:alert] = "Payment is not done yet, here is problem with your card to make the payment!!!"
      	return redirect_to request.referrer
      end
  	end
  	redirect_to root_path
  end

  def destroy
    subscription = current_user.subscriptions.where(id: params[:id], status: ["pending", "activated"]).first
    if subscription.present?
      subscription.update_attributes(is_active: false, status: "cancel")
      flash[:notice] = "#{subscription.subscriptionable.class.name} has remoed successfully."
    else
      flash[:alert] = "Requested subscription does not exists.."
    end
    redirect_to subscriptions_path
  end

  private

  def check_plan_or_addon
    #Find Plan
    @plan_or_addon = if params[:plan].present?
      Plan.where(name: params[:plan]).first
    else
      Addon.where(name: params[:addon]).first
    end
    return redirect_to request.referrer, alert: "InValid Plan!!!"  if @plan_or_addon.blank?
    redirect_to plans_path, alert: "You have Already Subscribed for this plan..." if current_user.already_subscribe?(@plan_or_addon)
  end

end
