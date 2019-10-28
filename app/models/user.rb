class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, :email, presence: true

  # validates :username, uniqueness: true
  # validates :username, :email, :password, presence: true
  # validates :email, confirmation: true
  # this validates for when we have a 2nd text field to confirm email

  # validates :password, confirmation: true
  # this validates for when we have a 2nd text field to confirm password

  def slug
    self.username.downcase.gsub(" ", "-")
  end
end
