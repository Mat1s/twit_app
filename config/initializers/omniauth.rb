Rails.application.config.middleware.use OmniAuth::Builder do
  OAUTH_CREDENTIALS = YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env]
  provider :twitter, OAUTH_CREDENTIALS[:twitter][:api_id], 
                          OAUTH_CREDENTIALS[:twitter][:api_secret]
  
end