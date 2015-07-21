namespace :sample_data do
  desc "TODO"
  task create_admins: :environment do
    User.create!(name: "Example User",
      email: "example@railstutorial.org",
      password: "foobar12",
      password_confirmation: "foobar12",
      admin: true)
  end

  desc "TODO"
  task create_users: :environment do
    10.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
        email: email,
        password: password,
        password_confirmation: password)
    end
  end
end
