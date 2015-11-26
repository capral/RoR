class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  has_many :categories_posts
  has_many :categories, through: :categories_posts
  belongs_to :user

  has_many :subscriptions
  has_many :subscribers,
           source: :user, through: :subscriptions

  validates :title, presence: true

  scope :reverse_order, -> (order) { order(created_at: :desc) }
  scope :published, -> { where(published: true)}
  scope :unpublished, -> { where(published: false) }
  def categories_titles
    # categories.map(&:title).join(',  ')
    categories.pluck(:title)
  end

  def send_notification
    # raise Exception
  end

end
