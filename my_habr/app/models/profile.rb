class Profile < ActiveRecord::Base
  belongs_to :user
  # Валидация на уникальность
  # validates :user_id, uniqueness: true
end
