require 'pry'
require 'artii'
require 'active_support'
require 'io/console'

require_relative 'helpers'
require_relative 'ascii_art'

a = Artii::Base.new :font => 'ogre'

clear
puts 'Introduce el tiempo en minutos'
minutes = gets.chomp.to_i

clear

puts 'Introduce la clave de desactivación'
bomb_key = gets.chomp
accumulated_key = []
bomb_deactivated = false

final = Time.now + minutes * 60

loop do
  
  pressed_key = nil   
  begin
    clear
    insert_space
    puts a.asciify("SE ESTA ACABANDO EL TIEMPO...")
    insert_space
    puts a.asciify("#{format_time(time_remaining(final))}")
    insert_space
    puts a.asciify("Introduce   la     clave   :\n\n")
    insert_space
    print a.asciify("#{accumulated_key.join}#{'*' * (bomb_key.length - accumulated_key.length)}")
    break if Time.now > final

    Timeout.timeout(1) do
      pressed_key = STDIN.getch
      raise Timeout::Error
    end 

    rescue Timeout::Error
      if pressed_key
        accumulated_key << pressed_key
        pressed_key = nil
      end
      
      if accumulated_key.join == bomb_key
        bomb_deactivated = true
        break
      end
      
      if accumulated_key.length == bomb_key.length && accumulated_key != bomb_key
        final = final-30
        accumulated_key.clear
        pressed_key = nil
      end
      
    retry
  end
end

clear

if bomb_deactivated
  puts a.asciify("Bomba desactivada!")
  puts a.asciify("Ha sobrado: #{format_time(time_remaining(final))}")
  print_wolf
else
  puts a.asciify("BOOM  !!!!     ")
  print_bomb
end
loop do
  sleep 60
end
