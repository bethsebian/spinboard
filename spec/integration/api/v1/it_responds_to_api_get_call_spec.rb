require "rails_helper"

RSpec.feature 'Produces API', type: :feature do
  attr_reader :item_1, :item_2, :item_3

	before(:each) do
    @user_1 = User.create(name: "Jane Doe",
                          email: "janedoe@example.com",
                          password: "password",
                          password_confirmation: "password")
    @link_1 = user_1.links.create(url: "http://www.word.com",
                                  title: "Best Title")
    @link_2 = user_1.links.create(url: "http://www.believeland.com",
                                  title: "Second Best Title")
	end

  xit "produces a json response to request for all items" do
    get "/api/v1/items.json"

		json = JSON.parse(response.body)

		# assert_response 200
		# assert_equal 2, json.length
		# assert_equal item_1.name, json.last['name']
		# assert_equal item_1.description, json.last['description']
		# assert_equal item_1.image_url, json.last['image_url']
	end

  xit "it produces a json response to request for one item" do
    get "/api/v1/items/1.json"

		json = JSON.parse(response.body)

		# assert_response 200
		# assert_equal 3, json.length
		# assert_equal item_1.name, json['name']
		# assert_equal item_1.description, json['description']
		# assert_equal item_1.image_url, json['image_url']
	end
end