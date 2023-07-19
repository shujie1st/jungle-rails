require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "should save a user successfully with all required fields set correctly" do
      @user = User.new(first_name: "Susan", last_name: "Lee", email: "susanlee@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      expect(@user.errors.full_messages.length).to eql(0)
    end

    it "should have an error message if password and password_confirmation do not match" do
      @user = User.new(first_name: "Susan", last_name: "Lee", email: "susanlee@gmail.com", password: "123456", password_confirmation: "654321")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should have an error message if password is not set" do
      @user = User.new(first_name: "Susan", last_name: "Lee", email: "susanlee@gmail.com")
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should have an error message if email is not unique" do
      @exist_user = User.new(first_name: "Susan", last_name: "Lee", email: "susanlee@gmail.com", password: "123456", password_confirmation: "123456")
      @exist_user.save
      expect(@exist_user.errors.full_messages.length).to eql(0)
      @new_user = User.new(first_name: "Susan", last_name: "Lee", email: "SusanLee@gmail.com", password: "123456new", password_confirmation: "123456new")
      @new_user.save
      expect(@new_user.errors.full_messages).to include("Email has already been taken")
    end

    it "should have an error message if email is not set" do
      @user = User.new(first_name: "Susan", last_name: "Lee", password: "123456", password_confirmation: "123456")
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should have an error message if first name is not set" do
      @user = User.new(last_name: "Lee", email: "susanlee@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "should have an error message if last name is not set" do
      @user = User.new(first_name: "Susan", email: "susanlee@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should have an error message if password length is less than 6" do
      @user = User.new(first_name: "Susan", last_name: "Lee", email: "susanlee@gmail.com", password: "12345", password_confirmation: "12345")
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
 
  end

  describe '.authenticate_with_credentials' do

    it "should authenticate a user with correct email and password" do
      @user = User.new(first_name: "Susan", last_name: "Lee", email: "susanlee@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      expect(@user.errors.full_messages.length).to eql(0)
      @authenticated = User.authenticate_with_credentials("susanlee@gmail.com", "123456")
      expect(@authenticated).to_not eql(nil)
    end

    it "should not authenticate a user with if email not exist" do
      @authenticated = User.authenticate_with_credentials("hello@gmail.com", "123456")
      expect(@authenticated).to eql(nil)
    end

    it "should not authenticate a user with wrong password" do
      @user = User.new(first_name: "Susan", last_name: "Lee", email: "susanlee@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      expect(@user.errors.full_messages.length).to eql(0)
      @authenticated = User.authenticate_with_credentials("susanlee@gmail.com", "654321")
      expect(@authenticated).to eql(nil)
    end

    it "should authenticate a user with spaces beofre or after the email" do
      @user = User.new(first_name: "Susan", last_name: "Lee", email: " susanlee@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      expect(@user.errors.full_messages.length).to eql(0)
      @authenticated = User.authenticate_with_credentials("  susanlee@gmail.com  ", "123456")
      expect(@authenticated).to_not eql(nil)
    end

    it "should authenticate a user with email in the wrong case" do
      @user = User.new(first_name: "Susan", last_name: "Lee", email: "Susanlee@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      expect(@user.errors.full_messages.length).to eql(0)
      @authenticated = User.authenticate_with_credentials("susanLee@gmail.com", "123456")
      expect(@authenticated).to_not eql(nil)
    end

  end

end