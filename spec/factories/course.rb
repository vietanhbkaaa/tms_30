FactoryGirl.define do
  factory :course do
    name {Faker::Name.name}
    factory :invalid_name_course do
      name ""
    end
  end
end
