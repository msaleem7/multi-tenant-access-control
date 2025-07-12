class UserSpacesQuery < BaseQuery
  def self.model
    UserSpace
  end

  def list
    @scope
  end
end
