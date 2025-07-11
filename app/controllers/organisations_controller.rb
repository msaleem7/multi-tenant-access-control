class OrganisationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organisation, only: [:show, :destroy]

  def index
    @organisations = Organisations::ListService.new.call
  end

  def show
    @spaces = @organisation.spaces
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

  def destroy
    @organisation = Organisations::ReadService.new(params[:id]).call
    Organisations::DestroyService.new(current_user, @organisation).call

    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.remove(@organisation)
      }
      format.html { redirect_to organisations_path, notice: "Organisation was successfully deleted." }
    end
  end

  private

  def set_organisation
    @organisation = Organisation.find(params[:id])
  end

  def organisation_params
    params.require(:organisation).permit(:name)
  end
end
