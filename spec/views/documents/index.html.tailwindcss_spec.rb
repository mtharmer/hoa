# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'documents/index', type: :view do
  let(:user) { create(:user, admin: true) }

  before do
    sign_in user
  end

  describe 'without documents' do
    before do
      assign(:documents, [])
    end

    it 'renders a message indicating no documents are available' do
      render
      expect(rendered).to match(/No documents found/i)
    end
  end

  describe 'with documents' do
    before do
      assign(:documents, create_list(:document, 2))
    end

    it 'renders a list of documents' do
      render
      cell_selector = 'div>div>a'
      assert_select cell_selector, text: Regexp.new('test_document_1.pdf'), count: 2
    end
  end
end
