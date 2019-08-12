class GameController < ApplicationController
  def valid?
    attempt = params[:resultat]
    grid = params[:letters].downcase
    for i in 0...attempt.size
      return false if !grid.include?(attempt[i])
    end
    return true
  end

  def run_game
    # TODO: runs the game and return detailed hash of result
    attempt = params[:resultat]
    score = 2
    score += 3 if attempt.size >= 4
    score = 0 if !valid? || !is_english? || !repetition?

    if !valid?
      msg = "The letters of '#{@answer}' are not in the grid"
    elsif !is_english?
      msg = "Boooh, '#{@answer}' is not an english word!"
    elsif !repetition?
      msg = "The letters of '#{@answer}' are not in the grid"
    else
      msg = "Congratulations! '#{@answer}' is an english word!"
    end

    my_hash = {
      score: score,
      message: msg
    }

    return my_hash
  end

  def repetition?
    attempt = params[:resultat]
    grid = params[:letters].downcase.chars
    for i in 0...attempt.size
      return false if !grid.include?(attempt[i])
      grid.delete_at(grid.index(attempt[i]))
    end
    return true
  end

  def is_english?
    attempt = params[:resultat]
    url = 'https://wagon-dictionary.herokuapp.com/' + attempt
    json = open(url).read
    my_hash = JSON.parse(json)
    return my_hash["found"]
  end

  def start
    @letters = []
    for i in 0...9
      @letters << (65 + rand(26)).chr
    end
  end

  def result
    @letters = params[:letters]
    @answer = params[:resultat]
    @tab = run_game
  end
end
