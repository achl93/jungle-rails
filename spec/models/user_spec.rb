require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should not be valid if password and password confirmation are not equal' do
      @user = User.new(first_name: 'A', last_name: 'B', password: 'CCCCC', password_confirmation: 'DDDDD', email: 'e@e.com')
      expect(@user).to_not be_valid
      expect(@user.save).to be false
    end
    it 'should not be valid if password and password confirmation are empty' do
      @user = User.new(first_name: 'A', last_name: 'B', email: 'e@e.com')
      expect(@user).to_not be_valid
      expect(@user.save).to be false
    end
    it 'should not be valid if email is not unique' do
      @user1 = User.create(first_name: 'A', last_name: 'B', password: 'CCCCC', password_confirmation: 'CCCCC', email: 'e@e.com')
      @user2 = User.new(first_name: 'A', last_name: 'B', password: 'CCCCC', password_confirmation: 'CCCCC', email: 'E@E.COM')
      expect(@user2).to_not be_valid
      expect(@user2.save).to be false
    end
    it 'should not be valid if name and email are missing' do
      @user = User.new(password: 'AAAAA', password_confirmation: 'AAAAA')
      expect(@user).to_not be_valid
      expect(@user.save).to be false
    end
    it 'should not be valid if password is too short' do
      @user = User.new(first_name: 'A', last_name: 'B', password: 'C', password_confirmation: 'C', email: 'e@e.com')
      expect(@user).to_not be_valid
      expect(@user.save).to be false
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return a user even if user logs in with spaces and randomcase in email' do
      @user_exists = User.create(first_name: 'A', last_name: 'B', password: 'CCCCC', password_confirmation: 'CCCCC', email: 'e@e.com')
      @user = User.authenticate_with_credentials('  e@E.cOm  ', @user_exists.password)
      expect(@user).to be_truthy
    end
    it 'should return nil if user enters wrong email' do
      @user_exists = User.create(first_name: 'A', last_name: 'B', password: 'CCCCC', password_confirmation: 'CCCCC', email: 'e@e.com')
      @user = User.authenticate_with_credentials('  dsada@sadasda.cOm  ', @user_exists.password)
      expect(@user).to be_nil
    end
    it 'should return nil if user enters wrong password' do
      @user_exists = User.create(first_name: 'A', last_name: 'B', password: 'CCCCC', password_confirmation: 'CCCCC', email: 'e@e.com')
      @user = User.authenticate_with_credentials('  e@E.cOm  ', 'DDDDD')
      expect(@user).to be_nil
    end
  end
end
