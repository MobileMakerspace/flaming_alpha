class KeysController < ApplicationController
  before_action :set_key, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  # GET /keys
  # GET /keys.json
  def index
    @keys = Key.all
    authorize Key
  end

  # GET /keys/1
  # GET /keys/1.json
  def show
    authorize @key
  end

  # GET /keys/new
  def new
    @key = Key.new
    authorize Key
  end

  # GET /keys/1/edit
  def edit
    authorize @key
  end

  # POST /keys
  # POST /keys.json
  def create
    @key = Key.new(key_params)
    authorize @key
    respond_to do |format|
      if @key.save
        format.html { redirect_to @key, notice: 'Key was successfully created.' }
        format.json { render :show, status: :created, location: @key }
      else
        format.html { render :new }
        format.json { render json: @key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keys/1
  # PATCH/PUT /keys/1.json
  def update
    authorize @key
    if @key.assigned.nil?
      @key.returned = nil
      @key.assigned = Date.today
    elsif @key.returned.nil?
      @key.assigned = nil
      @key.returned = Date.today
    end
    respond_to do |format|
      if @key.save
        format.html { redirect_to @key, notice: 'Key was successfully updated.' }
        format.json { render :show, status: :ok, location: @key }
      else
        format.html { render :edit }
        format.json { render json: @key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keys/1
  # DELETE /keys/1.json
  def destroy
    authorize @key
    @key.destroy
    respond_to do |format|
      format.html { redirect_to keys_url, notice: 'Key was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_key
      @key = Key.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def key_params
      params.require(:key).permit(:id, :identifier, :user_id)
    end
end
