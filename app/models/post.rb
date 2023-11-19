class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :book, primary_key: "isbn"
  
  validates :review, presence: true
  
end
