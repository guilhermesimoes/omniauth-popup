Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
    {
      display: 'popup',
      secure_image_url: 'true',
      image_size: 'square',
      client_options: {
        ssl: {
          ca_file: Rails.root.join('lib', 'assets', 'cacert.pem').to_s
        }
      }
    }

  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'],
    {
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50,
      client_options: {
        ssl: {
          ca_file: Rails.root.join('lib', 'assets', 'cacert.pem').to_s
        }
      }
    }

  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'],
    {
      secure_image_url: 'true',
      image_size: 'normal',
      authorize_params: {
        force_login: 'true'
      }
    }

  on_failure do |env|
    message_key = env['omniauth.error.type']
    origin_query_param = env['omniauth.origin'] ? "&origin=#{CGI.escape(env['omniauth.origin'])}" : ""
    strategy_name_query_param = env['omniauth.error.strategy'] ? "&strategy=#{env['omniauth.error.strategy'].name}" : ""
    extra_params = env['omniauth.params'] ? "&#{env['omniauth.params'].to_query}" : ""
    new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{message_key}#{origin_query_param}#{strategy_name_query_param}#{extra_params}"
    Rack::Response.new(["302 Moved"], 302, 'Location' => new_path).finish
  end
end
