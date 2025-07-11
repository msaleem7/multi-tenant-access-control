module Posts
  class UpdateService
    def initialize(current_user, post, params)
      @current_user = current_user
      @post = post
      @params = params
    end

    attr_reader :current_user, :post, :params

    def call
      authorize!
      post.update!(params)

      post
    end

    private

    def authorize!
      Pundit.authorize(current_user, post, :update?)
    end
  end
end
