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

  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
    {
      scope: 'user:email',
      client_options: {
        ssl: {
          ca_file: Rails.root.join('lib', 'assets', 'cacert.pem').to_s
        }
      }
    }

  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'],
    {
      name: 'google',
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

  on_failure { |env| SessionsController.action(:failure).call(env) }
end
