class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show edit update destroy ]

  # GET /customers or /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to customers_path, notice: "Cliente cadastro com sucesso."
    else
      render :new
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: "Cliente atualizado com sucesso!"
    else
      render :edit
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:id, :name, :email, :phone, :smoker, :avatar)
  end
end
