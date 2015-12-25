require 'rails_helper'

RSpec.describe StacksController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/stacks').to route_to('stacks#index')
    end

    it 'routes to #destroy' do
      expect(delete: '/stacks/1').to route_to('stacks#destroy', id: '1')
    end
  end
end
