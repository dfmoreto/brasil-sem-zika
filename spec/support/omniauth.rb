module OmniauthMacros
  def mock_hash
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      'provider' =>'facebook',
      'uid' => '1234434',
      'info' => {
        'email' => 'joe@bloggs.com',
        'image' => 'https://graph.facebook.com/1234567/picture?type=square',
        'first_name' => 'Joe',
        'last_name' => 'Smith',
        'location' => 'São Paulo, SP'
      }
    }
  end
end

RSpec.configure do |config|
  config.include(OmniauthMacros)
end
