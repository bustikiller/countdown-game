require 'pry'
require 'artii'
require 'active_support'
require 'io/console'

require_relative 'helpers'


a = Artii::Base.new :font => 'ogre'
b = Artii::Base.new :font => 'catwalk'
c = Artii::Base.new :font => 'cosmic'
d = Artii::Base.new :font => 'invita'
clear
puts 'Introduce el tiempo en minutos'
minutes = gets.chomp.to_i

clear

puts 'Introduce la clave de desactivación'
bomb_key = gets.chomp
accumulated_key = []
(bomb_key.length).times { accumulated_key << "*" }
bomb_deactivated = false

final = Time.now + minutes * 60

loop do
  
  pressed_key = nil  
  count = 0
  begin
    clear
    3.times { puts }
    puts a.asciify("SE ESTA ACABANDO EL TIEMPO...")
    3.times { puts }
    puts d.asciify("#{format_time(time_remaining(final))}")
    3.times { puts }
    puts c.asciify("Introduce   la     clave   :\n\n")
    3.times { puts }
    print b.asciify("#{accumulated_key.join}")
    break if Time.now > final

    Timeout.timeout(1) do
      pressed_key = STDIN.getch
      raise Timeout::Error
    end 

    rescue Timeout::Error
      if pressed_key
        accumulated_key[count] = pressed_key
        count = count.next
        pressed_key = nil
      end
      
      if accumulated_key.join == bomb_key
        bomb_deactivated = true
        break
      end
      
      if accumulated_key[bomb_key.length-1] != "*" && accumulated_key.join != bomb_key
        final = final-30
        accumulated_key.clear
        (bomb_key.length).times { accumulated_key << "*" }
        count = 0
        pressed_key = nil
      end
      
    retry
  end
end

clear

if bomb_deactivated
  puts a.asciify("Bomba desactivada! Ha sobrado #{format_time(time_remaining(final))}")
  puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@'~~~     ~~~`@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@@@@@@@@'                     `@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@@@@@'                           `@@@@@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@@@'                               `@@@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@'                                   `@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@'                                     `@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@'                                       `@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@                                         @@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@'                                         `@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@                                           @@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@                                           @@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@                       n,                  @@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@                     _/ | _                @@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@                    /'  `'/                @@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@a                 <~    .'                a@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@                 .'    |                 @@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@a              _/      |                a@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@a           _/      `.`.              a@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@a     ____/ '   \__ | |______       a@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@@@a__/___/      /__\ \ \     \___.a@@@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@@@/  (___.'\_______)\_|_|        \@@@@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@@|\________                       ~~~~~\@@@@@@@@@@@@@@@@@@
  ~~~\@@@@@@@@@@@@@@||       |\___________________________/|@/~~~~~~~~~~~\@@@
      |~~~~\@@@@@@@/ |  |    | | by: S.C.E.S.W.          | ||\____________|@@ "
else
  puts c.asciify("BOOM  !!!!     ")
  print "     _.-^^---....,,--
  _--                  --_
  <                        >)
  |                         |
  \._                   _./
     ```--. . , ; .--'''
           | |   |
        .-=||  | |=-.
        `-=#$%&%$#=-'
           | ;  :|
  _____.,-#%&$@%#&#~,._____"
end

loop do
  sleep 60
end

