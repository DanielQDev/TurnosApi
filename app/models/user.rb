class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates_format_of :email, with: /\A[^@]+@([^@.]+\.)+[^@.]+\z/

  def full_name
    "#{first_name} #{last_name}"
  end
end
