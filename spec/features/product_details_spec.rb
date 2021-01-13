require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click the details button of a product" do
    visit root_path

    productDetailsButton = page.first("article.product").find_link("Details")
    productDetailsButton.click

    expect(page).to have_link("Apparel")
    save_screenshot("product-details-click.png")
  end
end
