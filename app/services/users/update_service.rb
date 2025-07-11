module Users
  class UpdateService
    def initialize(current_user, user, params)
      @current_user = current_user
      @user = user
      @params = params
    end

    attr_reader :current_user, :user, :params

    def call
      authorize!

      user.update!(params)
      user
    end

    private

    def authorize!
      Pundit.authorize(current_user, user, :update?)
    end
  end
end
