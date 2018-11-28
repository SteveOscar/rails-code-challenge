require 'rails_helper'
require 'spec_helper'

RSpec.feature 'Order management', :type => :feature do
  it 'the orders#index page renders' do
    order = create(:order)
    visit orders_path

    expect(current_path).to eq orders_path
    expect(page).to have_text("Orders")
    expect(page).to have_text(order.id)
  end

end
