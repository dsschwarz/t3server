class ApplicationController < ActionController::Base
  protect_from_forgery
  def orbiter
  end
  def request_game
    @games = Games.find_by_available(true)
      puts @games.class
      puts @games.nil?
    if(!@games.nil?)
      if @games.class == Games
         @game = @games
      else
        @game = @games.first
      end
      json = {}
      json[:o] = @game.o_token
      json[:session] =@game.session_token
      json[:piece] = "o"
      @game.available = false
      @game.save
      render json: json.to_json
    else
      @game = Games.new
      json = {}
      @game.session_token = json[:session] = SecureRandom.hex(5)
      @game.x_token = json[:x] = SecureRandom.hex(5)
      json[:piece] = "x"
      @game.o_token = SecureRandom.hex(5)
      @game.available = true
      @game.save
      render json: json.to_json
    end
  end
  def request_update
    temp={}
    @game = Games.find_by_session_token(params[:st])
    if !@game.nil?
      temp[:column] = @game.last_column
      temp[:row] = @game.last_row
      temp[:owner] = @game.last_played_owner
    end
    render json: temp.to_json
  end
  def request_place
    @game = Games.find_by_session_token(params[:st])
    temp = {}
    temp[:errors] = []
    if(@game.x_token == params[:t])
      if(@game.last_played_owner=="x")
        temp[:success] = false
        temp[:errors] << "Not your turn"
        render :json => temp.to_json
      else
        @game.last_column = params[:column]
        @game.last_row = params[:row]
        @game.last_played_owner = "x"
        @game.save
        temp[:success] = true
        render :json => temp.to_json
      end
    elsif(@game.o_token == params[:t])
      if @game.last_played_owner=="o"
        temp[:success] = false
        temp[:errors] << "Not your turn"
        render :json => temp.to_json
      else
        @game.last_column = params[:column]
        @game.last_row = params[:row]
        @game.last_played_owner = "o"
        @game.save
        temp[:success] = true
        render :json => temp.to_json
      end
    else
      temp[:success] = false
      temp[:errors] << "Invalid authenication"
      render :json => temp.to_json
    end
  end
end
