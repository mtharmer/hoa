# frozen_string_literal: true

json.extract! document, :id, :file, :created_at, :updated_at
json.url document_url(document, format: :json)
json.file url_for(document.file)
