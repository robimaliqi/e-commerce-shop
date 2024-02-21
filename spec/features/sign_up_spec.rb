require 'rails_helper'

RSpec.feature "Sign Up", type: :feature do
  scenario "User signs up with valid credentials" do
    visit new_user_registration_path
    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_current_path(root_path)
    expect(page).to have_text("Sign Out")
  end

  scenario "User signs up with invalid credentials" do
    visit new_user_registration_path
    fill_in "user_email", with: "invalid-email"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_text("1 error prohibited this user from being saved:")
    expect(page).to have_text("Email is invalid")
  end

  scenario "User signs up with mismatched passwords" do
    visit new_user_registration_path
    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "password1"
    fill_in "user_password_confirmation", with: "password2"
    click_button "Sign up"

    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_text("Password confirmation doesn't match Password")
  end

  scenario "User signs up with an existing email address" do
    User.create(email: "existing@example.com", password: "password")
    visit new_user_registration_path
    fill_in "user_email", with: "existing@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_current_path(user_registration_path)
    expect(page).to have_text("Email has already been taken")
  end
end
