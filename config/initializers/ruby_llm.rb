RubyLLM.configure do |config|
  config.vertexai_project_id = ENV["GOOGLE_CLOUD_PROJECT"] || "medwing-202915"
  config.vertexai_location = ENV["GOOGLE_CLOUD_LOCATION"] || "us-central1"
  config.default_model = "gemini-2.5-flash"
  config.use_new_acts_as = true
end
