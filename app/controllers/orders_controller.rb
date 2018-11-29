class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @widgets = Widget.all
    @order = Order.new
    5.times { @order.line_items.build }
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      flash[:success] = "The order has been saved!"
      redirect_to orders_path
    else
      flash[:danger] = "<b>There was a problem saving the order: #{@order.errors.full_messages.join(", ")}"
      render action: "new"
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      flash[:success] = "The order has been edited!"
      redirect_to orders_path
    else
      flash[:danger] = "There was a problem editing the order: #{@order.errors.full_messages.join(", ")}"
      render action: "edit"
    end
  end

  private

  def order_params
    params.require(:order).permit(:expedited, :returnable, :warehoused, line_items_attributes: [:id, :quantity, :unit_price, :widget_id, :_destroy])
  end
end
