module SignInHelper
  def sign_in_as(user, provider: :google, uid: '1234')
    mock_auth(provider, uid)
    visit root_path
    click_on 'ログイン'
    @current_user = user
  end

  def current_user
    @current_user
  end

  def mock_auth(provider, uid)
    case provider
    when :google
      OmniAuth.config.mock_auth[:google_oauth2] =
        OmniAuth::AuthHash.new(
          provider: 'google_oauth2',
          uid:,
          info: { name: 'Admin', image: 'https://example.com/image' }
        )
    end
  end
end
