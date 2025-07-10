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

FactoryBot.define do
  factory :organisation do
    
  end
end
