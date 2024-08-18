class User < ApplicationRecord
  has_many :applications
  has_many :shifts, :through => :applications
  has_many :supports
  has_many :companies, :through => :supports
  
  has_secure_password

  validates :email, uniqueness: true
  validates_format_of :email, with: /\A[^@]+@([^@.]+\.)+[^@.]+\z/

  def full_name
    "#{first_name} #{last_name}"
  end
end
