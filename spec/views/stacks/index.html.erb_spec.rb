require 'rails_helper'

RSpec.describe 'stacks/index', type: :view do
  before(:each) do
    assign(:stacks, [
      create(:stack01)
    ])
  end

  it 'renders a list of stacks' do
    @user = create(:unlock_user)
    sign_in @user
    render
  end
end
