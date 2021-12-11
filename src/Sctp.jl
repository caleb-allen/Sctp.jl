# references
#https://github.com/sctplab/usrsctp/blob/master/Manual.md
#https://tools.ietf.org/html/rfc6458#section-4.1.2
#https://github.com/JuliaLang/julia/blob/master/stdlib/Sockets/src/Sockets.jl
#https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/#Closure-cfunctions
#https://man7.org/linux/man-pages/man2/bind.2.html
module Sctp

include("UsrSctp.jl")
using .UsrSctp
include("defines.jl")
# using Sockets
import Sockets: IPv4, IPv6, @ip_str
export IPv4, @ip_str
export SockaddrIn
export sctp_init, SctpSocket
# import Base.close


"""
    Every application has to start with usrsctp_init(). This function calls sctp_init() and reserves the memory necessary to administer the data transfer.
    The flag `use_udp` determines whether to use SCTP over UDP. Defaults to false
"""
function sctp_init(use_udp=false)
    udp_port = use_udp ? 9899 : 0
    UsrSctp.usrsctp_init(udp_port, Ptr{Cvoid}(), Ptr{Cvoid}())
end

function sctp_finish()
  # @show 
  
  ccall((:usrsctp_finish, "libusrsctp"), Cint, ())
end

struct SctpSocket
  ptr :: Ptr{UsrSctp.Socket}
end

function SctpSocket end

# function SCTPSocket(
#     domain :: Cint,
#     type :: Cint,
#     protocol :: Cint,
#     receive_cb :: Ptr{Cvoid},
#     send_cb :: Ptr{Cvoid},
#     sb_threshold :: Cuint,
function SctpSocket()
    ptr = UsrSctp.usrsctp_socket(
        AF_INET6,
        SOCK_SEQPACKET,
        SOL_SCTP,
        Ptr{Cvoid}(), #receive_cb
        Ptr{Cvoid}(), #send_cb
        0, # sb_threshold
        Ptr{Cvoid}()#ulp_info
    )
    if ptr === nothing # TODO if ptr == 0
        error("socket was not created")
    end
    return SctpSocket(ptr)
end


function SctpSocket(ptr :: Union{Ptr{}, Nothing})
  if ptr === nothing
    error("socket was not created")
  else
    return SctpSocket(ptr)
  end

end
function Base.bind(so :: SctpSocket,
                  addr :: IPv4,
                  port :: Integer = 0) # default 0, allow OS to choose ephemeral port
    p :: Cushort = UInt16(port)
    # sock_addr = UsrSctp.in_addr()
    sockaddr = UsrSctp.sockaddr_in(AF_INET,
                                hton(p),
                                UsrSctp.in_addr(hton(addr.host)),
                                (Cuchar(0) for _ in 1:8) |> collect |> Tuple)
    addrlen = sizeof(sockaddr)
    UsrSctp.usrsctp_bind(so.ptr, Ref(sockaddr), addrlen)                     
end

#=
function connect(so :: SCTPSocket,
                sockaddr :: SockaddrIn)
  addrlen = sizeof(sockaddr)
  if ccall((:usrsctp_connect, "libusrsctp"), Cint, (Ptr{Cvoid}, Ref{SockaddrIn}, Cint), so.ptr, sockaddr, addrlen) < 0
    printcerr()
  end
end

"""
    An application uses listen() to mark a socket as being able to accept new associations.
    if `backlog` is non-zero, enable listening, else disable listening.
"""
function listen(so :: SCTPSocket,
                backlog :: Int)
  ccall((:usrsctp_listen, "libusrsctp"), Cint, (Ptr{Cvoid}, Cint), so.ptr, backlog)
end

function accept(so :: SCTPSocket,
                addr :: IPv4,
                port :: Cushort) :: SCTPSocket
  sockaddr = SockaddrIn(addr, port)
  addrlen = sizeof(sockaddr)
  ptr = ccall((:usrsctp_bind, "libusrsctp"), Cint, (Ptr{Cvoid}, Ref{SockaddrIn}, Cint), so.ptr, sockaddr, addrlen)
  return SCTPSocket(ptr)
end

function Base.close(so :: SCTPSocket)
  ccall((:usrsctp_socket, "libusrsctp"), Cvoid, (Ptr{Cvoid},), so.ptr)
