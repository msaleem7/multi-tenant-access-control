class SpacesController < ApplicationController
  before_action :authenticate_user!

  def show
    @space = Space.find(params[:id])
    authorize(@space)

    @recent_posts = @space.posts.includes(:user).order(created_at: :desc).limit(5)
  end

  def new
    @space = organisation.spaces.build
  end

  def edit
  end

  def create
    @space = organisation.spaces.build(space_params)

    # Create the space using the service
    @space = Spaces::CreateService.new(current_user, space_params.merge(organisation: organisation)).call
    
    # Get the organisation ID for redirect
    org_id = @space.organisation_id

    respond_to do |format|
      # Use status: :see_other for proper redirect after POST
      format.html { redirect_to organisation_path(org_id), status: :see_other, notice: "Space was successfully created." }
      format.turbo_stream { 
        render turbo_stream: turbo_stream.append(
          "spaces_list",
          partial: "spaces/space",
          locals: { space: @space }
        )
      }
    end
  rescue StandardError => e
    @space = organisation.spaces.build(space_params)
    @space.errors.add(:base, e.message)
    render :new, status: :unprocessable_entity
  end

  def update
    if @space.update(space_params)
      redirect_to space_path(@space), notice: "Space was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @space
    space = Spaces::DestroyService.new(current_user, @space).call

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

  def space
    @space ||= Spaces::ReadService.new(current_user).call(params[:id])
  end

  def spaces
    @spaces ||= Spaces::ListService.new(current_user, organisation.id).call
  end

  def organisation
    @organisation ||= Organisations::ReadService.new(current_user).call(params[:organisation_id] || @space&.organisation_id)
  end

  def space_params
    params.require(:space).permit(:name, :description, :min_age, :max_age, :requires_parental_consent)
  end
end
