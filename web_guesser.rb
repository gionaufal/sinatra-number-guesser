require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

get '/' do
  guess = params['guess'].to_i
  message = guess_check(guess)
  display = cheat_mode(params['cheat'])
  erb :index, locals: { number: SECRET_NUMBER, message: message, color: @@color, display: display }
end

def guess_check(guess)
  diff = SECRET_NUMBER - guess
  infinity = 1.0 / 0.0

  case diff
  when 0
    @@color = 'green'
    'Correct!'
  when 1..25
    @@color = 'orange'
    'The guess is too low!'
  when 26..infinity
    @@color = 'red'
    'The guess is way too low!!!'
  when -infinity..-26
    @@color = 'red'
    'The guess is way too high!'
  when -25..-1
    @@color = 'orange'
    'The guess is too high!'
  end
end

def cheat_mode(cheat)
  cheat ? '' : 'hidden'
end
