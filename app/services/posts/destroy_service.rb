module Posts
  class DestroyService
    def initialize(current_user, post)
      @current_user = current_user
      @post = post
    end

    attr_reader :current_user, :post

    def call
      authorize!
      post.destroy!

      post
    end

    private

    def authorize!
      Pundit.authorize(current_user, post, :destroy?)
    end
  end
end
