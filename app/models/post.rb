class Post < ApplicationRecord
  scope :active, -> { where(is_active: true) }
  
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(review: content)
    elsif method == 'forward'
      Post.where('review LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('review LIKE ?', '%' + content)
    else
      Post.where('review LIKE ?', '%' + content + '%')
    end
  end
  
  
  belongs_to :customer
  belongs_to :book, primary_key: "isbn"
  has_many :comments, dependent: :destroy
  
  validates :star, presence: true
  validates :review, presence: true
end
