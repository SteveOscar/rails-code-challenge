require 'rails_helper'
require 'spec_helper'

RSpec.feature 'Order management', :type => :feature do
  before do
    3.times do
      create(:order)
      create(:widget)
    end
  end

  it 'the orders#index page renders' do
    visit orders_path

    expect(current_path).to eq orders_path
    expect(page).to have_text("Shipped Orders")
    expect(page).to have_text("Order ID: #{Order.first.id}")
    expect(page).to have_text(Order.last.id)
  end

  it 'the orders#new page renders and the user can fill in the fields' do
    expect(LineItem.count).to eq 0
    visit new_order_path

    fill_in('order_line_items_attributes_0_unit_price', with: 5)
    fill_in('order_line_items_attributes_0_quantity', with: 10)
    select(Widget.first.name, from: 'order_line_items_attributes_0_widget_id')
  end

  it 'the orders#new page creates the desired records' do
    initial_line_item_count = LineItem.count
    initial_order_count = Order.count
    visit new_order_path

    fill_in('order_line_items_attributes_0_unit_price', with: 5)
    fill_in('order_line_items_attributes_0_quantity', with: 10)
    select(Widget.first.name, from: 'order_line_items_attributes_0_widget_id')
    click_button 'Create Order'

    expect(Order.count).to eq initial_order_count + 1
    expect(LineItem.count).to eq initial_line_item_count + 1
  end

  it 'the orders#edit page allows the expedited attribute to be changed' do
    order = Order.first
    expect(order.expedited).to eq false
    expect(order.returnable).to eq false
    expect(order.warehoused).to eq false

    visit edit_order_path(order)

    find(:css, "#order_expedited").set(true)
    find(:css, "#order_returnable").set(true)
    find(:css, "#order_warehoused").set(true)

    click_button 'Update Order'

    order.reload
    expect(order.expedited).to eq true
    expect(order.returnable).to eq true
    expect(order.warehoused).to eq true
  end

end
