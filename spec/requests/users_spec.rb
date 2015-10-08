require 'rails_helper'

describe "UsersController", type: :request do

  before { FactoryGirl.create_list(:user, 5) }

  it "should get a list of users" do
    get "/users"
    body = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(body.size).to eq(5)
  end

  it "should create a new user" do
    post "/users", :user => {:email => "hello@example.com"}
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['email']).to eq("hello@example.com")
  end

  it "should return a single user's information to the matching URI based on user's id" do
    get '/users/5'
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['id']).to eq(5)
  end


  it "should update a user's email" do
    put '/users/2', { :user => {:email => "hello@newemail.com"} }
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['email']).to eq('hello@newemail.com')
  end


  it "should delete a user" do
    count = User.count
    delete "/users/1"
    expect(response.status).to eq(204)
    expect(User.count).to eq(count-1)
  end
end
