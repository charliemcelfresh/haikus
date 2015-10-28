require 'rails_helper'

describe 'haikus', type: :request do

  describe 'index' do
   before :each do
     haikus_list = FactoryGirl.create_list(:haiku, 5, {"lines_attributes": {"0": {"content": "Haiku line"}}})
     get '/haikus'
  end

    it 'should have an endpoint' do
      expect(response).to be_success
    end
    it 'should return an array of haikus' do
      body = JSON.parse(response.body)
      expect(body['data'].length).to eq(5)
    end
  end

  describe 'show' do
    let(:haiku) { FactoryGirl.create(:haiku, {"lines_attributes": {"0": {"content": "haiku line"}}} ) }
    before :each do
      get "/haikus/#{haiku.id}"
    end
    it 'should have an endpoint' do
      expect(response).to be_success
    end
    it 'should return the correct haiku' do
      body = JSON.parse(response.body)
      expect(body['data']['id'].to_i).to eq(haiku.id)
    end
  end

  describe 'create' do
    it 'should create a new haiku with a haiku line' do
      post '/haikus', {"lines_attributes": {"0": {"content": "haiku line"}}}, format: :json
      expect(response.status).to eq(201)
      body = JSON.parse(response.body)
      expect(body["data"][0]["attributes"]["content"]).to eq("haiku line")
    end
    it "should not create a new haiku when line content is missing" do
      post '/haikus', format: :json
      expect(response.status).to eq(400)
    end
  end

  describe 'create_random' do
    it 'should create a new random haiku' do
      10.times do
        h = FactoryGirl.build(:haiku)
        lines = [{content: "first line"}, {content: "Second line"}, {content: "third line"}]
        h.lines.build(lines)
        h.save
      end
      get '/random-haiku'
      expect(response.status).to eq(201)
      body = JSON.parse(response.body)
      expect(body["data"][0]["attributes"]["content"]).to eq("first line")
      expect(body["data"][2]["attributes"]["content"]).to eq("third line")
    end

    it "should not create a random haiku if incorrect params" do
      h = FactoryGirl.build(:haiku)
      lines = [{content: "first line"}, {content: "Second line"}, {content: "third line"}]
      h.lines.build(lines)
      h.save
      get '/random-haiku'
      expect(response.status).to eq(400)
    end
  end

  describe 'update' do
    let(:haiku) { FactoryGirl.create(:haiku, {"lines_attributes": {"0": {"content": "haiku line"}}} ) }
    it "should update haiku using valid data" do
      patch "/haikus/#{haiku.id}", content: "updated haiku line", format: :json
      expect(response.status).to eq(200)
      haiku.reload
      body = JSON.parse(response.body)
      expect(haiku.lines.first.content).to eq("updated haiku line")
    end

    it "should not update haiku when missing data" do
      patch "/haikus/#{haiku.id}", content: nil, format: :json
      expect(response.status).to eq(400)
    end
  end

  describe 'destroy' do
    let!(:haiku) { FactoryGirl.create(:haiku, {"lines_attributes": {"0": {"content": "haiku line"}}} ) }
    it "should delete the haiku" do
      expect{ delete "/haikus/#{haiku.id}", format: :json }.to change{Haiku.count}.by(-1)
    end
  end


end
