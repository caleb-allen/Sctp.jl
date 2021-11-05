# https://github.com/sctplab/usrsctp
struct SctpCommonHeader
    source_port::UInt16
    destination_port::UInt16
    verification_tag::UInt32
    crc32c::UInt32
end

struct SockAddrConn
	sconn_family::UInt16
    sconn_port::UInt16
	# void *sconn_addr;
    sconn_addr::Ptr{Cvoid}
end


# struct sctp_sockstore
    # sin::SockAddr
const SCTP_FUTURE_ASSOC     = 0
const SCTP_CURRENT_ASSOC    = 1
const SCTP_ALL_ASSOC        = 2

const SCTP_EVENT_READ       = 0x0001
const SCTP_EVENT_WRITE      = 0x0002
const SCTP_EVENT_ERROR      = 0x0004

#  Structures and definitions to use the socket API
const SCTP_ALIGN_RESV_PAD       = 92
const SCTP_ALIGN_RESV_PAD_SHORT = 92

const SctpAssocT = Cuint


struct SctpRcvInfo
    rcv_sid::UInt16
    rcv_ssn::UInt16
    rcv_flags::UInt16
    rcv_ppid::UInt32
    rcv_tsn::UInt32
    rcv_cumtsn::UInt32
    rcv_context::UInt32
    rcv_assoc_id::SctpAssocT
end

struct SctpNxtInfo
    nxt_sid::UInt16
    nxt_flags::UInt16
    nxt_ppid::UInt32
    nxt_length::UInt32
    nxt_assoc_id::SctpAssocT
end

const SCTP_NO_NEXT_MSG              = 0x0000
const SCTP_NEXT_MSG_AVAIL           = 0x0001
const SCTP_NEXT_MSG_ISCOMPLETE      = 0x0002
const SCTP_NEXT_MSG_IS_UNORDERED    = 0x0004
const SCTP_NEXT_MSG_IS_NOTIFICATION = 0x0008

struct SctpRecvvRn
    recvv_rcvinfo::SctpRcvInfo
    recvv_nxtinfo::SctpNxtInfo
end
const SCTP_RECVV_NOINFO     = 0
const SCTP_RECVV_RCVINFO    = 1
const SCTP_RECVV_NXTINFO    = 2
const SCTP_RECVV_RN         = 3

const SCTP_SENDV_NOINFO     = 0
const SCTP_SENDV_SNDINFO    = 1
const SCTP_SENDV_PRINFO     = 2
const SCTP_SENDV_AUTHINFO   = 3
const SCTP_SENDV_SPA        = 4

const SCTP_SEND_SNDINFO_VALID  = 0x00000001
const SCTP_SEND_PRINFO_VALID   = 0x00000002
const SCTP_SEND_AUTHINFO_VALID = 0x00000004

struct SctpSndAllCompletes
sall_stream :: UInt16
sall_flags :: UInt16
sall_ppid :: UInt32
sall_context :: UInt32
sall_num_sent :: UInt32
sall_num_failed :: UInt32
end

struct SctpSndinfo
snd_sid :: UInt16
snd_flags :: UInt16
snd_ppid :: UInt32
snd_context :: UInt32
	snd_assoc_id :: SctpAssocT 
end

struct SctpPrinfo
pr_policy :: UInt16
pr_value :: UInt32
end

struct SctpAuthinfo
auth_keynumber :: UInt16
end

# using Sockets
struct SctpSendvSpa
sendv_flags :: UInt32
  sendv_sndinfo :: SctpSndinfo
  sendv_prinfo :: SctpPrinfo
  sendv_authinfo :: SctpAuthinfo
end

struct SctpUdpencaps
  sue_address :: SockaddrStorage
sue_assoc_id :: UInt32
sue_port :: UInt16
end

# *******  Notifications  *************

#  notification types 
const SCTP_ASSOC_CHANGE    = 0x0001
const SCTP_PEER_ADDR_CHANGE    = 0x0002
const SCTP_REMOTE_ERROR    = 0x0003
const SCTP_SEND_FAILED    = 0x0004
const SCTP_SHUTDOWN_EVENT    = 0x0005
const SCTP_ADAPTATION_INDICATION    = 0x0006
const SCTP_PARTIAL_DELIVERY_EVENT    = 0x0007
const SCTP_AUTHENTICATION_EVENT    = 0x0008
const SCTP_STREAM_RESET_EVENT    = 0x0009
const SCTP_SENDER_DRY_EVENT    = 0x000a
const SCTP_NOTIFICATIONS_STOPPED_EVENT    = 0x000b
const SCTP_ASSOC_RESET_EVENT    = 0x000c
const SCTP_STREAM_CHANGE_EVENT    = 0x000d
const SCTP_SEND_FAILED_EVENT    = 0x000e

#  notification event structures 

#  association change event 
struct SctpAssocChange
sac_type :: UInt16
sac_flags :: UInt16
sac_length :: UInt32
sac_state :: UInt16
sac_error :: UInt16
sac_outbound_streams :: UInt16
sac_inbound_streams :: UInt16
	sac_assoc_id :: SctpAssocT
sac_info[] :: UInt8 #  not available yet 
end

#  sac_state values 
const SCTP_COMM_UP    = 0x0001
const SCTP_COMM_LOST    = 0x0002
const SCTP_RESTART    = 0x0003
const SCTP_SHUTDOWN_COMP    = 0x0004
const SCTP_CANT_STR_ASSOC    = 0x0005

#  sac_info values 
const SCTP_ASSOC_SUPPORTS_PR    = 0x01
const SCTP_ASSOC_SUPPORTS_AUTH    = 0x02
const SCTP_ASSOC_SUPPORTS_ASCONF    = 0x03
const SCTP_ASSOC_SUPPORTS_MULTIBUF    = 0x04
const SCTP_ASSOC_SUPPORTS_RE_CONFIG    = 0x05
const SCTP_ASSOC_SUPPORTS_INTERLEAVING    = 0x06
const SCTP_ASSOC_SUPPORTS_MAX    = 0x06

