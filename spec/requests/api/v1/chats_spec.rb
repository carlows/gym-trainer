require "swagger_helper"

RSpec.describe "api/v1/chats", type: :request do
  path "/api/v1/chat" do
    get("show chat") do
      tags "Chat"
      security [ apiKey: [] ]
      produces "application/json"
      response(200, "successful") do
        let(:user) { User.create!(identifier: "test-user") }
        let(:"X-User-Identifier") { user.identifier }

        before do
          allow_any_instance_of(Api::V1::BaseController).to receive(:authenticate_api_user!).and_return(true)
          allow(Current).to receive(:user).and_return(user)
          allow_any_instance_of(Chat).to receive(:with_instructions).and_return(double("Chat").as_null_object)
          allow_any_instance_of(Chat).to receive(:ask).and_return(true)
        end

        schema type: :object,
          properties: {
            chat: { type: :object },
            messages: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  role: { type: :string },
                  content: { type: :string },
                  entities: { type: :array }
                }
              }
            }
          }
        run_test!
      end
    end

    post("create message") do
      tags "Chat"
      security [ apiKey: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :chat_params, in: :body, schema: {
        type: :object,
        properties: {
          content: { type: :string }
        },
        required: [ "content" ]
      }

      response(200, "processing") do
        let(:user) { User.create!(identifier: "test-user") }
        let(:"X-User-Identifier") { user.identifier }
        let(:chat_params) { { content: "Hello" } }

        before do
          allow_any_instance_of(Api::V1::BaseController).to receive(:authenticate_api_user!).and_return(true)
          allow(Current).to receive(:user).and_return(user)
          allow_any_instance_of(Chat).to receive(:with_instructions).and_return(double("Chat").as_null_object)
          allow_any_instance_of(Chat).to receive(:ask).and_return(true)
        end

        schema type: :object, properties: { status: { type: :string } }
        run_test!
      end
    end
  end
end
