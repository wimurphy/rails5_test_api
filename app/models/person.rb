class Person < ApplicationRecord
  belongs_to :event
  validates_presence_of :name, :email, :company
end