#  Address event 
struct SctpPaddrChange
spc_type :: UInt16
spc_flags :: UInt16
spc_length :: UInt32
  spc_aaddr :: SockaddrStorage
spc_state :: UInt32
spc_error :: UInt32
	spc_assoc_id :: SctpAssocT
spc_padding[4] :: UInt8
end

#  paddr state values 
const SCTP_ADDR_AVAILABLE    = 0x0001
const SCTP_ADDR_UNREACHABLE    = 0x0002
const SCTP_ADDR_REMOVED    = 0x0003
const SCTP_ADDR_ADDED    = 0x0004
const SCTP_ADDR_MADE_PRIM    = 0x0005
const SCTP_ADDR_CONFIRMED    = 0x0006

#  remote error events 
struct SctpRemoteError
sre_type :: UInt16
sre_flags :: UInt16
sre_length :: UInt32
sre_error :: UInt16
	sre_assoc_id :: SctpAssocT
sre_data[] :: UInt8
end

#  shutdown event 
struct SctpShutdownEvent
sse_type :: UInt16
sse_flags :: UInt16
sse_length :: UInt32
	sse_assoc_id :: SctpAssocT
end

#  Adaptation layer indication 
struct SctpAdaptationEvent
sai_type :: UInt16
sai_flags :: UInt16
sai_length :: UInt32
sai_adaptation_ind :: UInt32
	sai_assoc_id :: SctpAssocT
end

#  Partial delivery event 
struct SctpPdapiEvent
pdapi_type :: UInt16
pdapi_flags :: UInt16
pdapi_length :: UInt32
pdapi_indication :: UInt32
pdapi_stream :: UInt32
pdapi_seq :: UInt32
	pdapi_assoc_id :: SctpAssocT
end

#  indication values 
const SCTP_PARTIAL_DELIVERY_ABORTED    = 0x0001

#  SCTP authentication event 
struct SctpAuthkeyEvent
auth_type :: UInt16
auth_flags :: UInt16
auth_length :: UInt32
auth_keynumber :: UInt16
auth_indication :: UInt32
	auth_assoc_id :: SctpAssocT
end

#  indication values 
const SCTP_AUTH_NEW_KEY    = 0x0001
const SCTP_AUTH_NO_AUTH    = 0x0002
const SCTP_AUTH_FREE_KEY    = 0x0003

#  SCTP sender dry event 
struct SctpSenderDryEvent
sender_dry_type :: UInt16
sender_dry_flags :: UInt16
sender_dry_length :: UInt32
	sender_dry_assoc_id :: SctpAssocT
end


#  Stream reset event - subscribe to SCTP_STREAM_RESET_EVENT 
struct SctpStreamResetEvent
strreset_type :: UInt16
strreset_flags :: UInt16
strreset_length :: UInt32
	strreset_assoc_id :: SctpAssocT
strreset_stream_list[] :: UInt16
end

#  flags in stream_reset_event (strreset_flags) 
const SCTP_STREAM_RESET_INCOMING_SSN    = 0x0001
const SCTP_STREAM_RESET_OUTGOING_SSN    = 0x0002
const SCTP_STREAM_RESET_DENIED    = 0x0004 #  SCTP_STRRESET_FAILED 
const SCTP_STREAM_RESET_FAILED    = 0x0008 #  SCTP_STRRESET_FAILED 
const SCTP_STREAM_CHANGED_DENIED    = 0x0010

const SCTP_STREAM_RESET_INCOMING    = 0x00000001
const SCTP_STREAM_RESET_OUTGOING    = 0x00000002


#  Assoc reset event - subscribe to SCTP_ASSOC_RESET_EVENT 
struct SctpAssocResetEvent
assocreset_type :: UInt16
assocreset_flags :: UInt16
assocreset_length :: UInt32
	assocreset_assoc_id :: SctpAssocT
assocreset_local_tsn :: UInt32
assocreset_remote_tsn :: UInt32
end

const SCTP_ASSOC_RESET_DENIED    = 0x0004
const SCTP_ASSOC_RESET_FAILED    = 0x0008


#  Stream change event - subscribe to SCTP_STREAM_CHANGE_EVENT 
struct SctpStreamChangeEvent
strchange_type :: UInt16
strchange_flags :: UInt16
strchange_length :: UInt32
	strchange_assoc_id :: SctpAssocT
strchange_instrms :: UInt16
strchange_outstrms :: UInt16
end

const SCTP_STREAM_CHANGE_DENIED    = 0x0004
const SCTP_STREAM_CHANGE_FAILED    = 0x0008


#  SCTP send failed event 
struct SctpSendFailedEvent
ssfe_type :: UInt16
ssfe_flags :: UInt16
ssfe_length :: UInt32
ssfe_error :: UInt32
  ssfe_info :: SctpSndinfo
	ssfe_assoc_id :: SctpAssocT
 ssfe_data[] :: UInt8
end

#  flag that indicates state of data 
const SCTP_DATA_UNSENT    = 0x0001	#  inqueue never on wire 
const SCTP_DATA_SENT    = 0x0002	#  on wire at failure 

#  SCTP event option 
struct SctpEvent
	se_assoc_id :: SctpAssocT
      se_type :: UInt16
       se_on :: UInt8
end

union sctp_notification {
	struct sctp_tlv
sn_type :: UInt16
sn_flags :: UInt16
sn_length :: UInt32
	} sn_header;
  sn_assoc_change :: SctpAssocChange
  sn_paddr_change :: SctpPaddrChange
  sn_remote_error :: SctpRemoteError
  sn_shutdown_event :: SctpShutdownEvent
  sn_adaptation_event :: SctpAdaptationEvent
  sn_pdapi_event :: SctpPdapiEvent
  sn_auth_event :: SctpAuthkeyEvent
  sn_sender_dry_event :: SctpSenderDryEvent
  sn_send_failed_event :: SctpSendFailedEvent
  sn_strreset_event :: SctpStreamResetEvent
  sn_assocreset_event :: SctpAssocResetEvent
  sn_strchange_event :: SctpStreamChangeEvent
