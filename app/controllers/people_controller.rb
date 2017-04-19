class PeopleController < ApplicationController
    before_action :set_event
    before_action :set_event_person, only: [:show, :update, :destroy]

    # GET /events/:event_id/people
    def index
      json_response(@event.people)
    end

    # GET /events/:event_id/people/:id
    def show
      json_response(@person)
    end

    # POST /events/:event_id/people
    def create
      @event.people.create!(person_params)
      json_response(@event, :created)
    end

    # PUT /events/:event_id/people/:id
    def update
      @person.update(person_params)
      head :no_content
    end

    # DELETE /events/:event_id/people/:id
    def destroy
      @person.destroy
      head :no_content
    end

    private

    def person_params
      params.permit(:name, :company, :email)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_event_person
      @person = @event.people.find_by!(id: params[:id]) if @event
    end
  end
