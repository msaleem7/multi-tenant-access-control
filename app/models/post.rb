# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  content    :text             not null
#  age_rating :integer          not null, default: 0
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

class Post < ApplicationRecord
  enum :age_rating, Posts::AgeRatings::ENUM_MAPPING,
       default: Posts::AgeRatings::GENERAL,
       validate: true

  # validations
  validates :title, presence: true
  validates :content, presence: true

  # associations
  belongs_to :user
  belongs_to :space
end
