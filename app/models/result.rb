class Result < ApplicationRecord
  belongs_to :model
  belongs_to :experiment

  validates :label, presence: true
  validates :score, numericality: true
  validates :exec_time, numericality: true
end
