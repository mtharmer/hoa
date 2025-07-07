# frozen_string_literal: true

class Address < ApplicationRecord
  has_many :users, dependent: :restrict_with_error

  validates :address, presence: true
end