end

struct SctpEventSubscribe
sctp_data_io_event :: UInt8
sctp_association_event :: UInt8
sctp_address_event :: UInt8
sctp_send_failure_event :: UInt8
sctp_peer_error_event :: UInt8
sctp_shutdown_event :: UInt8
sctp_partial_delivery_event :: UInt8
sctp_adaptation_layer_event :: UInt8
sctp_authentication_event :: UInt8
sctp_sender_dry_event :: UInt8
sctp_stream_reset_event :: UInt8
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

const INVALID_SINFO_FLAG    = (x) (((x) & 0xfffffff0 \
                                    & ~(SCTP_EOF | SCTP_ABORT | SCTP_UNORDERED |\
				        SCTP_ADDR_OVER | SCTP_SENDALL | SCTP_EOR |\
					SCTP_SACK_IMMEDIATELY)) != 0)
#  for the endpoint 

#  The lower byte is an enumeration of PR-SCTP policies 
const SCTP_PR_SCTP_NONE    = 0x0000 #  Reliable transfer 
const SCTP_PR_SCTP_TTL    = 0x0001 #  Time based PR-SCTP 
const SCTP_PR_SCTP_BUF    = 0x0002 #  Buffer based PR-SCTP 
const SCTP_PR_SCTP_RTX    = 0x0003 #  Number of retransmissions based PR-SCTP 

const PR_SCTP_POLICY    = (x)         ((x) & 0x0f)
const PR_SCTP_ENABLED    = (x)        (PR_SCTP_POLICY(x) != SCTP_PR_SCTP_NONE)
const PR_SCTP_TTL_ENABLED    = (x)    (PR_SCTP_POLICY(x) == SCTP_PR_SCTP_TTL)
const PR_SCTP_BUF_ENABLED    = (x)    (PR_SCTP_POLICY(x) == SCTP_PR_SCTP_BUF)
const PR_SCTP_RTX_ENABLED    = (x)    (PR_SCTP_POLICY(x) == SCTP_PR_SCTP_RTX)
const PR_SCTP_INVALID_POLICY    = (x) (PR_SCTP_POLICY(x) > SCTP_PR_SCTP_RTX)


/*
 * user socket options: socket API defined
 */
/*
 * read-write options
 */
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

/*
 * read-only options
 */
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

/*
 * write-only options
 */
const SCTP_SET_PEER_PRIMARY_ADDR    = 0x00000006
const SCTP_AUTH_CHUNK    = 0x00000012
const SCTP_AUTH_KEY    = 0x00000013
const SCTP_AUTH_DEACTIVATE_KEY    = 0x0000001d
const SCTP_AUTH_DELETE_KEY    = 0x00000016
const SCTP_RESET_STREAMS    = 0x00000901 #  struct sctp_reset_streams 
const SCTP_RESET_ASSOC    = 0x00000902 #  sctp_assoc_t 
const SCTP_ADD_STREAMS    = 0x00000903 #  struct sctp_add_streams 

struct SctpInitmsg
sinit_num_ostreams :: UInt16
sinit_max_instreams :: UInt16
sinit_max_attempts :: UInt16
sinit_max_init_timeo :: UInt16
end

struct SctpRtoinfo
	srto_assoc_id :: SctpAssocT
srto_initial :: UInt32
srto_max :: UInt32
srto_min :: UInt32
end

struct SctpAssocparams
	sasoc_assoc_id :: SctpAssocT
sasoc_peer_rwnd :: UInt32
sasoc_local_rwnd :: UInt32
sasoc_cookie_life :: UInt32
sasoc_asocmaxrxt :: UInt16
sasoc_number_peer_destinations :: UInt16
end

struct SctpSetprim
  ssp_addr :: SockaddrStorage
	ssp_assoc_id :: SctpAssocT
ssp_padding[4] :: UInt8
end

struct SctpSetadaptation
  ssb_adaptation_ind :: UInt32
end

struct SctpPaddrparams
  spp_address :: SockaddrStorage
	spp_assoc_id :: SctpAssocT
spp_hbinterval :: UInt32
spp_pathmtu :: UInt32
spp_flags :: UInt32
spp_ipv6_flowlabel :: UInt32
spp_pathmaxrxt :: UInt16
spp_dscp :: UInt8
end

const SPP_HB_ENABLE    = 0x00000001
const SPP_HB_DISABLE    = 0x00000002
const SPP_HB_DEMAND    = 0x00000004
const SPP_PMTUD_ENABLE    = 0x00000008
const SPP_PMTUD_DISABLE    = 0x00000010
const SPP_HB_TIME_IS_ZERO    = 0x00000080
const SPP_IPV6_FLOWLABEL    = 0x00000100
const SPP_DSCP    = 0x00000200

#  Used for SCTP_MAXSEG, SCTP_MAX_BURST, SCTP_ENABLE_STREAM_RESET, and SCTP_CONTEXT 
struct SctpAssocValue
	assoc_id :: SctpAssocT
assoc_value :: UInt32
end

#  To enable stream reset 
const SCTP_ENABLE_RESET_STREAM_REQ    = 0x00000001
const SCTP_ENABLE_RESET_ASSOC_REQ    = 0x00000002
const SCTP_ENABLE_CHANGE_ASSOC_REQ    = 0x00000004
const SCTP_ENABLE_VALUE_MASK    = 0x00000007

struct SctpResetStreams
	srs_assoc_id :: SctpAssocT
srs_flags :: UInt16
srs_number_streams :: UInt16  #  0 == ALL 
srs_stream_list[] :: UInt16   #  list if strrst_num_streams is not 0 
end

struct SctpAddStreams
	sas_assoc_id :: SctpAssocT
sas_instrms :: UInt16
sas_outstrms :: UInt16
end

struct SctpHmacalgo
shmac_number_of_idents :: UInt32
shmac_idents[] :: UInt16
end

