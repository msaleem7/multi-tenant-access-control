# == Schema Information
#
# Table name: organisations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_organisations_on_name  (name)
#

# frozen_string_literal: true

class Organisation < ApplicationRecord
  #validations
  validates :name, presence: true, uniqueness: true

  #associations
  has_many :spaces, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
