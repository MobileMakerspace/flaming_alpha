class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @contact = Contact.find(params[:contact_id])
  end

  # GET /invoices/new
  def new
    @contact = Contact.find(params[:contact_id])
    @invoice = Invoice.new( currency: 'usd') #@contact.member_invoices.new
    @invoice.due_date = Time.now
    @invoice.currency = 'usd'
    7.times do
      @invoice.line_items.build()
    end
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.status = "open"
    @invoice.issue_date = Time.now
    @invoice.currency = 'usd'
    @invoice.due_date = Time.now
    @contact = Contact.find(params[:contact_id])
    @invoice.recipient_id = @contact.id
    @invoice.sender_id = nil

    pp @invoice
    pp @invoice.line_items.each do |li|
      pp li
    end
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to contact_memberships_path(@contact), notice: 'Invoice was successfully created.' }#{ redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      pp params
      params.require(:invoice).permit(:description, :due_date, :identifier, {:line_items_attributes => [:description, :quantity,:unit_price,:id]},
                                          invoicing_line_items: [ :description, :quantity, :tax_rate, :unit_price, :id])
    end
end
