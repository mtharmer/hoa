# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    file do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_document_1.pdf'),
                                   'application/pdf')
    end
  end
end
