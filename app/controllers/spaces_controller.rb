class SpacesController < ApplicationController
  before_action :authenticate_user!

  def show
    @users = space.users.includes(:user_spaces)
  end

  def new
    @space = organisation.spaces.build
  end

  def create
    @space = Spaces::CreateService.new(current_user, space_params.merge(organisation: organisation)).call

    respond_to do |format|
      format.html { redirect_to organisation_path(organisation), notice: "Space was successfully created." }
      format.turbo_stream { 
        render turbo_stream: turbo_stream.append(
          "spaces_list",
          partial: "space",
          locals: { space: @space }
        )
      }
    end
  rescue StandardError => e
    @space = organisation.spaces.build(space_params)
    @space.errors.add(:base, e.message)
    render :new, status: :unprocessable_entity
  end

  def destroy
    space = Spaces::DestroyService.new(current_user, space).call

    if space.errors.any?
      render :show, status: :unprocessable_entity
    else
      respond_to do |format|
        format.html { redirect_to organisation_path(organisation), notice: "Space was successfully deleted." }
        format.turbo_stream { 
          render turbo_stream: turbo_stream.remove(space)
        }
      end
    end
  end

  private

  def organisation
    @organisation ||= Organisations::ReadService.new(params[:organisation_id]).call
  end

  def space
    @space ||= Space.find(params[:id])
  end

  def space_params
    params.require(:space).permit(:name, :description, :min_age, :max_age, :requires_parental_consent)
  end
end
