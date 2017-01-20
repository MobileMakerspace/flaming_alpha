class AccountsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize Account
    @lines = DoubleEntry::Line.all

  end

  def show
    authorize params[:id]
    @lines = DoubleEntry::Line.where(scope: params[:id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:user_id)
  end
end
