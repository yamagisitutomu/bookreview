class Post < ApplicationRecord
  scope :active, -> { where(is_active: true) }
  
  def self.search_for(content, method)
    if method == 'perfect'
      Post.joins(:customer).where('posts.review = ? AND customers.is_active = ?', content, true)
    elsif method == 'forward'
      Post.joins(:customer).where('posts.review LIKE ? AND customers.is_active = ?', content + '%', true)
    elsif method == 'backward'
      Post.joins(:customer).where('posts.review LIKE ? AND customers.is_active = ?', '%' + content, true)
    else
      Post.joins(:customer).where('posts.review LIKE ? AND customers.is_active = ?', '%' + content + '%', true)
    end
  end
  
  belongs_to :customer
  belongs_to :book, primary_key: "isbn"
  has_many :comments, dependent: :destroy
  
  validates :star, presence: true
  validates :review, presence: true
end
