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

    it "should create a user with the proper parameters" do
      @user.save
      expect(@user).to be_valid
    end

    it "should not create a user with an invalid first name" do
      @user.save
      @user.first_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("First name can't be blank")).to be_truthy
    end

    it "should not create a user with an invalid last name" do
      @user.save
      @user.last_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Last name can't be blank")).to be_truthy
    end

    it "should not create a user with an invalid email" do
      @user.save
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Email can't be blank")).to be_truthy
    end

    it "should not create a user with an invalid password" do
      @user.save
      @user.password = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Password can't be blank")).to be_truthy
    end

    it "should not create a user with an invalid password confirmation" do
      @user.save
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Password confirmation can't be blank")).to be_truthy
    end

    it "should not create a user with a different password and password confirmation" do
      @user.password_confirmation = "different"
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Password confirmation doesn't match Password")).to be_truthy
    end

    it "should have a unique email for a different user" do
      @user.save
      @user2 = User.new(
        first_name: "Douglas",
        last_name: "Falcon",
        email: "captain@falcon.com",
        password: "password",
        password_confirmation: "password",
      )
      @user2.save
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages.include?("Email has already been taken")).to be_truthy
    end

    it "should have case insensitive emails" do
      @user.save
      @user2 = User.new(
        first_name: "Douglas",
        last_name: "Falcon",
        email: "captain@falcon.com",
        password: "password",
        password_confirmation: "password",
      )
      @user2.save
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages.include?("Email has already been taken")).to be_truthy
    end
  end

  describe "Password Minimum Length:" do
    it "is greater than the minimum length" do
      @user = User.new(
        first_name: "Douglas",
        last_name: "Falcon",
        email: "captain@falcon.com",
        password: "nope",
        password_confirmation: "nope",
      )
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Password is too short (minimum is 5 characters)")).to be_truthy
    end
  end

  describe ".authenticate_with_credentials:" do
    before(:each) do
      @user = User.new(
        first_name: "Douglas",
        last_name: "Falcon",
        email: "captain@falcon.com",
        password: "password",
        password_confirmation: "password",
      )
    end

    it "should return a User when logging in with a different email case" do
      @user = User.authenticate_with_credentials("CAPTAIN@FALCON.COM", "password")
      expect(@user).to eql(@user)
    end

    it "should return nil for invalid email" do
      @user = User.authenticate_with_credentials("wrong@email.com", "password")
      expect(@user).to be_nil
    end

    it "should return nil for invalid password" do
      @user = User.authenticate_with_credentials("CAPTAIN@FALCON.COM", "knee")
      expect(@user).to be_nil
    end

    it "should return a User if the entered email has leading or ending spaces" do
      @user = User.authenticate_with_credentials(" CAPTAIN@FALCON.COM ", "password")
      expect(@user).to eql(@user)
    end

    it "should return a User if the entered email is in the wrong case" do
      @user = User.authenticate_with_credentials("cApTaIn@FaLcOn.CoM", "password")
      expect(@user).to eql(@user)
    end
  end

end