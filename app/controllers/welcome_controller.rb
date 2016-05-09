class WelcomeController < ApplicationController


  def index

    @loggedin = user_signed_in?



  end
end