#  AUTH hmac_id 
const SCTP_AUTH_HMAC_ID_RSVD    = 0x0000
const SCTP_AUTH_HMAC_ID_SHA1    = 0x0001	#  default, mandatory 
const SCTP_AUTH_HMAC_ID_SHA256    = 0x0003
const SCTP_AUTH_HMAC_ID_SHA224    = 0x0004
const SCTP_AUTH_HMAC_ID_SHA384    = 0x0005
const SCTP_AUTH_HMAC_ID_SHA512    = 0x0006


struct SctpSackInfo
	sack_assoc_id :: SctpAssocT
sack_delay :: UInt32
sack_freq :: UInt32
end

struct SctpDefaultPrinfo
pr_policy :: UInt16
pr_value :: UInt32
	pr_assoc_id :: SctpAssocT
end

struct SctpPaddrinfo
  spinfo_address :: SockaddrStorage
	spinfo_assoc_id :: SctpAssocT
	int32_t spinfo_state;
spinfo_cwnd :: UInt32
spinfo_srtt :: UInt32
spinfo_rto :: UInt32
spinfo_mtu :: UInt32
end

struct SctpStatus
	sstat_assoc_id :: SctpAssocT
	int32_t  sstat_state;
sstat_rwnd :: UInt32
sstat_unackdata :: UInt16
sstat_penddata :: UInt16
sstat_instrms :: UInt16
sstat_outstrms :: UInt16
sstat_fragmentation_point :: UInt32
  sstat_primary :: SctpPaddrinfo
end

/*
 * user state values
 */
const SCTP_CLOSED    = 0x0000
const SCTP_BOUND    = 0x1000
const SCTP_LISTEN    = 0x2000
const SCTP_COOKIE_WAIT    = 0x0002
const SCTP_COOKIE_ECHOED    = 0x0004
const SCTP_ESTABLISHED    = 0x0008
const SCTP_SHUTDOWN_SENT    = 0x0010
const SCTP_SHUTDOWN_RECEIVED    = 0x0020
const SCTP_SHUTDOWN_ACK_SENT    = 0x0040
const SCTP_SHUTDOWN_PENDING    = 0x0080


const SCTP_ACTIVE    = 0x0001  #  SCTP_ADDR_REACHABLE 
const SCTP_INACTIVE    = 0x0002  /* neither SCTP_ADDR_REACHABLE
                                     nor SCTP_ADDR_UNCONFIRMED */
const SCTP_UNCONFIRMED    = 0x0200  #  SCTP_ADDR_UNCONFIRMED 

struct SctpAuthchunks
	gauth_assoc_id :: SctpAssocT
#gauth_number_of_chunks :: UInt32 not available 
 gauth_chunks[] :: UInt8
end

struct SctpAssocIds
gaids_number_of_ids :: UInt32
	sctp_assoc_t gaids_assoc_id[];
end

struct SctpSetpeerprim
  sspp_addr :: SockaddrStorage
	sspp_assoc_id :: SctpAssocT
sspp_padding[4] :: UInt8
end

struct SctpAuthchunk
sauth_chunk :: UInt8
end


struct SctpGetNonceValues
	gn_assoc_id :: SctpAssocT
gn_peers_tag :: UInt32
gn_local_tag :: UInt32
end


/*
 * Main SCTP chunk types
 */
# ***********0x00 series **********
const SCTP_DATA    = 0x00
const SCTP_INITIATION    = 0x01
const SCTP_INITIATION_ACK    = 0x02
const SCTP_SELECTIVE_ACK    = 0x03
const SCTP_HEARTBEAT_REQUEST    = 0x04
const SCTP_HEARTBEAT_ACK    = 0x05
const SCTP_ABORT_ASSOCIATION    = 0x06
const SCTP_SHUTDOWN    = 0x07
const SCTP_SHUTDOWN_ACK    = 0x08
const SCTP_OPERATION_ERROR    = 0x09
const SCTP_COOKIE_ECHO    = 0x0a
const SCTP_COOKIE_ACK    = 0x0b
const SCTP_ECN_ECHO    = 0x0c
const SCTP_ECN_CWR    = 0x0d
const SCTP_SHUTDOWN_COMPLETE    = 0x0e
#  RFC4895 
const SCTP_AUTHENTICATION    = 0x0f
#  EY nr_sack chunk id
const SCTP_NR_SELECTIVE_ACK    = 0x10
# ***********0x40 series **********
# ***********0x80 series **********
#  RFC5061 
const SCTP_ASCONF_ACK    = 0x80
#  draft-ietf-stewart-pktdrpsctp 
const SCTP_PACKET_DROPPED    = 0x81
#  draft-ietf-stewart-strreset-xxx 
const SCTP_STREAM_RESET    = 0x82

#  RFC4820                         
const SCTP_PAD_CHUNK    = 0x84
# ***********0xc0 series **********
#  RFC3758 
const SCTP_FORWARD_CUM_TSN    = 0xc0
#  RFC5061 
const SCTP_ASCONF    = 0xc1

struct SctpAuthkey
	sca_assoc_id :: SctpAssocT
sca_keynumber :: UInt16
sca_keylength :: UInt16
 sca_key[] :: UInt8
end

struct SctpAuthkeyid
	scact_assoc_id :: SctpAssocT
scact_keynumber :: UInt16
end

struct SctpCcOption
	int option;
  aid_value :: SctpAssoc_value
end

struct SctpStreamValue
	assoc_id :: SctpAssocT
stream_id :: UInt16
stream_value :: UInt16
end

struct SctpTimeouts
	stimo_assoc_id :: SctpAssocT
stimo_init :: UInt32
stimo_data :: UInt32
stimo_sack :: UInt32
stimo_shutdown :: UInt32
stimo_heartbeat :: UInt32
stimo_cookie :: UInt32
stimo_shutdownack :: UInt32
end

struct SctpPrstatus
	sprstat_assoc_id :: SctpAssocT
