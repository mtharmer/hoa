# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/posts').to route_to('posts#index')
    end

    it 'routes to #new' do
      expect(get: '/posts/new').to route_to('posts#new')
    end

    it 'routes to #create' do
      expect(post: '/posts').to route_to('posts#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/posts/1').to route_to('posts#destroy', id: '1')
    end
  end
end
