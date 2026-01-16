require "swagger_helper"

RSpec.describe "api/v1/workouts", type: :request do
  path "/api/v1/workouts" do
    get("list workout sessions") do
      tags "Workouts"
      security [ apiKey: [] ]
      produces "application/json"
      response(200, "successful") do
        let(:user) { User.create!(identifier: "test-user") }
        let(:"X-User-Identifier") { user.identifier }

        before do
          allow_any_instance_of(Api::V1::BaseController).to receive(:authenticate_api_user!).and_return(true)
          allow(Current).to receive(:user).and_return(user)
        end

        schema type: :array,

          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              completed_at: { type: :string, format: "date-time" },
              session_exercises: { type: :array }
            }
          }
        run_test!
      end
    end

    post("log workout session") do
      tags "Workouts"
      security [ apiKey: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :workout, in: :body, schema: {
        type: :object,
        properties: {
          routine_id: { type: :integer },
          exercises: {
            type: :array,
            items: {
              type: :object,
              properties: {
                exercise_id: { type: :integer },
                sets: { type: :integer },
                reps: { type: :integer }
              }
            }
          }
        },
        required: [ "routine_id", "exercises" ]
      }

      response(201, "created") do
        let(:user) { User.create!(identifier: "test-user") }
        let(:"X-User-Identifier") { user.identifier }
        let(:routine) { user.routines.create!(name: "Upper Body") }
        let(:exercise) { Exercise.create!(name: "Push-up") }
        let(:workout) { { routine_id: routine.id, exercises: [ { exercise_id: exercise.id, sets: 3, reps: 10 } ] } }

        before do
          allow_any_instance_of(Api::V1::BaseController).to receive(:authenticate_api_user!).and_return(true)
          allow(Current).to receive(:user).and_return(user)
        end

        schema type: :object, properties: { id: { type: :integer } }

        run_test!
      end
    end
  end
end
