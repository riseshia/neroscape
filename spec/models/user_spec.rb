require 'rails_helper'

RSpec.describe User, type: :model do
  def create_review(user: reviewer, game: reviewed_game)
    Review.create(
      score: 10,
      content: 'fixture',
      user: user,
      game: game
    )
  end

  describe 'Active Record Associations' do
    it { should have_many(:reviews) }
    it { should have_many(:stacks) }
  end

  describe '#unlocked?' do
    it 'should return true' do
      user = create(:unlock_user)
      expect(user.unlocked?).to be true

      admin = create(:admin)
      expect(admin.unlocked?).to be true
    end

    it 'should return false' do
      user = create(:lock_user)
      expect(user.unlocked?).to be false
    end
  end

  describe '#admin?' do
    it 'should return true' do
      admin = create(:admin)
      expect(admin.admin?).to be true
    end

    it 'should return false' do
      expect(create(:unlock_user).admin?).to be false
      expect(create(:lock_user).admin?).to be false
    end
  end

  describe '#reviewed?' do
    it 'should return true' do
      user = create(:unlock_user)
      game = create(:dummy_game)
      create_review user: user, game: game
      expect(user.reviewed?(game)).to be true
    end

    it 'should return false' do
      user = create(:unlock_user)
      game = create(:dummy_game)
      expect(user.reviewed?(game)).to be false
    end
  end
end
