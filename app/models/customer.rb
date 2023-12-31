class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && is_active
  end
  
  scope :active, -> { where(is_active: true) }
  

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def has_posted_for_book?(book)
    posts.exists?(book: book)
  end
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :birthdate, presence: true
  validates :gender, presence: true
end
