require 'rails_helper'
require 'spec_helper'

RSpec.feature 'Order management', :type => :feature do
  it 'the orders#index page renders' do
    order = create(:order)
    visit orders_path

    expect(current_path).to eq orders_path
    expect(page).to have_text("Shipped Orders")
    expect(page).to have_text("Order ID: #{Order.first.id}")
    expect(page).to have_text(Order.last.id)
  end

end
