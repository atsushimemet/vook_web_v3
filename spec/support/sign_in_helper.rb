module SignInHelper
  def sign_in_as(user)
    mock_auth(user.provider, user.uid)
    visit root_path
    click_on 'ログイン'
    @current_user = user
    expect(page).to have_content('ログアウト')
  end

  def mock_auth(provider, uid)
    OmniAuth.config.mock_auth[:google_oauth2] =
      OmniAuth::AuthHash.new(
        provider:,
        uid:,
        info: { name: 'user', image: 'https://example.com/image' }
      )
  end
end
