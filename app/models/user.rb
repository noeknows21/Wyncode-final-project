class User < ActiveRecord::Base
  
  has_secure_password
  validates :name, :email, presence: true, length: {maximum: 75}
  validates :email, uniqueness: { case_sensitive: false },
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :password, length: { minimum: 6 }
end
