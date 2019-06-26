FactoryBot.define do

  factory :message do
    body       {Faker::Lorem.sentence}
    # image      {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg'), 'image/jpeg')}
    image {File.open("#{Rails.root}/spec/fixtures/test.jpg")}
    created_at {Faker::Time.between(2.days.ago, Time.now, :all)}
    group
    user
  end

end