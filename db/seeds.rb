users = [
  {
    email: 'admin@gmail.com', password: 'abcabc', admin: 'true'
  },
  {
    email: 'user_first@gmail.com', password: 'abcabc'
  },
  {
    email: 'user_second@gmail.com', password: 'abcabc'
  }
]

User.create(users)

ad_types = [
  {
    name: 'first_type'
  },
  {
    name: 'second_type'
  }
]

AdType.create(ad_types)

12.times do
  Ad.create(
    ad_type_id: 1,
    user_id: 2,
    status: 'published_ad',
    title: Faker::ProgrammingLanguage.name,
    description: Faker::Hipster.paragraphs(number: 6)
  )
end

12.times do
  Ad.create(
    ad_type_id: 2,
    user_id: 3,
    status: 'published_ad',
    title: Faker::ProgrammingLanguage.name,
    description: Faker::Hipster.paragraphs(number: 6)
  )
end

12.times do
  Ad.create(
    ad_type_id: 1,
    user_id: 2,
    status: 'draft_ad',
    title: Faker::ProgrammingLanguage.name,
    description: Faker::Hipster.paragraphs(number: 6)
  )
end

12.times do
  Ad.create(
    ad_type_id: 2,
    user_id: 3,
    status: 'draft_ad',
    title: Faker::ProgrammingLanguage.name,
    description: Faker::Hipster.paragraphs(number: 6)
  )
end

5.times do
  Ad.create(
    ad_type_id: 2,
    user_id: 2,
    status: 'archived_ad',
    title: Faker::ProgrammingLanguage.name,
    description: Faker::Hipster.paragraphs(number: 6)
  )
end

5.times do
  Ad.create(
    ad_type_id: 2,
    user_id: 3,
    status: 'archived_ad',
    title: Faker::ProgrammingLanguage.name,
    description: Faker::Hipster.paragraphs(number: 6)
  )
end

5.times do
  Ad.create(
    ad_type_id: 2,
    user_id: 2,
    status: 'canceled_ad',
    title: Faker::ProgrammingLanguage.name,
    description: Faker::Hipster.paragraphs(number: 6)
  )
end

5.times do
  Ad.create(
    ad_type_id: 2,
    user_id: 3,
    status: 'canceled_ad',
    title: Faker::ProgrammingLanguage.name,
    description: Faker::Hipster.paragraphs(number: 6)
  )
end
