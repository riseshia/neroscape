FactoryGirl.define do
  factory :review, class: Review do
    id          1
    score       10
    content     'tadfasdf'
    user_id     1
    game_id     1
    reviewed    1
  end
end