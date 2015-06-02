class User < ActiveRecord::Base
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name

  has_many :subscriptions
  has_many :plans, through: :subscriptions
  def full_name
  	"#{first_name}  #{last_name}"
  end

  def already_subscribe?(obj)
    obj.subscriptions.where(user_id: id).active.last.present?
  end

  def self.check_and_update_subscription
  	User.each do |user|
  	  subscription = user.subscriptions.last
  	  next if subscription.blank?
	  
	  	if subscription.updated_at.next_month.to_date < Time.now.to_date
	  		charge = Stripe::Charge.create(customer: subscription.customer_id, amount: (subscription.subscriptionable.price * 100).to_i, description: subscription.subscriptionable.name, currency: subscription.subscriptionable.currency)
	      if charge.paid
	      	# Set paid status
	      	subs = subscription.subscriptionable.subscriptions.create(user_id: id, customer_id: subscription.customer.id, is_active: true, status: "activated")
	      	SubscriptionSuccessWorker.perform(subs)
	      else
	      	subscription.update_attributes(is_active: false, status: "pending") 
	      	SubscriptionFailedWorker.perform(subscription)
	      end
	  	end
	  
  	end
  end

end
