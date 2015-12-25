require 'rails_helper'

RSpec.describe Stack, type: :model do
  describe 'Active Record Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:game_id) }
  end

  describe 'Active Record Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:game) }
  end
end
