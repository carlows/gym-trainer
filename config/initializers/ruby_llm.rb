RubyLLM.configure do |config|
  config.vertexai_project_id = ENV["GOOGLE_CLOUD_PROJECT"]
  config.vertexai_location = ENV["GOOGLE_CLOUD_LOCATION"]
  config.default_model = "gemini-2.5-flash"
  config.use_new_acts_as = true
end
