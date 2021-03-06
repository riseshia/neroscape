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
    it { expect have_many(:reviews) }
    it { expect have_many(:stacks) }
  end

  describe 'Active Record Validations' do
    it { expect validate_presence_of(:name) }
  end

  describe '#unlocked?' do
    it 'expect return true' do
      user = create(:unlock_user)
      expect(user.unlocked?).to be true

      admin = create(:admin)
      expect(admin.unlocked?).to be true
    end

    it 'expect return false' do
      user = create(:lock_user)
      expect(user.unlocked?).to be false
    end
  end

  describe '#admin?' do
    it 'expect return true' do
      admin = create(:admin)
      expect(admin.admin?).to be true
    end

    it 'expect return false' do
      expect(create(:unlock_user).admin?).to be false
      expect(create(:lock_user).admin?).to be false
    end
  end

  describe '#reviewed?' do
    it 'expect return true' do
      user = create(:unlock_user)
      game = create(:game)
      create_review user: user, game: game
      expect(user.reviewed?(game)).to be true
    end

    it 'expect return false' do
      user = create(:unlock_user)
      game = create(:game)
      expect(user.reviewed?(game)).to be false
    end
  end

  describe '#in_stack?' do
    it 'expect return true' do
      user = create(:unlock_user)
      game = create(:game)
      Stack.create(user: user, game: game)
      expect(user.in_stack?(game)).to be true
    end

    it 'expect return false' do
      user = create(:unlock_user)
      game = create(:game)
      expect(user.in_stack?(game)).to be false
    end
  end
end
