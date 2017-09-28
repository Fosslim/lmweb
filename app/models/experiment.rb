class Experiment < ApplicationRecord
  belongs_to :client
  has_many :results

end
