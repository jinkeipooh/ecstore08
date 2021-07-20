FactoryBot.define do
  factory :item do
    name                  {'free-name'}
    text                  {'free-text'}
    category_id           {Faker::Number.between(from: 2, to: 11)}
    price                 {'12000'}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'),filename: 'test_image.png')
    end
  end
end
