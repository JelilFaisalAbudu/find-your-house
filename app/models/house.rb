class House < ApplicationRecord
  has_many :favorites, dependent: :destroy
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: {maximum: 20}

  validates :type,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: {maximum: 20}
  
  validates :description,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: {maximum: 100} 
end