RSpec.configure do |config|
  Capybara.server = :puma, { Silent: true }

  config.before type: :system do
    if ENV['HEADED']
      driven_by :selenium, using: :chrome
    else
      driven_by :selenium, using: :headless_chrome
    end
  end
end
