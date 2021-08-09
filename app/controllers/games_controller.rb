class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    arr = ('a'..'z').to_a
    @random_letter = arr.sample(10)
  end

  def score
    @word = params[:word]
    @random_letter = params[:hidden_message]
    raise
    @result = if word_is_english? && word_includes_in?
        "Congratulation #{@word} is a valid english word and is in the grid"
    elsif word_includes_in?
        "#{@word} isn't a valid english word but is in the grid"
    else
      "Sorry but #{@word} can't be build"
      end
  end

  private

  def word_is_english?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response_serialized = URI.open(url).read
    response = JSON.parse(response_serialized)
    response["found"]
  end

  def word_includes_in?
    word_split = @word.split("")
    random_split = @random_letter.split
    word_split.each do |letter|
      word_split.delete(letter) if random_split.include?(letter)
    end
    word_split.empty?

  end
end
