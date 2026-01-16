require "swagger_helper"

RSpec.describe "api/v1/routines", type: :request do
  path "/api/v1/routines" do
    get("list routines") do
      tags "Routines"
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
              name: { type: :string },
              routine_days: { type: :array }
            }
          }
        run_test!
      end
    end
  end

  path "/api/v1/routines/{id}" do
    parameter name: "id", in: :path, type: :string, description: "id"

    get("show routine") do
      tags "Routines"
      security [ apiKey: [] ]
      produces "application/json"
      response(200, "successful") do
        let(:user) { User.create!(identifier: "test-user") }
        let(:"X-User-Identifier") { user.identifier }
        let(:routine) { user.routines.create!(name: "Upper Body") }
        let(:id) { routine.id }

        before do
          allow_any_instance_of(Api::V1::BaseController).to receive(:authenticate_api_user!).and_return(true)
          allow(Current).to receive(:user).and_return(user)
        end

        schema type: :object, properties: { id: { type: :integer }, name: { type: :string } }

        run_test!
      end
    end
  end
end
