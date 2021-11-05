using Sctp
import Sctp: SockaddrIn
import Sockets: IPv4
import Sockets: @ip_str
sctp_init(true)
# s1addr = SockaddrIn(ip"0.0.0.0")
@show s = SCTPSocket()
@show b = bind(s, ip"0.0.0.0")
if b < 0
  error("bind failed")
end
# listen(s1, 10)

# @show s2 = SCTPSocket()

payload = Cint[1, 2, 3, 4, 5]

addr = SockaddrIn(ip"127.0.0.1", 7)
#function test()
#  global t1 = @async begin
#    @show sendv(s2, s1addr, payload) 
#  end

#  global t2 = @async begin
#    @show recvv(s1)
#  end
#  #
#end

function stop()
  # wait(t1)
  # wait(t2)

  close(s)
  # close(s2)
  sctp_finish()
end


