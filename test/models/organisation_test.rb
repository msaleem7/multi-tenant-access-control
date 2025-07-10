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

require "test_helper"

class OrganisationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
