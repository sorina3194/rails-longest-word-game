require "open-uri"
class GamesController < ApplicationController
  def index
    @url = "https://wagon-dictionary.herokuapp.com"
  end
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  #The word can’t be built out of the original grid
  #The word is valid according to the grid, but is not a valid English word
  #The word is valid according to the grid and is an English word

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "")
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
