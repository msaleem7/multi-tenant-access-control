# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  content    :text             not null
#  min_age    :integer
#  user_id    :integer          not null
#  space_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_posts_on_space_id              (space_id)
#  index_posts_on_user_id               (user_id)
#  index_posts_on_user_id_and_space_id  (user_id,space_id) UNIQUE
#

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 4) }
    content { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    age_rating { Posts::AgeRatings::GENERAL }
    association :user
    association :space
    
    trait :teen do
      age_rating { Posts::AgeRatings::TEEN }
    end
    
    trait :adult do
      age_rating { Posts::AgeRatings::ADULT }
    end
  end
end
