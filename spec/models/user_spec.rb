# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  before (:each) do
    @attr = {
      :name => "example user", 
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar",
    }
  end

  it "shoul dcreate a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should have a properly formatted email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names which are too long" do
    long_name = "a" * 25
    long_user = User.new(@attr.merge(:name => long_name))
    long_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[flute@flute.com FLUTE_MAN@flute.flute.com flute.man@flute.com]
    addresses.each do |a|
      valid_email_user = User.new(@attr.merge(:email => a))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user_at_user.com a@bbf,org flute@flute.]
    addresses.each do |a|
      valid_email_user = User.new(@attr.merge(:email => a))
      valid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email=User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  it "should reject duplicates identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge({:email => upcased_email}))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password =>"", :password_confirmation =>"")).should_not be_valid
    end
    
    it "should validation ==password" do
      User.new(@attr.merge(:password_confirmation => "flute")).should_not be_valid
    end

    it "should reject <6 chars" do
      short_pass = "a"*5 
      hash = @attr.merge(:password => short_pass, :password_confirmation => short_pass)
      User.new(hash).should_not be_valid
    end
  end

  describe "pwd encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should not be blank" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      it "should true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should false if passwords don't match" do
        @user.has_password?("invalidd").should be_false
      end
    end
    
    describe "authenticate method" do
      it "should return nil on mismatch" do
        wrong_pw = User.authenticate(@attr[:email], "notcorrect")
        wrong_pw.should be_nil
      end
      
      it "should return nil for an email-less user" do
        wrong_email = User.authenticate("flutes@flutes.flutes", @attr[:password])
        wrong_email.should be_nil
      end
      
      it "should return a value for a correct user that isnt" do
        correct = User.authenticate(@attr[:email],@attr[:password])
        correct.should == @user
      end
    end
  end
end

