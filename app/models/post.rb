class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :book, primary_key: "isbn"
  
  
  
  validates :star, presence: true
  validates :review, presence: true
end
