class App < ApplicationRecord
  validates :name, :app_id, presence: true
  validates :app_id, uniqueness: true
end
