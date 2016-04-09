require 'rails_helper'

RSpec.describe Stack, type: :model do
  describe 'Active Record Validations' do
    it { expect validate_presence_of(:user_id) }
    it { expect validate_presence_of(:game_id) }
  end

  describe 'Active Record Associations' do
    it { expect belong_to(:user) }
    it { expect belong_to(:game) }
  end
end
