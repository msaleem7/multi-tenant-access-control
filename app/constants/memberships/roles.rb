module Memberships
  module Roles
    MEMBER = 0
    ADMIN = 1

    ENUM_MAPPING = {
      MEMBER => "member",
      ADMIN => "admin"
    }.freeze
  end
end
