class Client < ApplicationRecord
  has_many :experiments

  validates :name, presence: true
  validates :active, presence: true
end
