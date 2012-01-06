#Factory girl simulates the 'user' model by this definition of the :user symbol
Factory.define :user do |user|
  user.name "Christian"
  user.email "moscardi79@gmail.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end
