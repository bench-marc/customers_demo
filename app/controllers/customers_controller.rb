# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :find_customer, only: %i[show edit update]

  def new
    @customer = Customer.new(default_customer_params)
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to customer_path(@customer), notice: 'Customer successfully created', data: { 'turbo-frame' => :customer }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    return unless customer_not_found

    redirect_to_customers_path_with_alert
  end

  def edit
    return unless customer_not_found

    redirect_to_customers_path_with_alert
  end

  def update
    return unless customer_not_found

    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Customer successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @customers = Customer.all
  end

  private

  def customer_params
    params.require(:customer).permit(:firstname, :lastname, :email, :birthdate, :username,
                                     address_attributes: %i[id street housenumber zip city])
  end

  def default_customer_params
    {
      email: 'test@test.de',
      username: 'username',
      birthdate: '01.01.1999',
      firstname: 'Max',
      lastname: 'Mustermann',
      address: Address.new(street: 'Teststraße', housenumber: 1, zip: '55116', city: 'Mainz')
    }
  end

  def find_customer
    @customer = Customer.find_by_id(params[:id])
  end

  def customer_not_found
    @customer.nil? && (flash[:alert] = 'Customer not found.')
  end

  def redirect_to_customers_path_with_alert
    redirect_to customers_path
  end
end