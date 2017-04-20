class Event < ApplicationRecord
  has_many :people, dependent: :destroy

  validates_presence_of :name, :created_by
end
