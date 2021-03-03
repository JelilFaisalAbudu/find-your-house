class House < ApplicationRecord
  has_many :favorites, dependent: :destroy
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: {maximum: 20}

  validates :category,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: {maximum: 20}
  
  validates :description,
            presence: true,
            uniqueness: { case_sensitive: false } 
end
