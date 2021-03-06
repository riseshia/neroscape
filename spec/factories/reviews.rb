FactoryGirl.define do
  factory :review, class: Review do
    id 1
    score 10
    content 'Review Text'
    user_id 1
    game_id 1
  end

  factory :invalid_review, class: Review do
    id 1
    score 10
    content 'Review Text'
    user_id nil
    game_id nil
  end
end
