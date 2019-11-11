require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]


    @included = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    @english_word = @word.english_word?
    @score = @word.size

    @result = [@word, @letters, @included, @english_word, @score]
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
