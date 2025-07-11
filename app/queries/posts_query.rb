class PostsQuery < BaseQuery
  def self.model
    Post
  end

  def list(space, params = {})
    @space = space

    filter(params)
    scope
  end

  private

  attr_reader :space

  def filter(params)
    filter_by_space
    filter_by_age_rating
  end

  def filter_by_space
    @scope = scope.where(space_id: space.id)
  end

  def filter_by_age_rating
    return if space.nil? || user_is_org_owner_or_admin?

    @scope = scope.where(age_rating: filterable_age_ratings)
  end

  def user_is_org_owner_or_admin?
    current_user.memberships.where(
      organisation_id: space.organisation_id,
      role: [Memberships::Roles::ADMIN, Memberships::Roles::OWNER]
    ).exists?
  end

  def filterable_age_ratings
    age = current_user.age
    rating_map = Posts::AgeRatings::ENUM_MAPPING

    if age >= rating_map[Posts::AgeRatings::ADULT]
      rating_map.keys
    elsif age >= rating_map[Posts::AgeRatings::TEEN]
      [Posts::AgeRatings::GENERAL, Posts::AgeRatings::TEEN]
    else
      [Posts::AgeRatings::GENERAL]
    end
  end
end
