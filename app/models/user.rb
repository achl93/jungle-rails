class User < ActiveRecord::Base

  has_secure_password
  has_many :orders
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 5..20 }

  def self.authenticate_with_credentials(email, password)
    user_email = email.strip.downcase
    user = User.find_by(email: user_email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
