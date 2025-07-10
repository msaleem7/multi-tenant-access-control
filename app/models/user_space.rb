# == Schema Information
#
# Table name: user_spaces
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  space_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_spaces_on_space_id              (space_id)
#  index_user_spaces_on_user_id               (user_id)
#  index_user_spaces_on_user_id_and_space_id  (user_id,space_id) UNIQUE
#

# frozen_string_literal: true

class UserSpace < ApplicationRecord
  #associations
  belongs_to :user
  belongs_to :space
end
