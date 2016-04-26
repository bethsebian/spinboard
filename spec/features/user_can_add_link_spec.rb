require "rails_helper"

RSpec.feature 'Add links', type: :feature do
  attr_reader :user_1, :user_2

  before(:each) do
    @user_1 = User.create(name: "Jane Doe",
                          email: "janedoe@example.com",
                          password: "password",
                          password_confirmation: "password")
  end

  scenario 'user can add link' do
    ApplicationController.any_instance.stubs(:current_user).returns(user_1)

    title = "Best F-ing Title Ever"
    url = "http://www.best.com"

    visit links_path

    fill_in "Url", with: url
    fill_in "Title", with: title
    click_on "Add Link"

    expect(current_path).to eq(links_path)
    expect(page).to have_content(url)
    expect(page).to have_content(title)
    expect(page).to have_content("Read: false")
  end

  scenario "user sees error if link is invalid" do
    ApplicationController.any_instance.stubs(:current_user).returns(user_1)

    title = "Best F-ing Title Ever"
    url = "www"

    visit links_path

    fill_in "Url", with: url
    fill_in "Title", with: title
    click_on "Add Link"

    expect(current_path).to eq(links_path)
    expect(page).to have_content("The url is invalid. Please try again.")
    expect(page).to_not have_content(url)
    expect(page).to_not have_content(title)
  end

  scenario "unauthenticated user cannot add link" do
    title = "Best F-ing Title Ever"
    url = "http://www.best.com"

    visit links_path

    fill_in "Url", with: url
    fill_in "Title", with: title
    click_on "Add Link"

    expect(current_path).to eq(links_path)
    expect(page).to have_content("Please log in to add a link.")
    expect(page).to_not have_content(url)
    expect(page).to_not have_content(title)
  end
end