require 'rails_helper'

RSpec.describe Review, :type => :model do
  describe '#all' do
    it 'should have 1 review' do
      create(:review)
      size = Review.all.count
      expect(size).to be(1)
    end
  end
end