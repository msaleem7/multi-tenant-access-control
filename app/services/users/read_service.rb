module Users
  class ReadService
    def initialize(current_user, id)
      @current_user = current_user
      @id = id
    end

    attr_reader :current_user, :id

    def call
      authorize!
      user
    end

    private

    def user
      @user ||= User.find(id)
    end

    def authorize!
      Pundit.authorize(current_user, user, :show?)
    end
  end
end
