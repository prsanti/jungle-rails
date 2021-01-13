require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "They click the add button of a product" do
    visit root_path

    # user has to sign up before they can add to cart
    signupButton = page.find_link("Signup")
    signupButton.click

    expect(page).to have_content("Sign Up!")

    # fill in sign up form
    fill_in 'user[first_name]', with: 'test'
    fill_in 'user[last_name]', with: 'test'
    fill_in 'user[email]', with: 'test@email.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    submitSignUp = page.find_button("Submit")
    submitSignUp.click
    save_screenshot("signup-click.png")

    # check if cart is updated
    expect(page.find("#navbar")).to have_link("My Cart (0)")

    page.first("article.product").click_button("Add")

    expect(page.find("#navbar")).to have_link("My Cart (1)")
    save_screenshot("updated-cart.png")
  end
end
