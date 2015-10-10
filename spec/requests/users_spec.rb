require "rails_helper"

describe "GET #index", type: :request do

  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, email: "user2@example.com") }

  it "returns the all user informations on a hash" do 
    get "/users"
    user_response = json_response
    expect(user_response[:data][0][:attributes][:email]).to eq user1.email
    expect(user_response[:data][1][:attributes][:email]).to eq user2.email
    expect(response.status).to eq(200)
  end

end

describe "GET #show", type: :request do

  let(:user) { FactoryGirl.create(:user) }

  it "returns the information about user on a hash" do 
    get "/users/#{user.id}"
    user_response = json_response
    expect(user_response[:data][:attributes][:email]).to eq user.email
    expect(response.status).to eq(200)
  end

end

describe "POST #create", type: :request do

  context "when is successfully created" do

    it "renders the json message for the user just created" do
      post "/users", { email: "user@example.com"}
      user_response = json_response
      expect(user_response[:data][:attributes][:email]).to eq "user@example.com"
      expect(response.status).to eq(201)
    end

  end

  context "when user is not created" do

    it "renders an errors json with message when email is blank" do
      post "/users", { email: "" }
      user_response = json_response
      expect(user_response).to have_key(:errors)
      expect(user_response[:errors][:email]).to include "can't be blank"
      expect(response.status).to eq(422)
    end

    it "renders the json errors messages when email is in invalid form" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com
        foo@bar+baz.com foo@bar..com]

      addresses.each do |invalid_address|
        post "/users", { email: invalid_address }
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end
    end

    it "renders the json errors messages when email is already taken" do
      user = FactoryGirl.create(:user)
      user_with_same_email = user.dup
      post "/users", { email: user_with_same_email.email }
      user_response = json_response
      expect(user_response).to have_key(:errors)
      expect(user_response[:errors][:email]).to include "has already been taken"
    end
  end
end

describe "PUT/PATCH #update" , type: :request do
  
  let(:user){ FactoryGirl.create(:user) }
  
  context "when update is successful" do

    it "renders the json message for the user just updated" do
      patch "/users/#{user.id}", email: "newuser@example.com"
      user_response = json_response
      expect(user_response[:data][:attributes][:email]).to eq "newuser@example.com"
      expect(response.status).to eq(200)
    end
    
  end

  context "when user is not updated" do

    it "renders an errors json when email is invalid" do
      patch "/users/#{user.id}",  { email: "foo@example,com" }
      user_response = json_response
      expect(user_response).to have_key(:errors)
      expect(user_response[:errors][:email]).to include "is invalid"
      expect(response.status).to eq(422)
    end

  end

end

describe "Delete #destroy", type: :request do

  let(:user){ FactoryGirl.create(:user) }
  
  it "renders the 204 status rsponse" do
    delete "/users/#{user.id}"
    expect(response.status).to eq(204)
  end

end 
