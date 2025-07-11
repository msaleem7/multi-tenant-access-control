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
    
  end
end
