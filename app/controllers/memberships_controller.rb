# app/controller/memberships_controller.rb
class MembershipsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def new
    @contact_membership_form = ContactMembershipForm.new
    authorize ContactMembershipForm
  end

  def create
    # format the date for rails
    start =  params[:contact_membership_form]
    params[:contact_membership_form][:start] = Date.civil(start["start(1i)"].to_i, start["start(2i)"].to_i, start["start(3i)"].to_i)
    # move the plan_id to contact_membership_form
    params[:contact_membership_form][:plan_id] = params[:membership][:plan_id]
    @contact_membership_form = ContactMembershipForm.new(contact_membership_form_params)
    authorize ContactMembershipForm
    if @contact_membership_form.save
      redirect_to memberships_url, notice: "Membership was successfully created"
    else
      render :new
    end
  end

  def index
    @memberships = Membership.all
    authorize @memberships
  end

  def show
    @membership = Membership.find(params[:id])
    authorize @membership
    @contact = @membership.contact
  end

  private

  # Using strong parameters
  def contact_membership_form_params
    params.require(:contact_membership_form).permit(:name,:email,:addr_1, :addr_2,:city,:state,:zip,:phone,
        :emergency_phone, :emergency_name, :start, :stop, :plan_id)
  end
end
