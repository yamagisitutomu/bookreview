class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :book, primary_key: "isbn"
  has_many :comments, dependent: :destroy
  
  
  validates :star, presence: true
  validates :review, presence: true
end
