class WelcomeController < ApplicationController
  skip_before_action :proces_cookies, only: %i[index]

  def index; end
end
