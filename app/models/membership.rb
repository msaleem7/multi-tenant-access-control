# == Schema Information
#
# Table name: memberships
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  organisation_id  :integer          not null
#  role             :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_memberships_on_organisation_id              (organisation_id)
#  index_memberships_on_user_id                      (user_id)
#  index_memberships_on_user_id_and_organisation_id  (user_id,organisation_id) UNIQUE
#

# frozen_string_literal: true

class Membership < ApplicationRecord
  #enums
  enum :role, Memberships::Roles::ENUM_MAPPING,
       default: Memberships::Roles::MEMBER,
       validate: true

  #validations
  validates :user_id, :organisation_id, presence: true
  validates :user_id, uniqueness: { scope: :organisation_id }

  #associations
  belongs_to :user
  belongs_to :organisation
end
