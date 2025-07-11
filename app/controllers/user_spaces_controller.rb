class UserSpacesController < ApplicationController
  before_action :authenticate_user!

  def create
    user_space = UserSpaces::CreateService.new(current_user, user_space_params).call

    respond_to do |format|
      format.html { redirect_to organisation_space_path(user_space.space.organisation, user_space.space), notice: "Successfully joined the space." }
      format.turbo_stream { 
        render turbo_stream: turbo_stream.replace(
          "space_actions",
          partial: "spaces/actions",
          locals: { space: user_space.space }
        )
      }
    end
  rescue StandardError => e
    redirect_to organisation_space_path(space.organisation, space), alert: e.message
  end

  def destroy
    user_space = UserSpaces::DestroyService.new(current_user, user_space).call

    respond_to do |format|
      format.html { redirect_to organisation_space_path(user_space.space.organisation, user_space.space), notice: "Successfully left the space." }
      format.turbo_stream { 
        render turbo_stream: turbo_stream.replace(
          "space_actions",
          partial: "spaces/actions",
          locals: { space: user_space.space }
        )
      }
    end
  rescue StandardError => e
    redirect_to organisation_space_path(space.organisation, space), alert: e.message
  end

  private

  def space
    @space ||= Space.find(params[:space_id])
  end

  def user_space_params
    { space_id: space.id }
  end
end
