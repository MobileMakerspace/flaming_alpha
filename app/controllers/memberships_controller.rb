# app/controller/memberships_controller.rb
class MembershipsController < ApplicationController
  def new
    @contact_membership_form = ContactMembershipForm.new
  end

  def create
    @contact_membership_form = ContactMembershipForm.new(contact_membership_form_params)
    if @contact_membership_form.save
      redirect_to contacts_url, notice: "Membership was successfully created"
    else
      render :new
    end
  end

  private

  # Using strong parameters
  def contact_membership_form_params
    params.require(:contact_membership_form).permit(:name,:email,:addr_1, :addr_2,:city,:state,:zip,:phone,
        :emergency_phone, :emergency_name, :plan_id, :start, :stop)
  end
end
