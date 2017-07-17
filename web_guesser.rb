require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

get '/' do
  guess = params['guess'].to_i
  message = guess_check(guess)
  erb :index, locals: { number: SECRET_NUMBER, message: message }
end

def guess_check(guess)
  if guess == 0
    'Enter a guess'
  elsif SECRET_NUMBER == guess
    'Correct!'
  elsif SECRET_NUMBER > guess
    'The guess is too low!'
  elsif SECRET_NUMBER < guess
    'The guess is too high!'
  end
end
