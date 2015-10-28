require 'rails_helper'

describe "lines", type: :request do

  let(:haiku) { FactoryGirl.create(:haiku, {"lines_attributes": {"0": {"content": "haiku line"}}} ) }
  let(:line) { haiku.lines.first }

  describe "lines#index", type: :request do
   let!(:line2) { haiku.lines.create({content: "Line 2"}) }
   let!(:line3) { haiku.lines.create({content: "Line 3"}) }

    it "should output collection of lines" do
      get "/haikus/#{haiku.id}/lines", {format: :json}
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body["data"].length).to eq(3)
    end
  end

  describe "lines#create", type: :request do
    it "should create line using valid data" do
      post "/haikus/#{haiku.id}/lines", format: :json, haiku_id: haiku.id, content: "let's make a haiku"
      expect(response.status).to eq(201)
      expect(Line.last.content).to eq("let's make a haiku")
    end

    it "should not create line when missing data" do
      post "/haikus/#{haiku.id}/lines", format: :json, content: nil
      expect(response.status).to eq(400)
    end
  end

  describe "lines#update", type: :request do
    it "should update line using valid data" do
      patch "/haikus/#{haiku.id}/lines/#{line.id}", content: "haiku has been updated!", format: :json
      expect(response.status).to eq(200)
      line.reload
      expect(line.content).to eq("haiku has been updated!")
    end

    it "should not update line when missing data" do
      patch "/haikus/#{haiku.id}/lines/#{line.id}", content: nil, format: :json
      expect(response.status).to eq(400)
    end
  end

  describe "lines#show", type: :request do
    it "should output line" do
      get "/haikus/#{haiku.id}/lines/#{line.id}", format: :json
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body["data"]["attributes"]["content"]).to eq(line.content)
    end
  end

  describe "lines#destroy", type: :request do
    let!(:line) { haiku.lines.first }

    it "should delete line" do
      count = Line.count
      delete "/haikus/#{haiku.id}/lines/#{line.id}", format: :json
      expect(response.status).to eq(204)
      expect(Line.count).to eq(count - 1)
    end
  end

end