sprstat_sid :: UInt16
sprstat_policy :: UInt16
sprstat_abandoned_unsent :: UInt64
sprstat_abandoned_sent :: UInt64
end

#  Standard TCP Congestion Control 
const SCTP_CC_RFC2581    = 0x00000000
#  High Speed TCP Congestion Control (Floyd) 
const SCTP_CC_HSTCP    = 0x00000001
#  HTCP Congestion Control 
const SCTP_CC_HTCP    = 0x00000002
#  RTCC Congestion Control - RFC2581 plus 
const SCTP_CC_RTCC    = 0x00000003

const SCTP_CC_OPT_RTCC_SETMODE    = 0x00002000
const SCTP_CC_OPT_USE_DCCC_EC    = 0x00002001
const SCTP_CC_OPT_STEADY_STEP    = 0x00002002

const SCTP_CMT_OFF    = 0
const SCTP_CMT_BASE    = 1
const SCTP_CMT_RPV1    = 2
const SCTP_CMT_RPV2    = 3
const SCTP_CMT_MPTCP    = 4
const SCTP_CMT_MAX    = SCTP_CMT_MPTCP

/* RS - Supported stream scheduling modules for pluggable
 * stream scheduling
 */
#  Default simple round-robin 
const SCTP_SS_DEFAULT    = 0x00000000
#  Real round-robin 
const SCTP_SS_ROUND_ROBIN    = 0x00000001
#  Real round-robin per packet 
const SCTP_SS_ROUND_ROBIN_PACKET    = 0x00000002
#  Priority 
const SCTP_SS_PRIORITY    = 0x00000003
#  Fair Bandwidth 
const SCTP_SS_FAIR_BANDWITH    = 0x00000004
#  First-come, first-serve 
const SCTP_SS_FIRST_COME    = 0x00000005

# ******************* System calls ************

struct socket;

void
usrsctp_init(uint16_t,
             int (*)(void *addr, void *buffer, size_t length, uint8_t tos, uint8_t set_df),
             void (*)(const char *format, ...));

void
usrsctp_init_nothreads(uint16_t,
		       int (*)(void *addr, void *buffer, size_t length, uint8_t tos, uint8_t set_df),
		       void (*)(const char *format, ...));

struct socket *
usrsctp_socket(int domain, int type, int protocol,
               int (*receive_cb)(struct socket *sock, union sctp_sockstore addr, void *data,
                                 size_t datalen, struct sctp_rcvinfo, int flags, void *ulp_info),
               int (*send_cb)(struct socket *sock, uint32_t sb_free, void *ulp_info),
               uint32_t sb_threshold,
               void *ulp_info);

int
usrsctp_setsockopt(struct socket *so,
                   int level,
                   int option_name,
                   const void *option_value,
                   socklen_t option_len);

int
usrsctp_getsockopt(struct socket *so,
                   int level,
                   int option_name,
                   void *option_value,
                   socklen_t *option_len);

int
usrsctp_opt_info(struct socket *so,
                 sctp_assoc_t id,
                 int opt,
                 void *arg,
                 socklen_t *size);

int
usrsctp_getpaddrs(struct socket *so,
                  sctp_assoc_t id,
                  struct sockaddr **raddrs);

void
usrsctp_freepaddrs(struct sockaddr *addrs);

int
usrsctp_getladdrs(struct socket *so,
                  sctp_assoc_t id,
                  struct sockaddr **raddrs);

void
usrsctp_freeladdrs(struct sockaddr *addrs);

ssize_t
usrsctp_sendv(struct socket *so,
              const void *data,
              size_t len,
              struct sockaddr *to,
              int addrcnt,
              void *info,
              socklen_t infolen,
              unsigned int infotype,
              int flags);

ssize_t
usrsctp_recvv(struct socket *so,
              void *dbuf,
              size_t len,
              struct sockaddr *from,
              socklen_t * fromlen,
              void *info,
              socklen_t *infolen,
              unsigned int *infotype,
              int *msg_flags);

int
usrsctp_bind(struct socket *so,
             struct sockaddr *name,
             socklen_t namelen);

const SCTP_BINDX_ADD_ADDR    = 0x00008001
const SCTP_BINDX_REM_ADDR    = 0x00008002

int
usrsctp_bindx(struct socket *so,
              struct sockaddr *addrs,
              int addrcnt,
              int flags);

int
usrsctp_listen(struct socket *so,
               int backlog);

struct socket *
usrsctp_accept(struct socket *so,
               struct sockaddr * aname,
               socklen_t * anamelen);

struct socket *
usrsctp_peeloff(struct socket *, sctp_assoc_t);

int
usrsctp_connect(struct socket *so,
                struct sockaddr *name,
                socklen_t namelen);

int
usrsctp_connectx(struct socket *so,
                 const struct sockaddr *addrs, int addrcnt,
                 sctp_assoc_t *id);

void
usrsctp_close(struct socket *so);

sctp_assoc_t
usrsctp_getassocid(struct socket *, struct sockaddr *);

int
usrsctp_finish(void);

int
usrsctp_shutdown(struct socket *so, int how);

void
usrsctp_conninput(void *, const void *, size_t, uint8_t);

int
usrsctp_set_non_blocking(struct socket *, int);

int
usrsctp_get_non_blocking(struct socket *);

void
usrsctp_register_address(void *);

void
usrsctp_deregister_address(void *);

int
usrsctp_set_ulpinfo(struct socket *, void *);

int
usrsctp_get_ulpinfo(struct socket *, void **);

int
usrsctp_set_upcall(struct socket *so,
                   void (*upcall)(struct socket *, void *, int),
                   void *arg);

int
usrsctp_get_events(struct socket *so);


void
usrsctp_handle_timers(elapsed_milliseconds) :: UInt32

const SCTP_DUMP_OUTBOUND    = 1
const SCTP_DUMP_INBOUND    = 0

char *
usrsctp_dumppacket(const void *, size_t, int);

void
usrsctp_freedumpbuffer(char *);

