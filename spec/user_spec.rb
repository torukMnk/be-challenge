ENV['APP_ENV'] = 'test'

require './models/user'
require 'rspec'

RSpec.describe 'User' do
  after(:all) { User.destroy_all}

  it "is valid" do
    user = User.new user_params
    expect(user.valid?).to be true
  end

  it "is invalid no email" do
    user = User.new user_params({email: ''})
    expect(user.valid?).to be false
  end

  it "is invalid repeated email" do
    User.create(user_params)
    user = User.new user_params
    expect(user.valid?).to be false
  end


  def user_params(attributes = {})
  	{
  		email: 'foobar@bazbat.com',
  		password: 'Foobar123'
  	}.merge(attributes)
  end
end