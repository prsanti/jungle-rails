require 'rails_helper'
require 'user'

RSpec.describe User, type: :model do

  describe "Validations:" do
    before(:each) do
      @user = User.new(
        first_name: "Douglas",
        last_name: "Falcon",
        email: "captain@falcon.com",
        password: "password",
        password_confirmation: "password",
      )
    end

    it "the user is valid with proper fields" do
      expect(@user).to be_valid
    end
  end

end