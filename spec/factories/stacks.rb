FactoryGirl.define do
  factory :stack01, class: Stack do
    game_id 1
    user_id 1
  end

  factory :invalid_stack, class: Stack do
    game_id nil
    user_id nil
  end
end
