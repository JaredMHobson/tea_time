class Api::V1::Tea < ApplicationRecord
  validates :title, :description, :temperature, :brew_time, presence: true
end
