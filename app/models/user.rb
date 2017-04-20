class User < ApplicationRecord
  has_many :events, foreign_key: :created_by
  has_secure_password
  validates_presence_of :name, :email, :password_digest
end
