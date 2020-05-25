class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
    @start_time = Time.now
  end

  def score
    @user_input = params[:user_input].downcase
    @letters = params[:letters]
    # @start_time = DateTime.rfc3339(params[:start_time]).to_time.to_i
    # @start_time = params[:start_time].to_datetime
    # @final_time = Time.now
    session[:score] ||= 0
    url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @data = JSON.parse(response)
    if @data["found"]
      if check_valid(@user_input, @letters)
        @message = "Congratulations! #{@user_input.upcase} is a valid word!"
        session[:score] += @user_input.length
      else
        @message = "Sorry but #{@user_input.upcase} can't be built out of #{@letters.upcase}"
      end
    else
      @message = "Sorry but #{@user_input.upcase} does not seem to be a valid English word..."
    end
  end

  def check_valid(user_input, letters)
    user_input.chars.all? { |char| user_input.count(char) <= letters.count(char) }
  end
end
