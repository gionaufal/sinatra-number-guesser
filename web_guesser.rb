require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(101)
@@tries = 5

get '/' do
  guess = params['guess'].to_i
  message = guess_check(guess)
  display = cheat_mode(params['cheat'])
  erb :index, locals: { number: @@secret_number, message: message, color: @@color, display: display, tries: @@tries }
end

def guess_check(guess)
  diff = @@secret_number - guess
  infinity = 1.0 / 0.0

  unless guess.zero?
    case diff
    when 0
      @@color = 'green'
      @@tries = 5
      'Correct! New number generated'
    when 1..25
      @@color = 'orange'
      @@tries = @@tries - 1
      guess_counter || 'The guess is too low!'
    when 26..infinity
      @@color = 'red'
      @@tries = @@tries - 1
      guess_counter || 'The guess is way too low!!!'
    when -infinity..-26
      @@color = 'red'
      @@tries = @@tries - 1
      guess_counter || 'The guess is way too high!'
    when -25..-1
      @@color = 'orange'
      @@tries = @@tries - 1
      guess_counter || 'The guess is too high!'
    end
  end
end

def cheat_mode(cheat)
  cheat ? '' : 'hidden'
end

def guess_counter
  if @@tries < 1
    generate_secret_number
    @@tries = 5
    'You have no guesses left. New number generated'
  end
end

def generate_secret_number
  @@secret_number = rand(101)
end
