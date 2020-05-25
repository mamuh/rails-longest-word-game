class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def score
    @user_input = params[:user_input].downcase
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @data = JSON.parse(response)
    if @data["found"]
      check_valid(@user_input, @letters) ? @message = "Congratulations! #{@user_input.upcase} is a valid word!" : @message = "Sorry but #{@user_input.upcase} can't be built out of #{@letters.upcase}"
    else
      @message = "Sorry but #{@user_input.upcase} does not seem to be a valid English word..."
    end
  end

  def check_valid(user_input, letters)
    user_input.chars.all? { |char| user_input.count(char) <= letters.count(char) }
  end
end
