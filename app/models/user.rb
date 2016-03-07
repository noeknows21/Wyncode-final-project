class User < ActiveRecord::Base
  has_many :videos, dependent: :destroy
  has_secure_password
  # validates :name, :email, presence: true, length: {maximum: 75}
  # validates :email, uniqueness: { case_sensitive: false },
  #           format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  # validates :password, length: { minimum: 6 }
  validate :repcode, :repcode_validate
  
  def repcode_validate
    if repcode == ""
      return
    elsif repcode != "abc"
      errors.add(:repcode, "is not valid")
    end
  end
end