void
usrsctp_enable_crc32c_offload(void);

void
usrsctp_disable_crc32c_offload(void);

uint32_t
usrsctp_crc32c(void *, size_t);

const USRSCTP_TUNABLE_DECL    = (__field)               \
int usrsctp_tunable_set_ ## __field(value) :: UInt32\
usrsctp_sysctl_get_ ## __field(void) :: UInt32

USRSCTP_TUNABLE_DECL(sctp_hashtblsize)
USRSCTP_TUNABLE_DECL(sctp_pcbtblsize)
USRSCTP_TUNABLE_DECL(sctp_chunkscale)

const USRSCTP_SYSCTL_DECL    = (__field)               \
int usrsctp_sysctl_set_ ## __field(value) :: UInt32\
usrsctp_sysctl_get_ ## __field(void) :: UInt32

USRSCTP_SYSCTL_DECL(sctp_sendspace)
USRSCTP_SYSCTL_DECL(sctp_recvspace)
USRSCTP_SYSCTL_DECL(sctp_auto_asconf)
USRSCTP_SYSCTL_DECL(sctp_multiple_asconfs)
USRSCTP_SYSCTL_DECL(sctp_ecn_enable)
USRSCTP_SYSCTL_DECL(sctp_pr_enable)
USRSCTP_SYSCTL_DECL(sctp_auth_enable)
USRSCTP_SYSCTL_DECL(sctp_asconf_enable)
USRSCTP_SYSCTL_DECL(sctp_reconfig_enable)
USRSCTP_SYSCTL_DECL(sctp_nrsack_enable)
USRSCTP_SYSCTL_DECL(sctp_pktdrop_enable)
USRSCTP_SYSCTL_DECL(sctp_no_csum_on_loopback)
USRSCTP_SYSCTL_DECL(sctp_peer_chunk_oh)
USRSCTP_SYSCTL_DECL(sctp_max_burst_default)
USRSCTP_SYSCTL_DECL(sctp_max_chunks_on_queue)
USRSCTP_SYSCTL_DECL(sctp_min_split_point)
USRSCTP_SYSCTL_DECL(sctp_delayed_sack_time_default)
USRSCTP_SYSCTL_DECL(sctp_sack_freq_default)
USRSCTP_SYSCTL_DECL(sctp_system_free_resc_limit)
USRSCTP_SYSCTL_DECL(sctp_asoc_free_resc_limit)
USRSCTP_SYSCTL_DECL(sctp_heartbeat_interval_default)
USRSCTP_SYSCTL_DECL(sctp_pmtu_raise_time_default)
USRSCTP_SYSCTL_DECL(sctp_shutdown_guard_time_default)
USRSCTP_SYSCTL_DECL(sctp_secret_lifetime_default)
USRSCTP_SYSCTL_DECL(sctp_rto_max_default)
USRSCTP_SYSCTL_DECL(sctp_rto_min_default)
USRSCTP_SYSCTL_DECL(sctp_rto_initial_default)
USRSCTP_SYSCTL_DECL(sctp_init_rto_max_default)
USRSCTP_SYSCTL_DECL(sctp_valid_cookie_life_default)
USRSCTP_SYSCTL_DECL(sctp_init_rtx_max_default)
USRSCTP_SYSCTL_DECL(sctp_assoc_rtx_max_default)
USRSCTP_SYSCTL_DECL(sctp_path_rtx_max_default)
USRSCTP_SYSCTL_DECL(sctp_add_more_threshold)
USRSCTP_SYSCTL_DECL(sctp_nr_incoming_streams_default)
USRSCTP_SYSCTL_DECL(sctp_nr_outgoing_streams_default)
USRSCTP_SYSCTL_DECL(sctp_cmt_on_off)
USRSCTP_SYSCTL_DECL(sctp_cmt_use_dac)
USRSCTP_SYSCTL_DECL(sctp_use_cwnd_based_maxburst)
USRSCTP_SYSCTL_DECL(sctp_nat_friendly)
USRSCTP_SYSCTL_DECL(sctp_L2_abc_variable)
USRSCTP_SYSCTL_DECL(sctp_mbuf_threshold_count)
USRSCTP_SYSCTL_DECL(sctp_do_drain)
USRSCTP_SYSCTL_DECL(sctp_hb_maxburst)
USRSCTP_SYSCTL_DECL(sctp_abort_if_one_2_one_hits_limit)
USRSCTP_SYSCTL_DECL(sctp_min_residual)
USRSCTP_SYSCTL_DECL(sctp_max_retran_chunk)
USRSCTP_SYSCTL_DECL(sctp_logging_level)
USRSCTP_SYSCTL_DECL(sctp_default_cc_module)
USRSCTP_SYSCTL_DECL(sctp_default_frag_interleave)
USRSCTP_SYSCTL_DECL(sctp_mobility_base)
USRSCTP_SYSCTL_DECL(sctp_mobility_fasthandoff)
USRSCTP_SYSCTL_DECL(sctp_inits_include_nat_friendly)
USRSCTP_SYSCTL_DECL(sctp_udp_tunneling_port)
USRSCTP_SYSCTL_DECL(sctp_enable_sack_immediately)
USRSCTP_SYSCTL_DECL(sctp_vtag_time_wait)
USRSCTP_SYSCTL_DECL(sctp_blackhole)
USRSCTP_SYSCTL_DECL(sctp_sendall_limit)
USRSCTP_SYSCTL_DECL(sctp_diag_info_code)
USRSCTP_SYSCTL_DECL(sctp_fr_max_burst_default)
USRSCTP_SYSCTL_DECL(sctp_path_pf_threshold)
USRSCTP_SYSCTL_DECL(sctp_default_ss_module)
USRSCTP_SYSCTL_DECL(sctp_rttvar_bw)
USRSCTP_SYSCTL_DECL(sctp_rttvar_rtt)
USRSCTP_SYSCTL_DECL(sctp_rttvar_eqret)
USRSCTP_SYSCTL_DECL(sctp_steady_step)
USRSCTP_SYSCTL_DECL(sctp_use_dccc_ecn)
USRSCTP_SYSCTL_DECL(sctp_buffer_splitting)
USRSCTP_SYSCTL_DECL(sctp_initial_cwnd)
#ifdef SCTP_DEBUG
USRSCTP_SYSCTL_DECL(sctp_debug_on)
/* More specific values can be found in sctp_constants, but
 * are not considered to be part of the API.
 */
