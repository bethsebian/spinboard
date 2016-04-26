require "rails_helper"

RSpec.feature 'View links', type: :feature do
  attr_reader :user_1, :user_2

  before(:each) do
    @user_1 = User.create(email: "janedoe@example.com",
                          password: "password")
    @user_2 = User.create(email: "jose@example.com",
                          password: "password")
  end

  scenario 'user can see links' do
    link_1 = Link.create(url: "http://www.word.com",
                         title: "Best Title",
                         read_status: true,
                         user_id: user_1.id)
    link_2 = Link.create(url: "http://www.believeland.com",
                         title: "Second Best Title",
                         user_id: user_1.id)

    ApplicationController.any_instance.stubs(:current_user).returns(user_1)

    visit links_path

    expect(page).to have_content("http://www.word.com")
    expect(page).to have_content("Best Title")
    within "#link-#{link_1.id}" do
      expect(page).to have_content("Read: true")
    end
    expect(page).to have_content("http://www.believeland.com")
    expect(page).to have_content("Second Best Title")
    within "#link-#{link_2.id}" do
      expect(page).to have_content("Read: false")
    end
  end

  scenario "user only sees their links" do
    ApplicationController.any_instance.stubs(:current_user).returns(user_1)
    link_1 = Link.create(title: "User 1 Title 1",
                         url: "http://www.best1.com",
                         user_id: user_1.id)
    link_2 = Link.create(title: "User 2 Title 1",
                         url: "http://www.best2.com",
                         user_id: user_2.id)

    visit links_path

    expect(current_path).to eq(links_path)
    expect(page).to have_content(link_1.title)
    expect(page).to have_content(link_1.url)
    expect(page).to_not have_content(link_2.title)
    expect(page).to_not have_content(link_2.url)
  end

end