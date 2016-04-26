require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new( name: "Jane Doe",
                      email: "jane@example.com",
                      password: "password",
                      password_confirmation: "password"
                    )
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  it "should have a name" do
    @user.name = ""
    expect(@user).to_not be_valid
  end

  it "should have an email" do
    @user.email = "       "
    expect(@user).to_not be_valid
  end

  it "should have unique email address" do
    duplicate_user = @user.dup
    @user.save
    expect(duplicate_user).to_not be_valid
  end

  it "should have valid email address" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).to_not be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "should have a password" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).to_not be_valid
  end

  it "should have a password with minimum length of 6" do
    @user.password = @user.password_confirmation = " " * 5
    expect(@user).to_not be_valid
  end
end
