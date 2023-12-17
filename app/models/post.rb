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
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags
  
  
  
  validates :star, presence: true
  validates :review, presence: true
  #belongs_to のオプションを設定して、customer_id と book_id の組み合わせがユニークであるようにして複数投稿を防ぐ
  validates_uniqueness_of :customer_id, scope: :book_id
end
