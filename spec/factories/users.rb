FactoryBot.define do

  factory :user do
    # email      {"testAAA@testAAA.local"}
    # password   {"00000000"}
    # created_at {Faker::Time.between(2.days.ago, Time.now, :all)}
    # name       {'test_user'}
    password = Faker::Internet.password(8)
    name {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {password}
    # password_confirmation {password}
  end

end