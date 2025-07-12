# Create Users
user1 = User.create!(
  first_name: 'John',
  last_name: 'Doe',
  parental_consent: true,
  age: 25,
  email: 'user1@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

user2 = User.create!(
  first_name: 'Jane',
  last_name: 'Doe',
  parental_consent: true,
  age: 14,
  email: 'user2@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

user3 = User.create!(
  first_name: 'John',
  last_name: 'Doe',
  parental_consent: true,
  age: 18,
  email: 'user3@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

# Create Organisations
org1 = Organisation.create!(name: 'First Organisation')
org2 = Organisation.create!(name: 'Second Organisation')
org3 = Organisation.create!(name: 'Third Organisation')

# Create Memberships
# user1 owns org1 and org2
UserOrganisation.create!(user: user1, organisation: org1, role: Memberships::Roles::OWNER)
UserOrganisation.create!(user: user1, organisation: org2, role: Memberships::Roles::OWNER)

# user2 owns org3
UserOrganisation.create!(user: user2, organisation: org3, role: Memberships::Roles::OWNER)

# user3 is member of all organisations
UserOrganisation.create!(user: user3, organisation: org1, role: Memberships::Roles::MEMBER)
UserOrganisation.create!(user: user3, organisation: org2, role: Memberships::Roles::MEMBER)
UserOrganisation.create!(user: user3, organisation: org3, role: Memberships::Roles::MEMBER)

# user2 is admin in org1 and org2
UserOrganisation.create!(user: user2, organisation: org1, role: Memberships::Roles::ADMIN)
UserOrganisation.create!(user: user2, organisation: org2, role: Memberships::Roles::ADMIN)

# Create Spaces for each organisation with age ranges
# Org1 Spaces
org1_spaces = [
  Space.create!(name: 'Marketing', organisation: org1, min_age: 0, max_age: 99),
  Space.create!(name: 'Sales', organisation: org1, min_age: 13, max_age: 99),
  Space.create!(name: 'Development', organisation: org1, min_age: 18, max_age: 99)
]

# Org2 Spaces
org2_spaces = [
  Space.create!(name: 'Research', organisation: org2, min_age: 13, max_age: 99),
  Space.create!(name: 'Operations', organisation: org2, min_age: 18, max_age: 99),
  Space.create!(name: 'Finance', organisation: org2, min_age: 18, max_age: 99)
]

# Org3 Spaces
org3_spaces = [
  Space.create!(name: 'Product', organisation: org3, min_age: 0, max_age: 99),
  Space.create!(name: 'Engineering', organisation: org3, min_age: 13, max_age: 99),
  Space.create!(name: 'Support', organisation: org3, min_age: 0, max_age: 99)
]

# Create UserSpaces for Owners and Admins
# For org1
org1_spaces.each do |space|
  UserSpace.create!(user: user1, space: space) # owner
  UserSpace.create!(user: user2, space: space) # admin
end

# For org2
org2_spaces.each do |space|
  UserSpace.create!(user: user1, space: space) # owner
  UserSpace.create!(user: user2, space: space) # admin
end

# For org3
org3_spaces.each do |space|
  UserSpace.create!(user: user2, space: space) # owner
end

# Create posts in each space with random age ratings
def create_posts_for_space(space, user)
  5.times do |i|
    age_rating = case space.min_age
                 when 18
                   Posts::AgeRatings::ADULT
                 when 13
                   [Posts::AgeRatings::TEEN, Posts::AgeRatings::ADULT].sample
                 else
                   [Posts::AgeRatings::GENERAL, Posts::AgeRatings::TEEN, Posts::AgeRatings::ADULT].sample
                 end

    Post.create!(
      title: "Post #{i + 1} in #{space.name}",
      content: "This is post number #{i + 1} in the #{space.name} space.",
      age_rating: age_rating,
      user: user,
      space: space
    )
  end
end

# Create posts for org1 spaces (by user1 - owner)
org1_spaces.each { |space| create_posts_for_space(space, user1) }

# Create posts for org2 spaces (by user1 - owner)
org2_spaces.each { |space| create_posts_for_space(space, user1) }

# Create posts for org3 spaces (by user2 - owner)
org3_spaces.each { |space| create_posts_for_space(space, user2) }
