class Result < ApplicationRecord
  belongs_to :model
  belongs_to :experiment

  validates :score, numericality: true
  validates :exec_time, numericality: true
end
