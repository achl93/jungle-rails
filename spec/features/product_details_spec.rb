require 'rails_helper'

RSpec.feature "Product tails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit '/products/1'

    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_content 'Name', 'Description', 'Quantity', 'Price'
  end

end