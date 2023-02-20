require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters = @letters << ("A".."Z").to_a.sample }
  end

  def score
    letters = params[:letters].split(" ")
    word = params[:word].upcase.split("")

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user = JSON.parse(URI.open(url).read)

    sum = 0
    word.each { |letter| sum += 1 if word.count(letter) > letters.count(letter) }

    if !sum.positive? && user["found"]
      @message = 'Well done!'
    elsif !sum.positive? && !user["found"]
      @message = "#{params[:word]} is not an english word"
    else
      @message = "#{params[:word]} can't be build with #{letters.join(', ')}"
    end
  end
end
