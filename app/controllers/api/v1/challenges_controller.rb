module Api 
    module V1 
        class ChallengesController < ApplicationController
            before_action :get_challenge_by_id, only: [:destroy, :show, :update]

            #GET api/v1/challenges
            def index
                @challenges = Challenge.all
                render json: {status: 200 , message: "Challenges fetched successfully", data: @challenges}
            end

            #POST api/v1/challenges
            def create
                @challenges = Challenge.new(challenges_params)
                if @challenges.save
                    render json: {status: 200, message: "Challenge created successfully", data: challenges_params}
                else
                    render json: {message: @challenges.errors}
                end
            end

            #GET api/v1/challenges:id
            def show
                render json: {status: 200, message: "Challenge found", data: @challenge}
            end

            #PUT/PATCH api/v1/challenges/:id
            def update
                if @challenge.update(challenges_params)
                    render json: {status: 200, message: "updated successfully", data: @challenge}
                else
                    render json: {message: @challenge.errors}
                end
            end

            #DELETE api/v1/challenges/:id
            def destroy
                if @challenge.destroy 
                    render json: {messge: "deleted successfully"}
                else
                    render json: {message: @challenge.errors}
                end
            end

            private

            def get_challenge_by_id
                    begin
                        @challenge = Challenge.find(params[:id])
                    rescue ActiveRecord::RecordNotFound
                        render json: {status: 404, message: "challenge not found"}
                    end
            end

            def challenges_params
                params.permit(:title, :description, :start_date, :end_date)
            end

        end
    end
end
