class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one :profile
  has_many :posts

  has_many :subscriptions
  has_many :subscribed_posts,
           source: :post, through: :subscriptions



  def author_of?(object)
    id == object.user_id
  end

 def subscribed_to?(post)
   !!subscriptions.where(post)
 end

  def subscription_for(post)
    subscriptions.where(post: post).first
  end
end
