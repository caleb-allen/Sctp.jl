const AF_INET = 2
const AF_INET6 = @static if Sys.iswindows() # AF_INET6 in <sys/socket.h>
    23
elseif Sys.isapple()
    30
elseif Sys.KERNEL ∈ (:FreeBSD, :DragonFly)
    28
elseif Sys.KERNEL ∈ (:NetBSD, :OpenBSD)
    24
else
    10
end

# /* Socket types. */
const SOCK_STREAM = 1 #  stream (connection) socket	
const SOCK_DGRAM = 2 #  datagram (conn.less) socket	
const SOCK_RAW = 3 #  raw socket			
const SOCK_RDM = 4 #  reliably-delivered message	
const SOCK_SEQPACKET = 5 #  sequential packet socket	

const SOL_IP = 0
const SOL_TCP = 6
const SOL_UDP = 17
const SOL_IPV6 = 41
const SOL_ICMPV6 = 58
const SOL_SCTP = 132
const IPPROTO_SCTP = 132
const SOL_UDPLITE = 136
const SOL_RAW = 255


const SaFamily = Cint

struct InAddr
  s_addr :: Cuint # address in network byte order
end

InAddr(address :: IPv4) = InAddr(hton(address.host))

abstract type SockAddr end

struct SockaddrIn <: SockAddr
  sin_family :: Cint # AF_INET
  sin_port :: Cushort # port in network byte order
  sin_addr :: InAddr # internet address
end
function SockaddrIn(address :: IPv4, port :: Integer)
  p = UInt16(port)
  SockaddrIn(AF_INET,
             hton(p),
             InAddr(address))
end
const SctpAssocT = Cuint

struct SctpSndinfo
  # the stream number to which the application wishes to send this message
  snd_sid :: UInt16
  # any of the following flags and is composed of bitwise OR of these values
  snd_flags :: UInt16
  snd_ppid :: UInt32
  snd_context :: UInt32
  snd_assoc_id :: SctpAssocT 
end

struct SctpUdpencaps
  # sue_address :: SockaddrStorage
  sue_address :: SockaddrIn
  sue_assoc_id :: UInt32
  sue_port :: UInt16
end


#  Flags that go into the sinfo->sinfo_flags field 
const SCTP_DATA_LAST_FRAG    = 0x0001 #  tail part of the message could not be sent 
const SCTP_DATA_NOT_FRAG    = 0x0003 #  complete message could not be sent 
const SCTP_NOTIFICATION    = 0x0010 #  next message is a notification 
const SCTP_COMPLETE    = 0x0020 #  next message is complete 
const SCTP_EOF    = 0x0100 #  Start shutdown procedures 
const SCTP_ABORT    = 0x0200 #  Send an ABORT to peer 
const SCTP_UNORDERED    = 0x0400 #  Message is un-ordered 
const SCTP_ADDR_OVER    = 0x0800 #  Override the primary-address 
const SCTP_SENDALL    = 0x1000 #  Send this on all associations 
const SCTP_EOR    = 0x2000 #  end of message signal 
const SCTP_SACK_IMMEDIATELY    = 0x4000 #  Set I-Bit 

# const INVALID_SINFO_FLAG    = (x) (((x) & 0xfffffff0 \
#                                     & ~(SCTP_EOF | SCTP_ABORT | SCTP_UNORDERED |\
# 				        SCTP_ADDR_OVER | SCTP_SENDALL | SCTP_EOR |\
# 					SCTP_SACK_IMMEDIATELY)) != 0)
#  for the endpoint 


const SCTP_SENDV_NOINFO     = 0 |> Cuint
const SCTP_SENDV_SNDINFO    = 1 |> Cuint
const SCTP_SENDV_PRINFO     = 2 |> Cuint
const SCTP_SENDV_AUTHINFO   = 3 |> Cuint
const SCTP_SENDV_SPA        = 4 |> Cuint

const SCTP_RECVV_NOINFO     = 0 |> Cuint
const SCTP_RECVV_RCVINFO    = 1 |> Cuint
const SCTP_RECVV_NXTINFO    = 2 |> Cuint
const SCTP_RECVV_RN         = 3 |> Cuint


