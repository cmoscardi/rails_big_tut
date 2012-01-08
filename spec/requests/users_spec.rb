require 'spec_helper'

describe "Users" do 
  describe "signup" do
    describe "failure" do
      
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => ""
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirm Your Password", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end #it should block
    end #describe block
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => "George2"
          fill_in "Email", :with => "george2@george.com"
          fill_in "Password", :with => "george2"
          fill_in "Confirm Your Password", :with => "george2"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end #it block
    end #describe success     
  end #describe signup
end
