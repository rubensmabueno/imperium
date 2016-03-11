FactoryGirl.define do
  factory :user do
    name 'John Doe'
    provider 'github'
    uid '123'
  end
end
