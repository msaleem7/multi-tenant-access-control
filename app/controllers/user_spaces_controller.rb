class UserSpacesController < ApplicationController
  before_action :authenticate_user!

  def create
    new_user_space = UserSpaces::CreateService.new(current_user, user_space_params).call

    respond_to do |format|
      format.html { redirect_to space_path(new_user_space.space), notice: "You've joined the space." }
      format.turbo_stream { 
        flash[:notice] = "You've joined the space."
        render turbo_stream: turbo_stream.replace(
          "space_actions",
          partial: "spaces/actions",
          locals: { space: new_user_space.space }
        )
      }
    end
  rescue StandardError => e
    redirect_to space_path(@space), alert: e.message
  end

  def destroy
    space = user_space.space
    UserSpaces::DestroyService.new(current_user, user_space).call

    respond_to do |format|
      format.html { redirect_to space_path(space), notice: "Successfully left the space." }
      format.turbo_stream {
        flash[:notice] = "You've left the space."

        render turbo_stream: [
          turbo_stream.replace(
            "space_actions",
            partial: "spaces/actions",
            locals: { space: space }
          ),
          flash_turbo_stream
        ]
      }
    end
  rescue StandardError => e
    redirect_to organisations_path, alert: "Could not leave space. #{e.message}"
  end

  private

  def user_space
    UserSpaces::ListService.new(current_user).call.find(params[:id])
  end

  def user_space_params
    { space_id: params[:space_id] }
  end
end
