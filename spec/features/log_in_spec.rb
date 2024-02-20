require 'rails_helper'

RSpec.feature "Login", type: :feature do
  scenario "User logs in with valid credentials" do
    user = User.create(email: "test@example.com", password: "password")
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to have_current_path(root_path)
    expect(page).to have_text("Sign Out")
  end

  scenario "User logs in with invalid credentials" do
    visit new_user_session_path
    fill_in "Email", with: "invalid@example.com"
    fill_in "Password", with: "invalidpassword"
    click_button "Login"


    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_text("Invalid Email or password")
  end
end
