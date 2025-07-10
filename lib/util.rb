# frozen_string_literal: true

class Util
  def self.to_sentence(resource)
    resource.errors.full_messages.to_sentence
  end

  def self.pluralize(resource)
    resource.class.name.underscore.pluralize.downcase
  end

  def self.sanitize_filename(filename)
    filename.strip.tap do |name|
      # Get only the filename, not the whole path
      name.sub!(%r{\A.*(\\|/)}, '')
      # Replace all non-alphanumeric, underscore or periods with underscore
      name.gsub!(/[^\w.-]/, '_')
    end
  end
end
