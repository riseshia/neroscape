FactoryGirl.define do
  factory :unlock_user, class: User do
    id          1
    email       "unlock@test.com"
    password    "asdfasdf"
    level       1
    name        "Unlock"
  end

  factory :lock_user, class: User do
    id          2
    email       "lock@test.com"
    password    "asdfasdf"
    level       0
    name        "Lock"
  end

  factory :admin, class: User do
    id          3
    email       "admin@test.com"
    password    "asdfasdf"
    level       999
    name        "Admin"
  end
end