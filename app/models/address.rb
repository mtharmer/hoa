# frozen_string_literal: true

class Address < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :address, presence: true
end
