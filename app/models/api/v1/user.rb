module Api
  module V1
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :amount, presence: true
end
  end
end
