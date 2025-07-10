# == Schema Information
#
# Table name: spaces
#
#  id                         :integer          not null, primary key
#  name                       :string           not null
#  description                :text
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  organisation_id            :integer          not null
#  min_age                    :integer
#  max_age                    :integer
#  requires_parental_consent  :boolean
#
# Indexes
#
#  index_spaces_on_organisation_id              (organisation_id)
#  index_spaces_on_name                         (name)
#

# frozen_string_literal: true

class Space < ApplicationRecord
  #validations
  validates :name, presence: true, uniqueness: { scope: :organisation_id }

  #associations
  belongs_to :organisation
  has_many :user_spaces, dependent: :destroy
  has_many :users, through: :user_spaces
end
