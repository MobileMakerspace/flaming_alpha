class MembersController < ApplicationController
  before_action :set_members, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @members = Contact.joins(:memberships).where('contacts.id is not null').group('contacts.id')
    authorize @members
  end


  def show
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_members
      @membership = Membership.find(params[:id])
    end
end
