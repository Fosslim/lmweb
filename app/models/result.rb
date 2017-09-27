class Result < ApplicationRecord
  has_one :model
  belongs_to :client

  validates :label, presence: true
  validates :score, numericality: true
  validates :exec_time, numericality: true
end
