FactoryGirl.define do
  factory :unlock_user, class: User do
    email       "unlock@test.com"
    password    "asdfasdf"
    level       1
    name        "Unlock"
  end
end