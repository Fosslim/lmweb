class Client < ApplicationRecord
  validates :name, presence: true
  validates :active, presence: true
end
