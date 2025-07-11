module Users
  class DestroyService
    def initialize(current_user, user)
      @current_user = current_user
      @user = user
    end

    attr_reader :current_user, :user

    def call
      authorize!
      user.destroy!

      user
    end

    private

    def authorize!
      Pundit.authorize(current_user, user, :destroy?)
    end
  end
end