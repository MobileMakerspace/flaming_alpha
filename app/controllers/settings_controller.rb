class SettingsController < ApplicationController
  before_action :get_setting, only: [:edit, :update]
  before_action :authenticate_user!
  after_action :verify_authorized
  
  def index
    @settings = Setting.get_all
    authorize Setting
  end

  def edit
    authorize @setting
  end

  def update
    authorize @setting
    if @setting.value != params[:setting][:value]
      @setting.value = params[:setting][:value]
      @setting.save
      redirect_to settings_path, notice: 'Setting has updated.'
    else
      redirect_to settings_path
    end
  end

  def get_setting
    @setting = Setting.find_by(var: params[:id]) || Setting.new(var: params[:id])
  end
end