const SCTP_DEBUG_NONE    = 0x00000000
const SCTP_DEBUG_ALL    = 0xffffffff
#endif
#undef USRSCTP_SYSCTL_DECL
struct SctpTimeval
tv_sec :: UInt32
tv_usec :: UInt32
end

struct sctpstat
	struct sctp_timeval sctps_discontinuitytime; #  sctpStats 18 (TimeStamp) 
	#  MIB according to RFC 3873 
 sctps_currestab :: UInt32           #  sctpStats  1   (Gauge32) 
 sctps_activeestab :: UInt32         #  sctpStats  2 (Counter32) 
 sctps_restartestab :: UInt32
 sctps_collisionestab :: UInt32
 sctps_passiveestab :: UInt32        #  sctpStats  3 (Counter32) 
 sctps_aborted :: UInt32             #  sctpStats  4 (Counter32) 
 sctps_shutdown :: UInt32            #  sctpStats  5 (Counter32) 
 sctps_outoftheblue :: UInt32        #  sctpStats  6 (Counter32) 
 sctps_checksumerrors :: UInt32      #  sctpStats  7 (Counter32) 
 sctps_outcontrolchunks :: UInt32    #  sctpStats  8 (Counter64) 
 sctps_outorderchunks :: UInt32      #  sctpStats  9 (Counter64) 
 sctps_outunorderchunks :: UInt32    #  sctpStats 10 (Counter64) 
 sctps_incontrolchunks :: UInt32     #  sctpStats 11 (Counter64) 
 sctps_inorderchunks :: UInt32       #  sctpStats 12 (Counter64) 
 sctps_inunorderchunks :: UInt32     #  sctpStats 13 (Counter64) 
 sctps_fragusrmsgs :: UInt32         #  sctpStats 14 (Counter64) 
 sctps_reasmusrmsgs :: UInt32        #  sctpStats 15 (Counter64) 
 sctps_outpackets :: UInt32          #  sctpStats 16 (Counter64) 
 sctps_inpackets :: UInt32           #  sctpStats 17 (Counter64) 

	#  input statistics: 
 sctps_recvpackets :: UInt32         #  total input packets        
 sctps_recvdatagrams :: UInt32       #  total input datagrams      
 sctps_recvpktwithdata :: UInt32     #  total packets that had data 
 sctps_recvsacks :: UInt32           #  total input SACK chunks    
 sctps_recvdata :: UInt32            #  total input DATA chunks    
 sctps_recvdupdata :: UInt32         #  total input duplicate DATA chunks 
 sctps_recvheartbeat :: UInt32       #  total input HB chunks      
 sctps_recvheartbeatack :: UInt32    #  total input HB-ACK chunks  
 sctps_recvecne :: UInt32            #  total input ECNE chunks    
 sctps_recvauth :: UInt32            #  total input AUTH chunks    
 sctps_recvauthmissing :: UInt32     #  total input chunks missing AUTH 
 sctps_recvivalhmacid :: UInt32      #  total number of invalid HMAC ids received 
 sctps_recvivalkeyid :: UInt32       #  total number of invalid secret ids received 
 sctps_recvauthfailed :: UInt32      #  total number of auth failed 
 sctps_recvexpress :: UInt32         #  total fast path receives all one chunk 
 sctps_recvexpressm :: UInt32        #  total fast path multi-part data 
 sctps_recv_spare :: UInt32          #  formerly sctps_recvnocrc 
 sctps_recvswcrc :: UInt32
 sctps_recvhwcrc :: UInt32

	#  output statistics: 
 sctps_sendpackets :: UInt32         #  total output packets       
 sctps_sendsacks :: UInt32           #  total output SACKs         
 sctps_senddata :: UInt32            #  total output DATA chunks   
 sctps_sendretransdata :: UInt32     #  total output retransmitted DATA chunks 
 sctps_sendfastretrans :: UInt32     #  total output fast retransmitted DATA chunks 
 sctps_sendmultfastretrans :: UInt32 /* total FR's that happened more than once
	                                      * to same chunk (u-del multi-fr algo).
	                                      */
 sctps_sendheartbeat :: UInt32       #  total output HB chunks     
 sctps_sendecne :: UInt32            #  total output ECNE chunks    
 sctps_sendauth :: UInt32            #  total output AUTH chunks FIXME   
 sctps_senderrors :: UInt32          #  ip_output error counter 
 sctps_send_spare :: UInt32          #  formerly sctps_sendnocrc 
 sctps_sendswcrc :: UInt32
 sctps_sendhwcrc :: UInt32
	#  PCKDROPREP statistics: 
 sctps_pdrpfmbox :: UInt32           #  Packet drop from middle box 
 sctps_pdrpfehos :: UInt32           #  P-drop from end host 
 sctps_pdrpmbda :: UInt32            #  P-drops with data 
 sctps_pdrpmbct :: UInt32            #  P-drops, non-data, non-endhost 
 sctps_pdrpbwrpt :: UInt32           #  P-drop, non-endhost, bandwidth rep only 
 sctps_pdrpcrupt :: UInt32           #  P-drop, not enough for chunk header 
 sctps_pdrpnedat :: UInt32           #  P-drop, not enough data to confirm 
 sctps_pdrppdbrk :: UInt32           #  P-drop, where process_chunk_drop said break 
 sctps_pdrptsnnf :: UInt32           #  P-drop, could not find TSN 
 sctps_pdrpdnfnd :: UInt32           #  P-drop, attempt reverse TSN lookup 
 sctps_pdrpdiwnp :: UInt32           #  P-drop, e-host confirms zero-rwnd 
 sctps_pdrpdizrw :: UInt32           #  P-drop, midbox confirms no space 
 sctps_pdrpbadd :: UInt32            #  P-drop, data did not match TSN 
 sctps_pdrpmark :: UInt32            #  P-drop, TSN's marked for Fast Retran 
	#  timeouts 
 sctps_timoiterator :: UInt32        #  Number of iterator timers that fired 
 sctps_timodata :: UInt32            #  Number of T3 data time outs 
 sctps_timowindowprobe :: UInt32     #  Number of window probe (T3) timers that fired 
 sctps_timoinit :: UInt32            #  Number of INIT timers that fired 
 sctps_timosack :: UInt32            #  Number of sack timers that fired 
 sctps_timoshutdown :: UInt32        #  Number of shutdown timers that fired 
 sctps_timoheartbeat :: UInt32       #  Number of heartbeat timers that fired 
 sctps_timocookie :: UInt32          #  Number of times a cookie timeout fired 
 sctps_timosecret :: UInt32          #  Number of times an endpoint changed its cookie secret
 sctps_timopathmtu :: UInt32         #  Number of PMTU timers that fired 
 sctps_timoshutdownack :: UInt32     #  Number of shutdown ack timers that fired 
 sctps_timoshutdownguard :: UInt32   #  Number of shutdown guard timers that fired 
 sctps_timostrmrst :: UInt32         #  Number of stream reset timers that fired 
 sctps_timoearlyfr :: UInt32         #  Number of early FR timers that fired 
 sctps_timoasconf :: UInt32          #  Number of times an asconf timer fired 
 sctps_timodelprim :: UInt32	     #  Number of times a prim_deleted timer fired 
 sctps_timoautoclose :: UInt32       #  Number of times auto close timer fired 
 sctps_timoassockill :: UInt32       #  Number of asoc free timers expired 
 sctps_timoinpkill :: UInt32         #  Number of inp free timers expired 
	#  former early FR counters 
 sctps_spare[11] :: UInt32
	#  others 
 sctps_hdrops :: UInt32              #  packet shorter than header 
 sctps_badsum :: UInt32              #  checksum error             
 sctps_noport :: UInt32              #  no endpoint for port       
 sctps_badvtag :: UInt32             #  bad v-tag                  
 sctps_badsid :: UInt32              #  bad SID                    
 sctps_nomem :: UInt32               #  no memory                  
 sctps_fastretransinrtt :: UInt32    #  number of multiple FR in a RTT window 
 sctps_markedretrans :: UInt32
 sctps_naglesent :: UInt32           #  nagle allowed sending      
 sctps_naglequeued :: UInt32         #  nagle doesn't allow sending 
 sctps_maxburstqueued :: UInt32      #  max burst doesn't allow sending 
 sctps_ifnomemqueued :: UInt32       /* look ahead tells us no memory in
	                                      * interface ring buffer OR we had a
	                                      * send error and are queuing one send.
	                                      */
 sctps_windowprobed :: UInt32        #  total number of window probes sent 
 sctps_lowlevelerr :: UInt32         /* total times an output error causes us
	                                      * to clamp down on next user send.
	                                      */
 sctps_lowlevelerrusr :: UInt32      /* total times sctp_senderrors were caused from
	                                      * a user send from a user invoked send not
	                                      * a sack response
	                                      */
 sctps_datadropchklmt :: UInt32      #  Number of in data drops due to chunk limit reached 
 sctps_datadroprwnd :: UInt32        #  Number of in data drops due to rwnd limit reached 
 sctps_ecnereducedcwnd :: UInt32     #  Number of times a ECN reduced the cwnd 
 sctps_vtagexpress :: UInt32         #  Used express lookup via vtag 
 sctps_vtagbogus :: UInt32           #  Collision in express lookup. 
 sctps_primary_randry :: UInt32      #  Number of times the sender ran dry of user data on primary 
 sctps_cmt_randry :: UInt32          #  Same for above 
 sctps_slowpath_sack :: UInt32       #  Sacks the slow way 
 sctps_wu_sacks_sent :: UInt32       #  Window Update only sacks sent 
 sctps_sends_with_flags :: UInt32    #  number of sends with sinfo_flags !=0 
 sctps_sends_with_unord :: UInt32    #  number of unordered sends 
 sctps_sends_with_eof :: UInt32      #  number of sends with EOF flag set 
 sctps_sends_with_abort :: UInt32    #  number of sends with ABORT flag set 
 sctps_protocol_drain_calls :: UInt32#  number of times protocol drain called 
 sctps_protocol_drains_done :: UInt32#  number of times we did a protocol drain 
 sctps_read_peeks :: UInt32          #  Number of times recv was called with peek 
 sctps_cached_chk :: UInt32          #  Number of cached chunks used 
 sctps_cached_strmoq :: UInt32       #  Number of cached stream oq's used 
 sctps_left_abandon :: UInt32        #  Number of unread messages abandoned by close 
 sctps_send_burst_avoid :: UInt32    #  Unused 
 sctps_send_cwnd_avoid :: UInt32     #  Send cwnd full  avoidance, already max burst inflight to net 
 sctps_fwdtsn_map_over :: UInt32     #  number of map array over-runs via fwd-tsn's 
 sctps_queue_upd_ecne :: UInt32      #  Number of times we queued or updated an ECN chunk on send queue 
 sctps_reserved[31] :: UInt32        #  Future ABI compat - remove int's from here when adding new 
end

void
usrsctp_get_stat(struct sctpstat *);

#ifdef _WIN32
#ifdef _MSC_VER
#pragma warning(default: 4200)
#endif
#endif
#ifdef  __cplusplus
}
#endif
#endif


#=
################### TODO 
union sctp_sockstore {
  sin :: SockaddrIn
  sin6 :: SockaddrIn6
  sconn :: SockaddrConn
	sa :: sockaddr
end
=#
