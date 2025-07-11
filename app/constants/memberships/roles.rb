module Memberships
  module Roles
    OWNER = "owner".freeze
    ADMIN = "admin".freeze
    MEMBER = "member".freeze

    ENUM_MAPPING = {
      OWNER => 0,
      ADMIN => 1,
      MEMBER => 2
    }.freeze
  end
end
