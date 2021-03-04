class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :house

  validates :user_id, presence: true
  validates :house_id, presence: true
end
