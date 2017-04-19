require 'rails_helper'

RSpec.describe 'Items API' do
  # Initialize the test data
  let!(:event) { create(:event) }
  let!(:people) { create_list(:person, 20, event_id: event.id) }
  let(:event_id) { event.id }
  let(:id) { people.first.id }

  # Test suite for GET /events/:event_id/people
  describe 'GET /events/:event_id/people' do
    before { get "/events/#{event_id}/people" }

    context 'when event exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all event people' do
        expect(json.size).to eq(20)
      end
    end

    context 'when event does not exist' do
      let(:event_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end

  # Test suite for GET /events/:event_id/people/:id
  describe 'GET /events/:event_id/people/:id' do
    before { get "/events/#{event_id}/people/#{id}" }

    context 'when event person exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the person' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when event person does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end

  # Test suite for PUT /events/:event_id/people
  describe 'POST /events/:event_id/people' do
    let(:valid_attributes) {  { name: 'Mozart', company: 'Music Is Us', email: 'wolfgang@mozart.com' } }

    context 'when request attributes are valid' do
      before { post "/events/#{event_id}/people", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/events/#{event_id}/people", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    end
  end

  # Test suite for PUT /events/:event_id/people/:id
  describe 'PUT /events/:event_id/people/:id' do
    let(:valid_attributes) { { name: 'Bach', company: 'Music Is Us', email: 'johann@bach.com' } }

    before { put "/events/#{event_id}/people/#{id}", params: valid_attributes }

    context 'when person exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the person' do
        updated_person = Person.find(id)
        expect(updated_person.name).to match(/Mozart/)
      end
    end

    context 'when the person does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end

  # Test suite for DELETE /events/:id
  describe 'DELETE /events/:id' do
    before { delete "/events/#{event_id}/people/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
