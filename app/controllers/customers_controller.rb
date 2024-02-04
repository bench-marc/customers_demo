# frozen_string_literal: true

class CustomersController < ApplicationController
  def new
    @customer = Customer.new(
      email: 'test@test.de',
      username: 'test',
      birthdate: '01.01.1999',
      firstname: 'test',
      lastname: 'test',
      address: Address.new(street: 'test', housenumber: 1, zip: '55116', city: 'Mainz')
    )
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.valid? && @customer.save
      redirect_to customer_path(@customer.id), notice: 'Kunde erfolgreich erstellt',
                                               data: { 'turbo-frame' => :customer }
    else
      render :new, status: 422
    end
  end

  def show
    @customer = Customer.find_by_id(params[:id])

    return unless @customer.nil?

    flash[:alert] = 'Customer not found.'
    redirect_to customers_path
  end

  def edit
    @customer = Customer.find_by_id(params[:id])

    return unless @customer.nil?

    flash[:alert] = 'Customer not found.'
    redirect_to customers_path
  end

  def update
    @customer = Customer.find_by_id(params[:id])

    if @customer.nil?
      flash[:alert] = 'Customer not found.'
      redirect_to customers_path
      return
    end

    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Customer successfully updated.'
    else
      render :edit, status: 422
    end
  end

  def index
    @customers = Customer.all
  end

  private

  def create_task_for_manual_review(customer, possible_duplicate)
    Task.create(body: 'Mögliche Dublette',
                body: "Der Kunde #{customer.id} ähnelt dem vorhandenen Kunden #{possible_duplicate.id}. Bitte manuell prüfen!")
  end

  def customer_params
    params.require(:customer).permit(:firstname, :lastname, :email, :birthdate, :username,
                                     address_attributes: %i[id street housenumber zip city])
  end
end
