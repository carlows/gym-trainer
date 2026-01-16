require "swagger_helper"

RSpec.describe "api/v1/exercises", type: :request do
  path "/api/v1/exercises" do
    get("list exercises") do
      tags "Exercises"
      produces "application/json"
      parameter name: :q, in: :query, type: :string, description: "Search by name"
      parameter name: :body_part, in: :query, type: :string, description: "Filter by body part"

      response(200, "successful") do
        let(:user) { User.create!(identifier: "test-user") }
        let(:"X-User-Identifier") { user.identifier }
        let(:q) { nil }
        let(:body_part) { nil }

        before do
          allow_any_instance_of(Api::V1::BaseController).to receive(:authenticate_api_user!).and_return(true)
          allow(Current).to receive(:user).and_return(user)
        end

        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              body_part: { type: :string },
              equipment: { type: :string }
            }
          }
        run_test!
      end
    end
  end

  path "/api/v1/exercises/{id}" do
    parameter name: "id", in: :path, type: :string, description: "id"

    get("show exercise") do
      tags "Exercises"
      produces "application/json"
      response(200, "successful") do
        let(:user) { User.create!(identifier: "test-user") }
        let(:"X-User-Identifier") { user.identifier }
        let(:exercise) { Exercise.create!(name: "Push-up") }
        let(:id) { exercise.id }

        before do
          allow_any_instance_of(Api::V1::BaseController).to receive(:authenticate_api_user!).and_return(true)
          allow(Current).to receive(:user).and_return(user)
        end

        schema type: :object,

          properties: {
            id: { type: :integer },
            name: { type: :string }
          }
        run_test!
      end
    end
  end
end
