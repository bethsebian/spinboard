require 'rails_helper'

RSpec.feature 'Sign up', type: :feature do
  scenario 'user can sign up' do
    visit signup_path
    fill_in "Name", with: "Jane Doe"
    fill_in "Email", with: "jane@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create my account"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome to SpinBoard!")
  end

  scenario 'unregistered user is directed to sign up page' do
    visit '/'

    expect(current_path).to eq('/signup')
    expect(page).to have_content('Log In or Sign Up')
  end
end