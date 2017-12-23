class OrdersController < ApplicationController

  before_action(:set_order, only: %i{show edit update destroy})

  def index
    @orders = repo.all
  end

  def new
    @order = repo.new_entity
  end

  def create
    success = -> (order) do
      redirect_to(order_path(order), notice: "Order has been created")
    end

    failure = -> (order) do
      @order = order
      render(:new)
    end

    UseCase::Order::Create.call(order_params, success: success, failure: failure)
  end

  def show
  end

  def edit
  end

  def update
    success = -> (order) do
      redirect_to(order_path(order), notice: "Order has been updated")
    end

    failure = -> (order) do
      @order = order
      render(:edit)
    end

    UseCase::Order::Update.call(@order, order_params, success: success, failure: failure)
  end

  def destroy
    success = -> { redirect_to(orders_path, notice: "Order has been removed") }
    failure = -> { redirect_to(orders_path, alert: "Couldn't remove order") }

    UseCase::Order::Delete.call(@order, success: success, failure: failure)
  end

  private
    def repo
      @repo ||= OrderRepository.new
    end

    def set_order
      @order = repo.find(params[:id])
    end

    def order_params
      params.require(:order).permit(
        :customer_name,
        :type_id,
        :quantity,
        :address
      )
    end
end
