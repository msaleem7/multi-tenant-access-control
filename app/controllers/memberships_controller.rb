class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organisation
  
  def create
    email = params[:email]
    role = params[:role]
    
    # Find user by email
    user = User.find_by(email: email)
    
    if user.nil?
      redirect_to organisation_path(@organisation), alert: "User with email #{email} not found."
      return
    end
    
    # Check if user is already a member of the organization
    if @organisation.users.include?(user)
      redirect_to organisation_path(@organisation), alert: "User is already a member of this organization."
      return
    end
    
    # Create membership
    membership = @organisation.memberships.new(user: user, role: role)
    
    # Authorize using Pundit
    authorize membership
    
    if membership.save
      redirect_to organisation_path(@organisation), notice: "#{user.first_name} #{user.last_name} has been added to the organization."
    else
      redirect_to organisation_path(@organisation), alert: "Failed to add user to the organization: #{membership.errors.full_messages.join(', ')}"
    end
  end
  
  def destroy
    membership = @organisation.memberships.find(params[:id])
    
    # Authorize using Pundit
    authorize membership
    
    if membership.destroy
      redirect_to organisation_path(@organisation), notice: "Member has been removed from the organization."
    else
      redirect_to organisation_path(@organisation), alert: "Failed to remove member from the organization."
    end
  end
  
  private
  
  def set_organisation
    @organisation = Organisation.find(params[:organisation_id])
  end
end
