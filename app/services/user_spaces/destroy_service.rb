module UserSpaces
  class DestroyService
    def initialize(current_user, user_space)
      @current_user = current_user
      @user_space = user_space
    end

    attr_reader :current_user, :user_space

    def call
      authorize!
      user_space.destroy!

      user_space
    end

    private

    def authorize!
      Pundit.authorize(current_user, user_space, :destroy?)
    end
  end
end
