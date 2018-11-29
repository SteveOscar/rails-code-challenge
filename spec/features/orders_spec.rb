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

  it 'the orders#new page allows a user to create a new order with line items' do
    expect(LineItem.count).to eq 0
    visit new_order_path

    fill_in('Unit Price', with: 5)
    fill_in('Quantity', with: 10)

    click_button 'Submit'
  end

end
