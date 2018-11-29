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
    3.times { @order.line_items.build }
  end

  private

  def order_params
    params.require(:order).permit(line_itemss_attributes: [:id, :quantity, :unit_price, :widget_id, :_destroy])
  end
end
