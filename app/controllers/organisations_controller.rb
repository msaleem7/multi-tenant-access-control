class OrganisationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @organisations = Organisations::ListService.new(current_user).call
  end

  def show
    @spaces = Spaces::ListService.new(current_user, organisation.id).call
  end

  def create
    @organisation = Organisations::CreateService.new(current_user, organisation_params).call

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.append(
          "organisations_list",
          partial: "organisation",
          locals: { organisation: @organisation }
        )
      }
      format.html { redirect_to organisations_path, notice: "Organisation was successfully created." }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "new_organisation_form",
          partial: "form",
          locals: { organisation: e.record }
        )
      }
      format.html { render :new }
    end
  end

  def update
    Organisations::UpdateService.new(current_user, organisation, organisation_params).call
    redirect_to organisation_path(organisation), notice: "organisation was successfully updated to '#{@organisation.name}'."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to organisation_path(organisation), alert: "Failed to update organisation: #{e.record.errors.full_messages.join(', ')}"
  end

  def destroy
    authorize organisation
    Organisations::DestroyService.new(current_user, organisation).call

    redirect_to organisations_path, notice: "Organisation was successfully deleted."
  end

  private

  def organisation
    @organisation ||= Organisations::ReadService.new(current_user).call(params[:id])
  end

  def organisation_params
    params.require(:organisation).permit(:name, configuration: {space_membership: {}})
  end
end
