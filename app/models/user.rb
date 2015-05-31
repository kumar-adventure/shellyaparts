class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name

  has_many :subscriptions

  def full_name
  	"#{first_name}  #{last_name}"
  end

  def self.check_and_update_subscription
  	User.each do |user|
  	  subscription = user.subscriptions.last
  	  next if subscription.blank?
	  
	  	if subscription.updated_at.next_month.to_date < Time.now.to_date
	  		charge = Stripe::Charge.create(customer: subscription.customer_id, amount: (subscription.plan.price * 100).to_i, description: subscription.plan.name, currency: subscription.plan.currency)
	      if charge.paid
	      	# Set paid status
	      	subs = subscriptions.create(plan_id: subscription.plan.id, customer_id: subscription.customer.id, paid: true, is_active: true)
	      	SubscriptionSuccessWorker.perform(subs)
	      else
	      	subscription.update_attributes(paid: false, is_active: false) 
	      	SubscriptionFailedWorker.perform(subscription)
	      end
	  	end
	  
  	end
  end

end
