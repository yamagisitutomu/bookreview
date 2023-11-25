class Comment < ApplicationRecord
  scope :active, -> { where(is_active: true) }
  
  belongs_to :customer
  belongs_to :post
  
  validates :body, presence: true
end
