require 'rails_helper'

RSpec.feature "Home Page", type: :feature do
  scenario "User visits the home page" do
    visit root_path

    expect(page).to have_link("Shop Products", href: products_path)
  end
end
