require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Active Record Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:game_id) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:score) }
    it { should validate_length_of(:content).is_at_most(10_000) }
    it { should validate_inclusion_of(:neta).in_range(0..1) }
    it do
      should validate_numericality_of(:score)
        .is_less_than_or_equal_to(100)
        .is_greater_than_or_equal_to(0)
    end
  end

  describe 'Active Record Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:game) }
  end

  describe '#all' do
    it 'should have 1 review' do
      create(:review)
      size = Review.all.count
      expect(size).to be(1)
    end
  end
end
