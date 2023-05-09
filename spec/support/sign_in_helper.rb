module SignInHelper
  def sign_in_as(user, provider = :google)
    mock_auth(provider)
    visit root_path
    click_on 'ログイン'
    @current_user = user
  end

  def current_user
    @current_user
  end

  def mock_auth(provider)
    case provider
    when :google
      OmniAuth.config.mock_auth[:google_oauth2] =
        OmniAuth::AuthHash.new(
          provider: 'google_oauth2',
          uid: '1234',
          info: { name: 'Admin', image: 'https://example.com/image' }
        )
    end
  end
end
