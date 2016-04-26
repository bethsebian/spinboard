require 'rails_helper'

RSpec.feature 'Log in', type: :feature do
  scenario 'unregistered user cannot log in' do
    visit login_path

    fill_in "Email", with: "jane@example.com"
    fill_in "Password", with: "password"
    click_on "Submit"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Log in")
  end

  scenario 'registered user can log in' do
    User.create(name: "Jane Doe",
                email: "jane@example.com",
                password: "password",
                password_confirmation: "password")

    visit login_path

    fill_in "Email", with: "jane@example.com"
    fill_in "Password", with: "password"
    click_on "Submit"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome to SpinBoard!")
  end
end