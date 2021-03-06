require 'rails_helper'

RSpec.describe 'Events API', type: :request do
  let!(:user) { create(:user)}
  let!(:events) { create_list(:event, 10, created_by: user.id) }
  let(:event_id) { events.first.id }
  let(:headers) { valid_headers }

  describe 'GET /events' do
    before { get '/events', params: {}, headers: headers }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:id' do
    before { get "/events/#{event_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the event' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  describe 'POST /events' do
    let(:valid_attributes) do
       {name: "Super Show", created_by: user.id.to_s}.to_json
    end

    context 'when the request is valid' do
      before { post '/events',  params: valid_attributes, headers: headers }

      it 'creates a event' do
        expect(json['name']).to eq('Super Show')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:valid_attributes) { { name: nil }.to_json }
      before { post '/events', params: valid_attributes, headers: headers}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /events/:id' do
    let(:valid_attributes) { {name: "Less Super Show"}.to_json  }

    context 'when the record exists' do
      before { put "/events/#{event_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /events/:id' do
    before { delete "/events/#{event_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
