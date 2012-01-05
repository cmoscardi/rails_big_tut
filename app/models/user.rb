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

class User < ActiveRecord::Base
  attr_accessible(:name, :email)

  validates(:name, {:presence => true})

  validates(:email, {:presence => true})

  validates :name, :length => {:maximum => 24}

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, {:format => { :with => email_regex}}

  validates :email, :uniqueness => {:case_sensitive => false }


end
