require "swagger_helper"

RSpec.describe "api/v1/sessions", type: :request do
  path "/api/v1/session" do
    get("show session") do
      tags "Sessions"
      security [ apiKey: [] ]
      produces "application/json"

      response(200, "successful") do
        let(:user) { User.create!(identifier: "test-user") }
        let(:"X-User-Identifier") { user.identifier }

        before do
          allow_any_instance_of(Api::V1::BaseController).to receive(:authenticate_api_user!).and_return(true)
          allow(Current).to receive(:user).and_return(user)
        end

        schema type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                identifier: { type: :string }
              }
            }
          }
        run_test!
      end

      response(401, "unauthorized") do
        let(:"X-User-Identifier") { "invalid" }
        before do
          allow(Current).to receive(:user).and_return(nil)
        end
        schema type: :object, properties: { error: { type: :string } }
        run_test!
      end
    end

    post("create session") do
      tags "Sessions"
      consumes "application/json"
      produces "application/json"
      parameter name: :session_params, in: :body, schema: {
        type: :object,
        properties: {
          identifier: { type: :string }
        },
        required: [ "identifier" ]
      }

      response(201, "created") do
        let(:session_params) { { identifier: "new-user" } }
        schema type: :object,
          properties: {
            message: { type: :string },
            user: {
              type: :object,
              properties: {
                identifier: { type: :string }
              }
            }
          }
        run_test!
      end
    end
  end
end
