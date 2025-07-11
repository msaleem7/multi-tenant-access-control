module Users
  class CreateService
    def initialize(user, params)
      @user = user
      @params = params
    end

    attr_reader :user, :params

    def call
      user = User.new(params)
      user.save!

      user
    end
  end
end
