class Plan < ApplicationRecord
  monetize :price_cents
  validates_presence_of :name
  #validates_presence_of :price


end
