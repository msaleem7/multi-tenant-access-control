module Posts
  module AgeRatings
    GENERAL = "general".freeze
    TEEN = "teen".freeze
    ADULT = "adult".freeze

    ENUM_MAPPING = {
      GENERAL => 0,
      TEEN => 13,
      ADULT => 18
    }.freeze
  end
end
