class House < ApplicationRecord
  has_many :favorites, dependent: :destroy
  validates :name,
            presence: true

  validates :category,
            presence: true

  validates :description,
            presence: true
  validates :photo_url, presence: true
end
