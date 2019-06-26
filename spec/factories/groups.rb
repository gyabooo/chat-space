FactoryBot.define do

  factory :group do
    # my answer
    #name       {"test_user"}
    name       {Faker::Team.name}
    created_at {Faker::Time.between(2.days.ago, Time.now, :all)}
  end

end