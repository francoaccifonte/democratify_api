class WhitelistAccountInSpotify
  def initialize(account_id:, email:)
    @account_id = account_id
    @email = email
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  def call
    account = Account.last # Account.find(account_id)
    driver = Selenium::WebDriver.for :chrome
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)

    driver.get('https://developer.spotify.com/')
    driver.find_element(:xpath, '/html/body/div[1]/div/header/div[2]/button').click
    wait.until { driver.find_element(id: 'login-username') }.send_keys ENV.fetch('SPOTIFY_ACCOUNT_EMAIL')
    wait.until { driver.find_element(id: 'login-password') }.send_keys ENV.fetch('SPOTIFY_ACCOUNT_PASSWORD')
    driver.find_element(:xpath, '/html/body/div[1]/div/div[2]/div/div/div[1]/div[4]/button/span[1]').click

    wait.until { driver.find_element(:xpath, '/html/body/div[1]/div/header/div[2]/div/div/button/span') }

    driver.get('https://developer.spotify.com/dashboard/9d48abfbbf194adc9051e1b82b0ecdb0/users')
    wait.until { driver.find_element(id: 'name') }.send_keys(account.name || "namelessUser#{account_id}")
    wait.until { driver.find_element(id: 'email') }.send_keys(email)
    driver.find_element(:xpath, '/html/body/div[1]/div/div/main/div/div/div[4]/div/div/div[2]/form/div/div[3]/button/span[1]').click
  end

  private

  attr_reader :email, :account_id
end
