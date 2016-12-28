class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize Membership
    @memberships = Membership.where(contact_id: params[:contact_id])
    @contact = Contact.find(params[:contact_id])
  end


  def show
    authorize @membership
    @contact = @membership.contact
  end

  def new
    @membership = Membership.new
    @contact = Contact.find(params[:contact_id])
    authorize Membership
  end

  def create
    start =  params[:membership]
    params[:membership][:start] = Date.civil(start["start(1i)"].to_i, start["start(2i)"].to_i, start["start(3i)"].to_i)
    @contact = Contact.find(params[:contact_id])
    params[:membership][:contact_id] = params[:contact_id]
    @membership = Membership.new(membership_params)
    authorize @membership
    respond_to do |format|
      if @membership.save
        format.html { redirect_to contacts_path(), notice: 'Membership was successfully created.' }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { redirect_to contact_path(@contact), notice: @membership.errors}
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit
    authorize @membership
    @contact = @membership.contact
  end
  def update
    authorize @membership
    start =  params[:membership]
    params[:membership][:start] = Date.civil(start["start(1i)"].to_i, start["start(2i)"].to_i, start["start(3i)"].to_i)
    stop =  params[:membership]
    params[:membership][:stop] = Date.civil(stop["start(1i)"].to_i, stop["start(2i)"].to_i, stop["start(3i)"].to_i)

    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to contact_memberships_path(@membership.contact), notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:contact_id, :plan_id, :start, :stop)
    end
end
