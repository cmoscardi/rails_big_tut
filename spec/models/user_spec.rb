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
    @attr = {:name => "example user", :email => "user@example.com"}
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
end