# user socket options: socket API defined


# read-write options

const SCTP_RTOINFO    = 0x00000001
const SCTP_ASSOCINFO    = 0x00000002
const SCTP_INITMSG    = 0x00000003
const SCTP_NODELAY    = 0x00000004
const SCTP_AUTOCLOSE    = 0x00000005
const SCTP_PRIMARY_ADDR    = 0x00000007
const SCTP_ADAPTATION_LAYER    = 0x00000008
const SCTP_DISABLE_FRAGMENTS    = 0x00000009
const SCTP_PEER_ADDR_PARAMS    = 0x0000000a
#  ancillary data/notification interest options 
#  Without this applied we will give V4 and V6 addresses on a V6 socket 
const SCTP_I_WANT_MAPPED_V4_ADDR    = 0x0000000d
const SCTP_MAXSEG    = 0x0000000e
const SCTP_DELAYED_SACK    = 0x0000000f
const SCTP_FRAGMENT_INTERLEAVE    = 0x00000010
const SCTP_PARTIAL_DELIVERY_POINT    = 0x00000011
#  authentication support 
const SCTP_HMAC_IDENT    = 0x00000014
const SCTP_AUTH_ACTIVE_KEY    = 0x00000015
const SCTP_AUTO_ASCONF    = 0x00000018
const SCTP_MAX_BURST    = 0x00000019
#  assoc level context 
const SCTP_CONTEXT    = 0x0000001a
#  explicit EOR signalling 
const SCTP_EXPLICIT_EOR    = 0x0000001b
const SCTP_REUSE_PORT    = 0x0000001c

const SCTP_EVENT    = 0x0000001e
const SCTP_RECVRCVINFO    = 0x0000001f
const SCTP_RECVNXTINFO    = 0x00000020
const SCTP_DEFAULT_SNDINFO    = 0x00000021
const SCTP_DEFAULT_PRINFO    = 0x00000022
const SCTP_REMOTE_UDP_ENCAPS_PORT    = 0x00000024
const SCTP_ECN_SUPPORTED    = 0x00000025
const SCTP_PR_SUPPORTED    = 0x00000026
const SCTP_AUTH_SUPPORTED    = 0x00000027
const SCTP_ASCONF_SUPPORTED    = 0x00000028
const SCTP_RECONFIG_SUPPORTED    = 0x00000029
const SCTP_NRSACK_SUPPORTED    = 0x00000030
const SCTP_PKTDROP_SUPPORTED    = 0x00000031
const SCTP_MAX_CWND    = 0x00000032

const SCTP_ENABLE_STREAM_RESET    = 0x00000900 #  struct sctp_assoc_value 

#  Pluggable Stream Scheduling Socket option 
const SCTP_PLUGGABLE_SS    = 0x00001203
const SCTP_SS_VALUE    = 0x00001204


# read-only options

const SCTP_STATUS    = 0x00000100
const SCTP_GET_PEER_ADDR_INFO    = 0x00000101
#  authentication support 
const SCTP_PEER_AUTH_CHUNKS    = 0x00000102
const SCTP_LOCAL_AUTH_CHUNKS    = 0x00000103
const SCTP_GET_ASSOC_NUMBER    = 0x00000104
const SCTP_GET_ASSOC_ID_LIST    = 0x00000105
const SCTP_TIMEOUTS    = 0x00000106
const SCTP_PR_STREAM_STATUS    = 0x00000107
const SCTP_PR_ASSOC_STATUS    = 0x00000108

# write-only options
 
const SCTP_SET_PEER_PRIMARY_ADDR    = 0x00000006
const SCTP_AUTH_CHUNK    = 0x00000012
const SCTP_AUTH_KEY    = 0x00000013
const SCTP_AUTH_DEACTIVATE_KEY    = 0x0000001d
const SCTP_AUTH_DELETE_KEY    = 0x00000016
const SCTP_RESET_STREAMS    = 0x00000901 #  struct sctp_reset_streams 
const SCTP_RESET_ASSOC    = 0x00000902 #  sctp_assoc_t 
const SCTP_ADD_STREAMS    = 0x00000903 #  struct sctp_add_streams 


