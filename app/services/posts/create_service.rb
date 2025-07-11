module Posts
  class CreateService
    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    attr_reader :current_user, :params

    def call
      authorize!
      post.save!

      post
    end

    private

    def authorize!
      Pundit.authorize(current_user, post, :create?)
    end

    def post
      @post ||= Post.new(params.merge(user: current_user, space: space))
    end

    def space
      @space ||= Spaces::ReadService.new(current_user).call(params[:space_id])
    end
  end
end