end


# return # of bytes sent, or -1 if error
function sendv(so :: SCTPSocket,
                  # can be nothing in the case of a connected socket
                  addr :: Union{SockaddrIn, Nothing},
                  data :: Vector{Cint})
  # info = nothing
  info = SctpSndinfo(
                     0,
  # snd_sid :: UInt16
                     SCTP_UNORDERED,
  # snd_flags :: UInt16
                     0,
  # snd_ppid :: UInt32
                    0,
  # snd_context :: UInt32
                    0
  # snd_assoc_id :: SctpAssocT 
 )
  res = ccall((:usrsctp_sendv, "libusrsctp"), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, Ptr{SockaddrIn}, Cint, Ptr{Cvoid}, Cuint, Cint, Cint),
        so.ptr,
        # "gather buffer", treated as user message
        Ref(data),
        sizeof(data), # number of elements in iov
        Ref(addr),
        # number of addresses (max 1)
        # 1
        addr === nothing ? 0 : 1,
        # Ref(info),
        Ref{Cvoid}(nothing),
        # sizeof(info), # length of info
        0,
        SCTP_SENDV_NOINFO,
        # SCTP_SENDV_SNDINFO,
        0 # flags
       )

  if res < 0
    printcerr()
  end
end

function printcerr()
  println("Error $(Libc.errno()): $(Libc.strerror())")
end
function recvv(so :: SCTPSocket)
  dbuf = Array{Cint}(undef, 2048)
  @show from = Ref{SockaddrIn}()
  fromlen = Ref(Cint(sizeof(from)))
  info = nothing
  infolen = Ref(Cint(sizeof(info)))
  bytes_recvd = ccall((:usrsctp_recvv, "libusrsctp"), Cint, (Ptr{Cvoid}, Ptr{Cvoid}, Cint, Ptr{SockaddrIn}, Ptr{Cint}, Ptr{Cvoid}, Ptr{Cint}, Cuint, Cint),
        so.ptr,
        # "gather buffer", treated as user message
        dbuf,
        sizeof(dbuf), # number of elements in iov
        from,
        fromlen,
        Ref(info),
        infolen,
        SCTP_RECVV_NOINFO,
        0 # flags
       )
  @show bytes_recvd
  @show from
  return dbuf
end 

function remote_udp_encaps_port(so :: SCTPSocket)
  getsockopt(so, SCTP_REMOTE_UDP_ENCAPS_PORT)
# SCTP_REMOTE_UDP_ENCAPS_PORT    
end

function remote_udp_encaps_port!(so :: SCTPSocket, port :: Integer)
  udp_encaps = SctpUdpencaps(
                             SockaddrIn(ip"127.0.0.1", 7),
                             0,
                             Cushort(port)
                            )
  setsockopt(so, SCTP_REMOTE_UDP_ENCAPS_PORT, udp_encaps)
# SCTP_REMOTE_UDP_ENCAPS_PORT    
end



function getsockopt(so :: SCTPSocket,
                    optname :: Integer)
  optval = Ref(Array{Cuint}(undef, 2048))
  @show optlen = Ref{Cuint}(sizeof(optval.x))
  funcall = ccall((:usrsctp_getsockopt, "libusrsctp"), Cint, (Ptr{Cvoid}, Cint, Cint, Ptr{Cvoid}, Ptr{Cuint}),
        so.ptr,
        SOL_SCTP,
        Cint(optname),
        optval,
        optlen
       )
  if funcall < 0
    printcerr()
    return
  end
  @show optlen
  result = optval.x[1:optlen.x]
  return result
end

function setsockopt(so :: SCTPSocket,
                    optname :: Integer,
                    optval)
  # optval = Ref(Array{Cuint}(undef, 2048))
  @show optlen = sizeof(optval)
  funcall = ccall((:usrsctp_setsockopt, "libusrsctp"), Cint, (Ptr{Cvoid}, Cint, Cint, Ptr{Cvoid}, Cint),
        so.ptr,
        SOL_SCTP,
        Cint(optname),
        Ref(optval),
        optlen
       )
  if funcall < 0
    printcerr()
    return
  end
  # result = optval.x[1:optlen.x]
end

=#

end

