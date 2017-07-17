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
  if guess == 0
    'Enter a guess'
  elsif SECRET_NUMBER == guess
    @@color = 'green'
    'Correct!'
  elsif SECRET_NUMBER > guess
    @@color = 'red'
    'The guess is too low!'
  elsif SECRET_NUMBER < guess
    @@color = 'red'
    'The guess is too high!'
  end
end

def cheat_mode(cheat)
  cheat ? '' : 'hidden'
end
