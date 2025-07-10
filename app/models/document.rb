# frozen_string_literal: true

class Document < ApplicationRecord
  has_one_attached :file

  validates :file, presence: true

  def sanitize
    file.filename = ::Util.sanitize_filename(file.filename.to_s) if file.attached? && file.filename.present?
    self
  end

  def purge_file
    file&.purge
  end
end
