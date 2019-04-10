require 'pry'
require 'artii'
require 'active_support'
require 'io/console'

require_relative 'helpers'

clear

puts 'Introduce el tiempo en minutos'
minutes = gets.chomp.to_i

clear

puts 'Introduce la clave de desactivación'
bomb_key = gets.chomp

bomb_deactivated = false

final = Time.now + minutes * 60

loop do
  accumulated_key = []
  pressed_key = nil  
  begin
    clear
    puts "SE ESTÁ ACABANDO EL TIEMPO..."
    puts "#{format_time(time_remaining(final))}"

    puts "Introduce la clave:\n\n"

    print "#{accumulated_key.join}"

    Timeout.timeout(1) do
      pressed_key = STDIN.getch
      raise Timeout::Error
    end

    break if Time.now > final

  rescue Timeout::Error
    if pressed_key
        accumulated_key << pressed_key
        pressed_key = nil
    end

    if accumulated_key.join == bomb_key
        bomb_deactivated = true
        break
    end
    
    retry
  end
end

clear

if bomb_deactivated
  puts "Bomba desactivada! Ha sobrado #{format_time(time_remaining(final))}"
else
  puts "BOOM!"
end

loop do
  sleep 60
end

3.times { puts }
