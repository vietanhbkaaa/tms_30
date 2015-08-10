FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    avatar "http://www.glbtrt.ala.org/news/wp-content/uploads/2015/06/Spiderman.jpg"
    admin false
    password "abcd1234"
    password_confirmation "abcd1234"

    factory :admin do
      admin true
    end
  end
end