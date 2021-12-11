# https://github.com/JuliaLang/julia/blob/master/stdlib/Sockets/src/Sockets.jl
# https://datatracker.ietf.org/doc/html/rfc6458
module UsrSctp

using Usrsctp_jll
export Usrsctp_jll

using CEnum
const usrsctplib = Usrsctp_jll.libusrsctp

const __socklen_t = Cuint

const socklen_t = __socklen_t

const sa_family_t = Cushort

# struct sockaddr
#     sa_family::sa_family_t
#     sa_data::NTuple{14, Cchar}
# end
# abstract type sockaddr end

struct sockaddr_storage
    ss_family::sa_family_t
    __ss_align::Culong
    __ss_padding::NTuple{112, Cchar}
end

const in_port_t = UInt16

const in_addr_t = UInt32

struct in_addr
    s_addr::in_addr_t
end

struct var"##Ctag#291"
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#291"}, f::Symbol)
    f === :__u6_addr8 && return Ptr{NTuple{16, UInt8}}(x + 0)
    f === :__u6_addr16 && return Ptr{NTuple{8, UInt16}}(x + 0)
    f === :__u6_addr32 && return Ptr{NTuple{4, UInt32}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#291", f::Symbol)
    r = Ref{var"##Ctag#291"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#291"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#291"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct in6_addr
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{in6_addr}, f::Symbol)
    f === :__in6_u && return Ptr{var"##Ctag#291"}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::in6_addr, f::Symbol)
    r = Ref{in6_addr}(x)
    ptr = Base.unsafe_convert(Ptr{in6_addr}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{in6_addr}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct sockaddr_in
    sin_family::sa_family_t
    sin_port::in_port_t
    sin_addr::in_addr
    sin_zero::NTuple{8, Cuchar}
end

struct sockaddr_in6
    sin6_family::sa_family_t
    sin6_port::in_port_t
    sin6_flowinfo::UInt32
    sin6_addr::in6_addr
    sin6_scope_id::UInt32
end

# 
# const sockaddr = Union{sockaddr_in, sockaddr_in6}
sockaddr = sockaddr_in
const sctp_assoc_t = UInt32

struct sctp_common_header
    data::NTuple{12, UInt8}
end

function Base.getproperty(x::Ptr{sctp_common_header}, f::Symbol)
    f === :source_port && return Ptr{UInt16}(x + 0)
    f === :destination_port && return Ptr{UInt16}(x + 2)
    f === :verification_tag && return Ptr{UInt32}(x + 4)
    f === :crc32c && return Ptr{UInt32}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::sctp_common_header, f::Symbol)
    r = Ref{sctp_common_header}(x)
    ptr = Base.unsafe_convert(Ptr{sctp_common_header}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{sctp_common_header}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct sockaddr_conn
    sconn_family::UInt16
    sconn_port::UInt16
    sconn_addr::Ptr{Cvoid}
end

struct sctp_sockstore
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{sctp_sockstore}, f::Symbol)
    f === :sin && return Ptr{sockaddr_in}(x + 0)
    f === :sin6 && return Ptr{sockaddr_in6}(x + 0)
    f === :sconn && return Ptr{sockaddr_conn}(x + 0)
    f === :sa && return Ptr{sockaddr}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::sctp_sockstore, f::Symbol)
    r = Ref{sctp_sockstore}(x)
    ptr = Base.unsafe_convert(Ptr{sctp_sockstore}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{sctp_sockstore}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct sctp_rcvinfo
    rcv_sid::UInt16
    rcv_ssn::UInt16
    rcv_flags::UInt16
    rcv_ppid::UInt32
    rcv_tsn::UInt32
    rcv_cumtsn::UInt32
    rcv_context::UInt32
    rcv_assoc_id::sctp_assoc_t
end

struct sctp_nxtinfo
    nxt_sid::UInt16
    nxt_flags::UInt16
    nxt_ppid::UInt32
    nxt_length::UInt32
    nxt_assoc_id::sctp_assoc_t
end

struct sctp_recvv_rn
    recvv_rcvinfo::sctp_rcvinfo
    recvv_nxtinfo::sctp_nxtinfo
end

struct sctp_snd_all_completes
    sall_stream::UInt16
    sall_flags::UInt16
    sall_ppid::UInt32
    sall_context::UInt32
    sall_num_sent::UInt32
    sall_num_failed::UInt32
end

struct sctp_sndinfo
    snd_sid::UInt16
    snd_flags::UInt16
    snd_ppid::UInt32
    snd_context::UInt32
    snd_assoc_id::sctp_assoc_t
end

struct sctp_prinfo
    pr_policy::UInt16
    pr_value::UInt32
end

struct sctp_authinfo
    auth_keynumber::UInt16
end

struct sctp_sendv_spa
    sendv_flags::UInt32
    sendv_sndinfo::sctp_sndinfo
    sendv_prinfo::sctp_prinfo
    sendv_authinfo::sctp_authinfo
end

struct sctp_udpencaps
    sue_address::sockaddr_storage
    sue_assoc_id::UInt32
    sue_port::UInt16
end

struct sctp_assoc_change
    sac_type::UInt16
    sac_flags::UInt16
    sac_length::UInt32
    sac_state::UInt16
    sac_error::UInt16
    sac_outbound_streams::UInt16
    sac_inbound_streams::UInt16
    sac_assoc_id::sctp_assoc_t
    sac_info::Ptr{UInt8}
end

struct sctp_paddr_change
    spc_type::UInt16
    spc_flags::UInt16
    spc_length::UInt32
    spc_aaddr::sockaddr_storage
    spc_state::UInt32
    spc_error::UInt32
    spc_assoc_id::sctp_assoc_t
    spc_padding::NTuple{4, UInt8}
end

struct sctp_remote_error
    sre_type::UInt16
    sre_flags::UInt16
    sre_length::UInt32
    sre_error::UInt16
    sre_assoc_id::sctp_assoc_t
    sre_data::Ptr{UInt8}
end

struct sctp_shutdown_event
    sse_type::UInt16
    sse_flags::UInt16
    sse_length::UInt32
    sse_assoc_id::sctp_assoc_t
end

struct sctp_adaptation_event
    sai_type::UInt16
    sai_flags::UInt16
    sai_length::UInt32
    sai_adaptation_ind::UInt32
    sai_assoc_id::sctp_assoc_t
end

struct sctp_pdapi_event
    pdapi_type::UInt16
    pdapi_flags::UInt16
    pdapi_length::UInt32
    pdapi_indication::UInt32
    pdapi_stream::UInt32
    pdapi_seq::UInt32
    pdapi_assoc_id::sctp_assoc_t
end

struct sctp_authkey_event
    auth_type::UInt16
    auth_flags::UInt16
    auth_length::UInt32
    auth_keynumber::UInt16
    auth_indication::UInt32
    auth_assoc_id::sctp_assoc_t
end

struct sctp_sender_dry_event
    sender_dry_type::UInt16
    sender_dry_flags::UInt16
    sender_dry_length::UInt32
    sender_dry_assoc_id::sctp_assoc_t
end

struct sctp_stream_reset_event
    strreset_type::UInt16
    strreset_flags::UInt16
    strreset_length::UInt32
    strreset_assoc_id::sctp_assoc_t
    strreset_stream_list::Ptr{UInt16}
end

struct sctp_assoc_reset_event
    assocreset_type::UInt16
    assocreset_flags::UInt16
    assocreset_length::UInt32
    assocreset_assoc_id::sctp_assoc_t
    assocreset_local_tsn::UInt32
    assocreset_remote_tsn::UInt32
end

struct sctp_stream_change_event
    strchange_type::UInt16
    strchange_flags::UInt16
    strchange_length::UInt32
    strchange_assoc_id::sctp_assoc_t
    strchange_instrms::UInt16
    strchange_outstrms::UInt16
end

struct sctp_send_failed_event
    ssfe_type::UInt16
    ssfe_flags::UInt16
    ssfe_length::UInt32
    ssfe_error::UInt32
    ssfe_info::sctp_sndinfo
    ssfe_assoc_id::sctp_assoc_t
    ssfe_data::Ptr{UInt8}
end

struct sctp_event
    se_assoc_id::sctp_assoc_t
    se_type::UInt16
    se_on::UInt8
end

struct sctp_notification
    data::NTuple{152, UInt8}
end

function Base.getproperty(x::Ptr{sctp_notification}, f::Symbol)
    f === :sn_header && return Ptr{sctp_tlv}(x + 0)
    f === :sn_assoc_change && return Ptr{sctp_assoc_change}(x + 0)
    f === :sn_paddr_change && return Ptr{sctp_paddr_change}(x + 0)
    f === :sn_remote_error && return Ptr{sctp_remote_error}(x + 0)
    f === :sn_shutdown_event && return Ptr{sctp_shutdown_event}(x + 0)
    f === :sn_adaptation_event && return Ptr{sctp_adaptation_event}(x + 0)
    f === :sn_pdapi_event && return Ptr{sctp_pdapi_event}(x + 0)
    f === :sn_auth_event && return Ptr{sctp_authkey_event}(x + 0)
    f === :sn_sender_dry_event && return Ptr{sctp_sender_dry_event}(x + 0)
    f === :sn_send_failed_event && return Ptr{sctp_send_failed_event}(x + 0)
    f === :sn_strreset_event && return Ptr{sctp_stream_reset_event}(x + 0)
    f === :sn_assocreset_event && return Ptr{sctp_assoc_reset_event}(x + 0)
    f === :sn_strchange_event && return Ptr{sctp_stream_change_event}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::sctp_notification, f::Symbol)
    r = Ref{sctp_notification}(x)
    ptr = Base.unsafe_convert(Ptr{sctp_notification}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{sctp_notification}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct sctp_event_subscribe
    sctp_data_io_event::UInt8
    sctp_association_event::UInt8
    sctp_address_event::UInt8
    sctp_send_failure_event::UInt8
    sctp_peer_error_event::UInt8
    sctp_shutdown_event::UInt8
    sctp_partial_delivery_event::UInt8
    sctp_adaptation_layer_event::UInt8
    sctp_authentication_event::UInt8
    sctp_sender_dry_event::UInt8
    sctp_stream_reset_event::UInt8
end

struct sctp_initmsg
    sinit_num_ostreams::UInt16
    sinit_max_instreams::UInt16
    sinit_max_attempts::UInt16
    sinit_max_init_timeo::UInt16
end

struct sctp_rtoinfo
    srto_assoc_id::sctp_assoc_t
    srto_initial::UInt32
    srto_max::UInt32
    srto_min::UInt32
end

struct sctp_assocparams
    sasoc_assoc_id::sctp_assoc_t
    sasoc_peer_rwnd::UInt32
    sasoc_local_rwnd::UInt32
    sasoc_cookie_life::UInt32
    sasoc_asocmaxrxt::UInt16
    sasoc_number_peer_destinations::UInt16
end

struct sctp_setprim
    ssp_addr::sockaddr_storage
    ssp_assoc_id::sctp_assoc_t
    ssp_padding::NTuple{4, UInt8}
end

struct sctp_setadaptation
    ssb_adaptation_ind::UInt32
end

struct sctp_paddrparams
    spp_address::sockaddr_storage
    spp_assoc_id::sctp_assoc_t
    spp_hbinterval::UInt32
    spp_pathmtu::UInt32
    spp_flags::UInt32
    spp_ipv6_flowlabel::UInt32
    spp_pathmaxrxt::UInt16
    spp_dscp::UInt8
end

struct sctp_assoc_value
    assoc_id::sctp_assoc_t
    assoc_value::UInt32
end

struct sctp_reset_streams
    srs_assoc_id::sctp_assoc_t
    srs_flags::UInt16
    srs_number_streams::UInt16
    srs_stream_list::Ptr{UInt16}
end

struct sctp_add_streams
    sas_assoc_id::sctp_assoc_t
    sas_instrms::UInt16
    sas_outstrms::UInt16
end

struct sctp_hmacalgo
    shmac_number_of_idents::UInt32
    shmac_idents::Ptr{UInt16}
end

struct sctp_sack_info
    sack_assoc_id::sctp_assoc_t
    sack_delay::UInt32
    sack_freq::UInt32
end

struct sctp_default_prinfo
    pr_policy::UInt16
    pr_value::UInt32
    pr_assoc_id::sctp_assoc_t
end

struct sctp_paddrinfo
    spinfo_address::sockaddr_storage
    spinfo_assoc_id::sctp_assoc_t
    spinfo_state::Int32
    spinfo_cwnd::UInt32
    spinfo_srtt::UInt32
    spinfo_rto::UInt32
    spinfo_mtu::UInt32
end

struct sctp_status
    sstat_assoc_id::sctp_assoc_t
    sstat_state::Int32
    sstat_rwnd::UInt32
    sstat_unackdata::UInt16
    sstat_penddata::UInt16
    sstat_instrms::UInt16
    sstat_outstrms::UInt16
    sstat_fragmentation_point::UInt32
    sstat_primary::sctp_paddrinfo
end

struct sctp_authchunks
    gauth_assoc_id::sctp_assoc_t
    gauth_chunks::Ptr{UInt8}
end

struct sctp_assoc_ids
    gaids_number_of_ids::UInt32
    gaids_assoc_id::Ptr{sctp_assoc_t}
end

struct sctp_setpeerprim
    sspp_addr::sockaddr_storage
    sspp_assoc_id::sctp_assoc_t
    sspp_padding::NTuple{4, UInt8}
end

struct sctp_authchunk
    sauth_chunk::UInt8
end

struct sctp_get_nonce_values
    gn_assoc_id::sctp_assoc_t
    gn_peers_tag::UInt32
    gn_local_tag::UInt32
end

struct sctp_authkey
    sca_assoc_id::sctp_assoc_t
    sca_keynumber::UInt16
    sca_keylength::UInt16
    sca_key::Ptr{UInt8}
end

struct sctp_authkeyid
    scact_assoc_id::sctp_assoc_t
    scact_keynumber::UInt16
end

struct sctp_cc_option
    option::Cint
    aid_value::sctp_assoc_value
end

struct sctp_stream_value
    assoc_id::sctp_assoc_t
    stream_id::UInt16
    stream_value::UInt16
end

struct sctp_timeouts
    stimo_assoc_id::sctp_assoc_t
    stimo_init::UInt32
    stimo_data::UInt32
    stimo_sack::UInt32
    stimo_shutdown::UInt32
    stimo_heartbeat::UInt32
    stimo_cookie::UInt32
    stimo_shutdownack::UInt32
end

struct sctp_prstatus
    sprstat_assoc_id::sctp_assoc_t
    sprstat_sid::UInt16
    sprstat_policy::UInt16
    sprstat_abandoned_unsent::UInt64
    sprstat_abandoned_sent::UInt64
end

mutable struct Socket end

function usrsctp_init(port, arg2, arg3)
    ccall((:usrsctp_init, usrsctplib), Cvoid, (UInt16, Ptr{Cvoid}, Ptr{Cvoid}), port, arg2, arg3)
end

function usrsctp_init_nothreads(arg1, arg2, arg3)
    ccall((:usrsctp_init_nothreads, usrsctplib), Cvoid, (UInt16, Ptr{Cvoid}, Ptr{Cvoid}), arg1, arg2, arg3)
end

function usrsctp_socket(domain, type, protocol, receive_cb, send_cb, sb_threshold, ulp_info)
    ccall((:usrsctp_socket, usrsctplib), Ptr{Socket}, (Cint, Cint, Cint, Ptr{Cvoid}, Ptr{Cvoid}, UInt32, Ptr{Cvoid}), domain, type, protocol, receive_cb, send_cb, sb_threshold, ulp_info)
end

function usrsctp_setsockopt(so, level, option_name, option_value, option_len)
    ccall((:usrsctp_setsockopt, usrsctplib), Cint, (Ptr{Socket}, Cint, Cint, Ptr{Cvoid}, socklen_t), so, level, option_name, option_value, option_len)
end

function usrsctp_getsockopt(so, level, option_name, option_value, option_len)
    ccall((:usrsctp_getsockopt, usrsctplib), Cint, (Ptr{Socket}, Cint, Cint, Ptr{Cvoid}, Ptr{socklen_t}), so, level, option_name, option_value, option_len)
end

function usrsctp_opt_info(so, id, opt, arg, size)
    ccall((:usrsctp_opt_info, usrsctplib), Cint, (Ptr{Socket}, sctp_assoc_t, Cint, Ptr{Cvoid}, Ptr{socklen_t}), so, id, opt, arg, size)
end

function usrsctp_getpaddrs(so, id, raddrs)
    ccall((:usrsctp_getpaddrs, usrsctplib), Cint, (Ptr{Socket}, sctp_assoc_t, Ptr{Ptr{sockaddr}}), so, id, raddrs)
end

function usrsctp_freepaddrs(addrs)
    ccall((:usrsctp_freepaddrs, usrsctplib), Cvoid, (Ptr{sockaddr},), addrs)
end

function usrsctp_getladdrs(so, id, raddrs)
    ccall((:usrsctp_getladdrs, usrsctplib), Cint, (Ptr{Socket}, sctp_assoc_t, Ptr{Ptr{sockaddr}}), so, id, raddrs)
end

function usrsctp_freeladdrs(addrs)
    ccall((:usrsctp_freeladdrs, usrsctplib), Cvoid, (Ptr{sockaddr},), addrs)
end

function usrsctp_sendv(so, data, len, to, addrcnt, info, infolen, infotype, flags)
    ccall((:usrsctp_sendv, usrsctplib), Cssize_t, (Ptr{Socket}, Ptr{Cvoid}, Csize_t, Ptr{sockaddr}, Cint, Ptr{Cvoid}, socklen_t, Cuint, Cint), so, data, len, to, addrcnt, info, infolen, infotype, flags)
end

function usrsctp_recvv(so, dbuf, len, from, fromlen, info, infolen, infotype, msg_flags)
    ccall((:usrsctp_recvv, usrsctplib), Cssize_t, (Ptr{Socket}, Ptr{Cvoid}, Csize_t, Ptr{sockaddr}, Ptr{socklen_t}, Ptr{Cvoid}, Ptr{socklen_t}, Ptr{Cuint}, Ptr{Cint}), so, dbuf, len, from, fromlen, info, infolen, infotype, msg_flags)
end

function usrsctp_bind(so, name, namelen)
    ccall((:usrsctp_bind, usrsctplib), Cint, (Ptr{Socket}, Ptr{sockaddr}, socklen_t), so, name, namelen)
end

function usrsctp_bindx(so, addrs, addrcnt, flags)
    ccall((:usrsctp_bindx, usrsctplib), Cint, (Ptr{Socket}, Ptr{sockaddr}, Cint, Cint), so, addrs, addrcnt, flags)
end

function usrsctp_listen(so, backlog)
    ccall((:usrsctp_listen, usrsctplib), Cint, (Ptr{Socket}, Cint), so, backlog)
end

function usrsctp_accept(so, aname, anamelen)
    ccall((:usrsctp_accept, usrsctplib), Ptr{Socket}, (Ptr{Socket}, Ptr{sockaddr}, Ptr{socklen_t}), so, aname, anamelen)
end

function usrsctp_peeloff(arg1, arg2)
    ccall((:usrsctp_peeloff, usrsctplib), Ptr{Socket}, (Ptr{Socket}, sctp_assoc_t), arg1, arg2)
end

function usrsctp_connect(so, name, namelen)
    ccall((:usrsctp_connect, usrsctplib), Cint, (Ptr{Socket}, Ptr{sockaddr}, socklen_t), so, name, namelen)
end

function usrsctp_connectx(so, addrs, addrcnt, id)
    ccall((:usrsctp_connectx, usrsctplib), Cint, (Ptr{Socket}, Ptr{sockaddr}, Cint, Ptr{sctp_assoc_t}), so, addrs, addrcnt, id)
end

function usrsctp_close(so)
    ccall((:usrsctp_close, usrsctplib), Cvoid, (Ptr{Socket},), so)
end

function usrsctp_getassocid(arg1, arg2)
    ccall((:usrsctp_getassocid, usrsctplib), sctp_assoc_t, (Ptr{Socket}, Ptr{sockaddr}), arg1, arg2)
end

function usrsctp_finish()
    ccall((:usrsctp_finish, usrsctplib), Cint, ())
end

function usrsctp_shutdown(so, how)
    ccall((:usrsctp_shutdown, usrsctplib), Cint, (Ptr{Socket}, Cint), so, how)
end

function usrsctp_conninput(arg1, arg2, arg3, arg4)
    ccall((:usrsctp_conninput, usrsctplib), Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, UInt8), arg1, arg2, arg3, arg4)
end

function usrsctp_set_non_blocking(arg1, arg2)
    ccall((:usrsctp_set_non_blocking, usrsctplib), Cint, (Ptr{Socket}, Cint), arg1, arg2)
end

function usrsctp_get_non_blocking(arg1)
    ccall((:usrsctp_get_non_blocking, usrsctplib), Cint, (Ptr{Socket},), arg1)
end

function usrsctp_register_address(arg1)
    ccall((:usrsctp_register_address, usrsctplib), Cvoid, (Ptr{Cvoid},), arg1)
end

function usrsctp_deregister_address(arg1)
    ccall((:usrsctp_deregister_address, usrsctplib), Cvoid, (Ptr{Cvoid},), arg1)
end

function usrsctp_set_ulpinfo(arg1, arg2)
    ccall((:usrsctp_set_ulpinfo, usrsctplib), Cint, (Ptr{Socket}, Ptr{Cvoid}), arg1, arg2)
end

function usrsctp_get_ulpinfo(arg1, arg2)
    ccall((:usrsctp_get_ulpinfo, usrsctplib), Cint, (Ptr{Socket}, Ptr{Ptr{Cvoid}}), arg1, arg2)
end

function usrsctp_set_upcall(so, upcall, arg)
    ccall((:usrsctp_set_upcall, usrsctplib), Cint, (Ptr{Socket}, Ptr{Cvoid}, Ptr{Cvoid}), so, upcall, arg)
end

function usrsctp_get_events(so)
    ccall((:usrsctp_get_events, usrsctplib), Cint, (Ptr{Socket},), so)
end

function usrsctp_handle_timers(elapsed_milliseconds)
    ccall((:usrsctp_handle_timers, usrsctplib), Cvoid, (UInt32,), elapsed_milliseconds)
end

function usrsctp_dumppacket(arg1, arg2, arg3)
    ccall((:usrsctp_dumppacket, usrsctplib), Ptr{Cchar}, (Ptr{Cvoid}, Csize_t, Cint), arg1, arg2, arg3)
end

function usrsctp_freedumpbuffer(arg1)
    ccall((:usrsctp_freedumpbuffer, usrsctplib), Cvoid, (Ptr{Cchar},), arg1)
end

function usrsctp_enable_crc32c_offload()
    ccall((:usrsctp_enable_crc32c_offload, usrsctplib), Cvoid, ())
end

function usrsctp_disable_crc32c_offload()
    ccall((:usrsctp_disable_crc32c_offload, usrsctplib), Cvoid, ())
end

function usrsctp_crc32c(arg1, arg2)
    ccall((:usrsctp_crc32c, usrsctplib), UInt32, (Ptr{Cvoid}, Csize_t), arg1, arg2)
end

function usrsctp_tunable_set_sctp_hashtblsize(value)
    ccall((:usrsctp_tunable_set_sctp_hashtblsize, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_hashtblsize()
    ccall((:usrsctp_sysctl_get_sctp_hashtblsize, usrsctplib), UInt32, ())
end

function usrsctp_tunable_set_sctp_pcbtblsize(value)
    ccall((:usrsctp_tunable_set_sctp_pcbtblsize, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_pcbtblsize()
    ccall((:usrsctp_sysctl_get_sctp_pcbtblsize, usrsctplib), UInt32, ())
end

function usrsctp_tunable_set_sctp_chunkscale(value)
    ccall((:usrsctp_tunable_set_sctp_chunkscale, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_chunkscale()
    ccall((:usrsctp_sysctl_get_sctp_chunkscale, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_sendspace(value)
    ccall((:usrsctp_sysctl_set_sctp_sendspace, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_sendspace()
    ccall((:usrsctp_sysctl_get_sctp_sendspace, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_recvspace(value)
    ccall((:usrsctp_sysctl_set_sctp_recvspace, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_recvspace()
    ccall((:usrsctp_sysctl_get_sctp_recvspace, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_auto_asconf(value)
    ccall((:usrsctp_sysctl_set_sctp_auto_asconf, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_auto_asconf()
    ccall((:usrsctp_sysctl_get_sctp_auto_asconf, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_multiple_asconfs(value)
    ccall((:usrsctp_sysctl_set_sctp_multiple_asconfs, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_multiple_asconfs()
    ccall((:usrsctp_sysctl_get_sctp_multiple_asconfs, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_ecn_enable(value)
    ccall((:usrsctp_sysctl_set_sctp_ecn_enable, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_ecn_enable()
    ccall((:usrsctp_sysctl_get_sctp_ecn_enable, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_pr_enable(value)
    ccall((:usrsctp_sysctl_set_sctp_pr_enable, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_pr_enable()
    ccall((:usrsctp_sysctl_get_sctp_pr_enable, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_auth_enable(value)
    ccall((:usrsctp_sysctl_set_sctp_auth_enable, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_auth_enable()
    ccall((:usrsctp_sysctl_get_sctp_auth_enable, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_asconf_enable(value)
    ccall((:usrsctp_sysctl_set_sctp_asconf_enable, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_asconf_enable()
    ccall((:usrsctp_sysctl_get_sctp_asconf_enable, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_reconfig_enable(value)
    ccall((:usrsctp_sysctl_set_sctp_reconfig_enable, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_reconfig_enable()
    ccall((:usrsctp_sysctl_get_sctp_reconfig_enable, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_nrsack_enable(value)
    ccall((:usrsctp_sysctl_set_sctp_nrsack_enable, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_nrsack_enable()
    ccall((:usrsctp_sysctl_get_sctp_nrsack_enable, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_pktdrop_enable(value)
    ccall((:usrsctp_sysctl_set_sctp_pktdrop_enable, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_pktdrop_enable()
    ccall((:usrsctp_sysctl_get_sctp_pktdrop_enable, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_no_csum_on_loopback(value)
    ccall((:usrsctp_sysctl_set_sctp_no_csum_on_loopback, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_no_csum_on_loopback()
    ccall((:usrsctp_sysctl_get_sctp_no_csum_on_loopback, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_peer_chunk_oh(value)
    ccall((:usrsctp_sysctl_set_sctp_peer_chunk_oh, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_peer_chunk_oh()
    ccall((:usrsctp_sysctl_get_sctp_peer_chunk_oh, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_max_burst_default(value)
    ccall((:usrsctp_sysctl_set_sctp_max_burst_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_max_burst_default()
    ccall((:usrsctp_sysctl_get_sctp_max_burst_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_max_chunks_on_queue(value)
    ccall((:usrsctp_sysctl_set_sctp_max_chunks_on_queue, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_max_chunks_on_queue()
    ccall((:usrsctp_sysctl_get_sctp_max_chunks_on_queue, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_min_split_point(value)
    ccall((:usrsctp_sysctl_set_sctp_min_split_point, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_min_split_point()
    ccall((:usrsctp_sysctl_get_sctp_min_split_point, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_delayed_sack_time_default(value)
    ccall((:usrsctp_sysctl_set_sctp_delayed_sack_time_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_delayed_sack_time_default()
    ccall((:usrsctp_sysctl_get_sctp_delayed_sack_time_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_sack_freq_default(value)
    ccall((:usrsctp_sysctl_set_sctp_sack_freq_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_sack_freq_default()
    ccall((:usrsctp_sysctl_get_sctp_sack_freq_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_system_free_resc_limit(value)
    ccall((:usrsctp_sysctl_set_sctp_system_free_resc_limit, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_system_free_resc_limit()
    ccall((:usrsctp_sysctl_get_sctp_system_free_resc_limit, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_asoc_free_resc_limit(value)
    ccall((:usrsctp_sysctl_set_sctp_asoc_free_resc_limit, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_asoc_free_resc_limit()
    ccall((:usrsctp_sysctl_get_sctp_asoc_free_resc_limit, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_heartbeat_interval_default(value)
    ccall((:usrsctp_sysctl_set_sctp_heartbeat_interval_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_heartbeat_interval_default()
    ccall((:usrsctp_sysctl_get_sctp_heartbeat_interval_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_pmtu_raise_time_default(value)
    ccall((:usrsctp_sysctl_set_sctp_pmtu_raise_time_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_pmtu_raise_time_default()
    ccall((:usrsctp_sysctl_get_sctp_pmtu_raise_time_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_shutdown_guard_time_default(value)
    ccall((:usrsctp_sysctl_set_sctp_shutdown_guard_time_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_shutdown_guard_time_default()
    ccall((:usrsctp_sysctl_get_sctp_shutdown_guard_time_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_secret_lifetime_default(value)
    ccall((:usrsctp_sysctl_set_sctp_secret_lifetime_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_secret_lifetime_default()
    ccall((:usrsctp_sysctl_get_sctp_secret_lifetime_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_rto_max_default(value)
    ccall((:usrsctp_sysctl_set_sctp_rto_max_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_rto_max_default()
    ccall((:usrsctp_sysctl_get_sctp_rto_max_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_rto_min_default(value)
    ccall((:usrsctp_sysctl_set_sctp_rto_min_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_rto_min_default()
    ccall((:usrsctp_sysctl_get_sctp_rto_min_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_rto_initial_default(value)
    ccall((:usrsctp_sysctl_set_sctp_rto_initial_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_rto_initial_default()
    ccall((:usrsctp_sysctl_get_sctp_rto_initial_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_init_rto_max_default(value)
    ccall((:usrsctp_sysctl_set_sctp_init_rto_max_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_init_rto_max_default()
    ccall((:usrsctp_sysctl_get_sctp_init_rto_max_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_valid_cookie_life_default(value)
    ccall((:usrsctp_sysctl_set_sctp_valid_cookie_life_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_valid_cookie_life_default()
    ccall((:usrsctp_sysctl_get_sctp_valid_cookie_life_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_init_rtx_max_default(value)
    ccall((:usrsctp_sysctl_set_sctp_init_rtx_max_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_init_rtx_max_default()
    ccall((:usrsctp_sysctl_get_sctp_init_rtx_max_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_assoc_rtx_max_default(value)
    ccall((:usrsctp_sysctl_set_sctp_assoc_rtx_max_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_assoc_rtx_max_default()
    ccall((:usrsctp_sysctl_get_sctp_assoc_rtx_max_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_path_rtx_max_default(value)
    ccall((:usrsctp_sysctl_set_sctp_path_rtx_max_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_path_rtx_max_default()
    ccall((:usrsctp_sysctl_get_sctp_path_rtx_max_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_add_more_threshold(value)
    ccall((:usrsctp_sysctl_set_sctp_add_more_threshold, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_add_more_threshold()
    ccall((:usrsctp_sysctl_get_sctp_add_more_threshold, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_nr_incoming_streams_default(value)
    ccall((:usrsctp_sysctl_set_sctp_nr_incoming_streams_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_nr_incoming_streams_default()
    ccall((:usrsctp_sysctl_get_sctp_nr_incoming_streams_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_nr_outgoing_streams_default(value)
    ccall((:usrsctp_sysctl_set_sctp_nr_outgoing_streams_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_nr_outgoing_streams_default()
    ccall((:usrsctp_sysctl_get_sctp_nr_outgoing_streams_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_cmt_on_off(value)
    ccall((:usrsctp_sysctl_set_sctp_cmt_on_off, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_cmt_on_off()
    ccall((:usrsctp_sysctl_get_sctp_cmt_on_off, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_cmt_use_dac(value)
    ccall((:usrsctp_sysctl_set_sctp_cmt_use_dac, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_cmt_use_dac()
    ccall((:usrsctp_sysctl_get_sctp_cmt_use_dac, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_use_cwnd_based_maxburst(value)
    ccall((:usrsctp_sysctl_set_sctp_use_cwnd_based_maxburst, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_use_cwnd_based_maxburst()
    ccall((:usrsctp_sysctl_get_sctp_use_cwnd_based_maxburst, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_nat_friendly(value)
    ccall((:usrsctp_sysctl_set_sctp_nat_friendly, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_nat_friendly()
    ccall((:usrsctp_sysctl_get_sctp_nat_friendly, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_L2_abc_variable(value)
    ccall((:usrsctp_sysctl_set_sctp_L2_abc_variable, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_L2_abc_variable()
    ccall((:usrsctp_sysctl_get_sctp_L2_abc_variable, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_mbuf_threshold_count(value)
    ccall((:usrsctp_sysctl_set_sctp_mbuf_threshold_count, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_mbuf_threshold_count()
    ccall((:usrsctp_sysctl_get_sctp_mbuf_threshold_count, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_do_drain(value)
    ccall((:usrsctp_sysctl_set_sctp_do_drain, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_do_drain()
    ccall((:usrsctp_sysctl_get_sctp_do_drain, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_hb_maxburst(value)
    ccall((:usrsctp_sysctl_set_sctp_hb_maxburst, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_hb_maxburst()
    ccall((:usrsctp_sysctl_get_sctp_hb_maxburst, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_abort_if_one_2_one_hits_limit(value)
    ccall((:usrsctp_sysctl_set_sctp_abort_if_one_2_one_hits_limit, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_abort_if_one_2_one_hits_limit()
    ccall((:usrsctp_sysctl_get_sctp_abort_if_one_2_one_hits_limit, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_min_residual(value)
    ccall((:usrsctp_sysctl_set_sctp_min_residual, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_min_residual()
    ccall((:usrsctp_sysctl_get_sctp_min_residual, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_max_retran_chunk(value)
    ccall((:usrsctp_sysctl_set_sctp_max_retran_chunk, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_max_retran_chunk()
    ccall((:usrsctp_sysctl_get_sctp_max_retran_chunk, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_logging_level(value)
    ccall((:usrsctp_sysctl_set_sctp_logging_level, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_logging_level()
    ccall((:usrsctp_sysctl_get_sctp_logging_level, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_default_cc_module(value)
    ccall((:usrsctp_sysctl_set_sctp_default_cc_module, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_default_cc_module()
    ccall((:usrsctp_sysctl_get_sctp_default_cc_module, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_default_frag_interleave(value)
    ccall((:usrsctp_sysctl_set_sctp_default_frag_interleave, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_default_frag_interleave()
    ccall((:usrsctp_sysctl_get_sctp_default_frag_interleave, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_mobility_base(value)
    ccall((:usrsctp_sysctl_set_sctp_mobility_base, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_mobility_base()
    ccall((:usrsctp_sysctl_get_sctp_mobility_base, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_mobility_fasthandoff(value)
    ccall((:usrsctp_sysctl_set_sctp_mobility_fasthandoff, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_mobility_fasthandoff()
    ccall((:usrsctp_sysctl_get_sctp_mobility_fasthandoff, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_inits_include_nat_friendly(value)
    ccall((:usrsctp_sysctl_set_sctp_inits_include_nat_friendly, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_inits_include_nat_friendly()
    ccall((:usrsctp_sysctl_get_sctp_inits_include_nat_friendly, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_udp_tunneling_port(value)
    ccall((:usrsctp_sysctl_set_sctp_udp_tunneling_port, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_udp_tunneling_port()
    ccall((:usrsctp_sysctl_get_sctp_udp_tunneling_port, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_enable_sack_immediately(value)
    ccall((:usrsctp_sysctl_set_sctp_enable_sack_immediately, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_enable_sack_immediately()
    ccall((:usrsctp_sysctl_get_sctp_enable_sack_immediately, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_vtag_time_wait(value)
    ccall((:usrsctp_sysctl_set_sctp_vtag_time_wait, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_vtag_time_wait()
    ccall((:usrsctp_sysctl_get_sctp_vtag_time_wait, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_blackhole(value)
    ccall((:usrsctp_sysctl_set_sctp_blackhole, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_blackhole()
    ccall((:usrsctp_sysctl_get_sctp_blackhole, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_sendall_limit(value)
    ccall((:usrsctp_sysctl_set_sctp_sendall_limit, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_sendall_limit()
    ccall((:usrsctp_sysctl_get_sctp_sendall_limit, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_diag_info_code(value)
    ccall((:usrsctp_sysctl_set_sctp_diag_info_code, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_diag_info_code()
    ccall((:usrsctp_sysctl_get_sctp_diag_info_code, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_fr_max_burst_default(value)
    ccall((:usrsctp_sysctl_set_sctp_fr_max_burst_default, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_fr_max_burst_default()
    ccall((:usrsctp_sysctl_get_sctp_fr_max_burst_default, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_path_pf_threshold(value)
    ccall((:usrsctp_sysctl_set_sctp_path_pf_threshold, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_path_pf_threshold()
    ccall((:usrsctp_sysctl_get_sctp_path_pf_threshold, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_default_ss_module(value)
    ccall((:usrsctp_sysctl_set_sctp_default_ss_module, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_default_ss_module()
    ccall((:usrsctp_sysctl_get_sctp_default_ss_module, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_rttvar_bw(value)
    ccall((:usrsctp_sysctl_set_sctp_rttvar_bw, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_rttvar_bw()
    ccall((:usrsctp_sysctl_get_sctp_rttvar_bw, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_rttvar_rtt(value)
    ccall((:usrsctp_sysctl_set_sctp_rttvar_rtt, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_rttvar_rtt()
    ccall((:usrsctp_sysctl_get_sctp_rttvar_rtt, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_rttvar_eqret(value)
    ccall((:usrsctp_sysctl_set_sctp_rttvar_eqret, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_rttvar_eqret()
    ccall((:usrsctp_sysctl_get_sctp_rttvar_eqret, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_steady_step(value)
    ccall((:usrsctp_sysctl_set_sctp_steady_step, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_steady_step()
    ccall((:usrsctp_sysctl_get_sctp_steady_step, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_use_dccc_ecn(value)
    ccall((:usrsctp_sysctl_set_sctp_use_dccc_ecn, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_use_dccc_ecn()
    ccall((:usrsctp_sysctl_get_sctp_use_dccc_ecn, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_buffer_splitting(value)
    ccall((:usrsctp_sysctl_set_sctp_buffer_splitting, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_buffer_splitting()
    ccall((:usrsctp_sysctl_get_sctp_buffer_splitting, usrsctplib), UInt32, ())
end

function usrsctp_sysctl_set_sctp_initial_cwnd(value)
    ccall((:usrsctp_sysctl_set_sctp_initial_cwnd, usrsctplib), Cint, (UInt32,), value)
end

function usrsctp_sysctl_get_sctp_initial_cwnd()
    ccall((:usrsctp_sysctl_get_sctp_initial_cwnd, usrsctplib), UInt32, ())
end

struct sctp_timeval
    tv_sec::UInt32
    tv_usec::UInt32
end

struct sctpstat
    sctps_discontinuitytime::sctp_timeval
    sctps_currestab::UInt32
    sctps_activeestab::UInt32
    sctps_restartestab::UInt32
    sctps_collisionestab::UInt32
    sctps_passiveestab::UInt32
    sctps_aborted::UInt32
    sctps_shutdown::UInt32
    sctps_outoftheblue::UInt32
    sctps_checksumerrors::UInt32
    sctps_outcontrolchunks::UInt32
    sctps_outorderchunks::UInt32
    sctps_outunorderchunks::UInt32
    sctps_incontrolchunks::UInt32
    sctps_inorderchunks::UInt32
    sctps_inunorderchunks::UInt32
    sctps_fragusrmsgs::UInt32
    sctps_reasmusrmsgs::UInt32
    sctps_outpackets::UInt32
    sctps_inpackets::UInt32
    sctps_recvpackets::UInt32
    sctps_recvdatagrams::UInt32
    sctps_recvpktwithdata::UInt32
    sctps_recvsacks::UInt32
    sctps_recvdata::UInt32
    sctps_recvdupdata::UInt32
    sctps_recvheartbeat::UInt32
    sctps_recvheartbeatack::UInt32
    sctps_recvecne::UInt32
    sctps_recvauth::UInt32
    sctps_recvauthmissing::UInt32
    sctps_recvivalhmacid::UInt32
    sctps_recvivalkeyid::UInt32
    sctps_recvauthfailed::UInt32
    sctps_recvexpress::UInt32
    sctps_recvexpressm::UInt32
    sctps_recv_spare::UInt32
    sctps_recvswcrc::UInt32
    sctps_recvhwcrc::UInt32
    sctps_sendpackets::UInt32
    sctps_sendsacks::UInt32
    sctps_senddata::UInt32
    sctps_sendretransdata::UInt32
    sctps_sendfastretrans::UInt32
    sctps_sendmultfastretrans::UInt32
    sctps_sendheartbeat::UInt32
    sctps_sendecne::UInt32
    sctps_sendauth::UInt32
    sctps_senderrors::UInt32
    sctps_send_spare::UInt32
    sctps_sendswcrc::UInt32
    sctps_sendhwcrc::UInt32
    sctps_pdrpfmbox::UInt32
    sctps_pdrpfehos::UInt32
    sctps_pdrpmbda::UInt32
    sctps_pdrpmbct::UInt32
    sctps_pdrpbwrpt::UInt32
    sctps_pdrpcrupt::UInt32
    sctps_pdrpnedat::UInt32
    sctps_pdrppdbrk::UInt32
    sctps_pdrptsnnf::UInt32
    sctps_pdrpdnfnd::UInt32
    sctps_pdrpdiwnp::UInt32
    sctps_pdrpdizrw::UInt32
    sctps_pdrpbadd::UInt32
    sctps_pdrpmark::UInt32
    sctps_timoiterator::UInt32
    sctps_timodata::UInt32
    sctps_timowindowprobe::UInt32
    sctps_timoinit::UInt32
    sctps_timosack::UInt32
    sctps_timoshutdown::UInt32
    sctps_timoheartbeat::UInt32
    sctps_timocookie::UInt32
    sctps_timosecret::UInt32
    sctps_timopathmtu::UInt32
    sctps_timoshutdownack::UInt32
    sctps_timoshutdownguard::UInt32
    sctps_timostrmrst::UInt32
    sctps_timoearlyfr::UInt32
    sctps_timoasconf::UInt32
    sctps_timodelprim::UInt32
    sctps_timoautoclose::UInt32
    sctps_timoassockill::UInt32
    sctps_timoinpkill::UInt32
    sctps_spare::NTuple{11, UInt32}
    sctps_hdrops::UInt32
    sctps_badsum::UInt32
    sctps_noport::UInt32
    sctps_badvtag::UInt32
    sctps_badsid::UInt32
    sctps_nomem::UInt32
    sctps_fastretransinrtt::UInt32
    sctps_markedretrans::UInt32
    sctps_naglesent::UInt32
    sctps_naglequeued::UInt32
    sctps_maxburstqueued::UInt32
    sctps_ifnomemqueued::UInt32
    sctps_windowprobed::UInt32
    sctps_lowlevelerr::UInt32
    sctps_lowlevelerrusr::UInt32
    sctps_datadropchklmt::UInt32
    sctps_datadroprwnd::UInt32
    sctps_ecnereducedcwnd::UInt32
    sctps_vtagexpress::UInt32
    sctps_vtagbogus::UInt32
    sctps_primary_randry::UInt32
    sctps_cmt_randry::UInt32
    sctps_slowpath_sack::UInt32
    sctps_wu_sacks_sent::UInt32
    sctps_sends_with_flags::UInt32
    sctps_sends_with_unord::UInt32
    sctps_sends_with_eof::UInt32
    sctps_sends_with_abort::UInt32
    sctps_protocol_drain_calls::UInt32
    sctps_protocol_drains_done::UInt32
    sctps_read_peeks::UInt32
    sctps_cached_chk::UInt32
    sctps_cached_strmoq::UInt32
    sctps_left_abandon::UInt32
    sctps_send_burst_avoid::UInt32
    sctps_send_cwnd_avoid::UInt32
    sctps_fwdtsn_map_over::UInt32
    sctps_queue_upd_ecne::UInt32
    sctps_reserved::NTuple{31, UInt32}
end

function usrsctp_get_stat(arg1)
    ccall((:usrsctp_get_stat, usrsctplib), Cvoid, (Ptr{sctpstat},), arg1)
end

struct sctp_tlv
    sn_type::UInt16
    sn_flags::UInt16
    sn_length::UInt32
end

const MSG_NOTIFICATION = 0x2000

# Skipping MacroDefinition: SCTP_PACKED __attribute__ ( ( packed ) )

const AF_CONN = 123

const SCTP_FUTURE_ASSOC = 0

const SCTP_CURRENT_ASSOC = 1

const SCTP_ALL_ASSOC = 2

const SCTP_EVENT_READ = 0x0001

const SCTP_EVENT_WRITE = 0x0002

const SCTP_EVENT_ERROR = 0x0004

const SCTP_ALIGN_RESV_PAD = 92

const SCTP_ALIGN_RESV_PAD_SHORT = 76

const SCTP_NO_NEXT_MSG = 0x0000

const SCTP_NEXT_MSG_AVAIL = 0x0001

const SCTP_NEXT_MSG_ISCOMPLETE = 0x0002

const SCTP_NEXT_MSG_IS_UNORDERED = 0x0004

const SCTP_NEXT_MSG_IS_NOTIFICATION = 0x0008

const SCTP_RECVV_NOINFO = 0

const SCTP_RECVV_RCVINFO = 1

const SCTP_RECVV_NXTINFO = 2

const SCTP_RECVV_RN = 3

const SCTP_SENDV_NOINFO = 0

const SCTP_SENDV_SNDINFO = 1

const SCTP_SENDV_PRINFO = 2

const SCTP_SENDV_AUTHINFO = 3

const SCTP_SENDV_SPA = 4

const SCTP_SEND_SNDINFO_VALID = 0x00000001

const SCTP_SEND_PRINFO_VALID = 0x00000002

const SCTP_SEND_AUTHINFO_VALID = 0x00000004

const SCTP_ASSOC_CHANGE = 0x0001

const SCTP_PEER_ADDR_CHANGE = 0x0002

const SCTP_REMOTE_ERROR = 0x0003

const SCTP_SEND_FAILED = 0x0004

const SCTP_SHUTDOWN_EVENT = 0x0005

const SCTP_ADAPTATION_INDICATION = 0x0006

const SCTP_PARTIAL_DELIVERY_EVENT = 0x0007

const SCTP_AUTHENTICATION_EVENT = 0x0008

const SCTP_STREAM_RESET_EVENT = 0x0009

const SCTP_SENDER_DRY_EVENT = 0x000a

const SCTP_NOTIFICATIONS_STOPPED_EVENT = 0x000b

const SCTP_ASSOC_RESET_EVENT = 0x000c

const SCTP_STREAM_CHANGE_EVENT = 0x000d

const SCTP_SEND_FAILED_EVENT = 0x000e

const SCTP_COMM_UP = 0x0001

const SCTP_COMM_LOST = 0x0002

const SCTP_RESTART = 0x0003

const SCTP_SHUTDOWN_COMP = 0x0004

const SCTP_CANT_STR_ASSOC = 0x0005

const SCTP_ASSOC_SUPPORTS_PR = 0x01

const SCTP_ASSOC_SUPPORTS_AUTH = 0x02

const SCTP_ASSOC_SUPPORTS_ASCONF = 0x03

const SCTP_ASSOC_SUPPORTS_MULTIBUF = 0x04

const SCTP_ASSOC_SUPPORTS_RE_CONFIG = 0x05

const SCTP_ASSOC_SUPPORTS_INTERLEAVING = 0x06

const SCTP_ASSOC_SUPPORTS_MAX = 0x06

const SCTP_ADDR_AVAILABLE = 0x0001

const SCTP_ADDR_UNREACHABLE = 0x0002

const SCTP_ADDR_REMOVED = 0x0003

const SCTP_ADDR_ADDED = 0x0004

const SCTP_ADDR_MADE_PRIM = 0x0005

const SCTP_ADDR_CONFIRMED = 0x0006

const SCTP_PARTIAL_DELIVERY_ABORTED = 0x0001

const SCTP_AUTH_NEW_KEY = 0x0001

const SCTP_AUTH_NO_AUTH = 0x0002

const SCTP_AUTH_FREE_KEY = 0x0003

const SCTP_STREAM_RESET_INCOMING_SSN = 0x0001

const SCTP_STREAM_RESET_OUTGOING_SSN = 0x0002

const SCTP_STREAM_RESET_DENIED = 0x0004

const SCTP_STREAM_RESET_FAILED = 0x0008

const SCTP_STREAM_CHANGED_DENIED = 0x0010

const SCTP_STREAM_RESET_INCOMING = 0x00000001

const SCTP_STREAM_RESET_OUTGOING = 0x00000002

const SCTP_ASSOC_RESET_DENIED = 0x0004

const SCTP_ASSOC_RESET_FAILED = 0x0008

const SCTP_STREAM_CHANGE_DENIED = 0x0004

const SCTP_STREAM_CHANGE_FAILED = 0x0008

const SCTP_DATA_UNSENT = 0x0001

const SCTP_DATA_SENT = 0x0002

const SCTP_DATA_LAST_FRAG = 0x0001

const SCTP_DATA_NOT_FRAG = 0x0003

const SCTP_NOTIFICATION = 0x0010

const SCTP_COMPLETE = 0x0020

const SCTP_EOF = 0x0100

const SCTP_ABORT = 0x0200

const SCTP_UNORDERED = 0x0400

const SCTP_ADDR_OVER = 0x0800

const SCTP_SENDALL = 0x1000

const SCTP_EOR = 0x2000

const SCTP_SACK_IMMEDIATELY = 0x4000

const SCTP_PR_SCTP_NONE = 0x0000

const SCTP_PR_SCTP_TTL = 0x0001

const SCTP_PR_SCTP_BUF = 0x0002

const SCTP_PR_SCTP_RTX = 0x0003

const SCTP_RTOINFO = 0x00000001

const SCTP_ASSOCINFO = 0x00000002

const SCTP_INITMSG = 0x00000003

const SCTP_NODELAY = 0x00000004

const SCTP_AUTOCLOSE = 0x00000005

const SCTP_PRIMARY_ADDR = 0x00000007

const SCTP_ADAPTATION_LAYER = 0x00000008

const SCTP_DISABLE_FRAGMENTS = 0x00000009

const SCTP_PEER_ADDR_PARAMS = 0x0000000a

const SCTP_I_WANT_MAPPED_V4_ADDR = 0x0000000d

const SCTP_MAXSEG = 0x0000000e

const SCTP_DELAYED_SACK = 0x0000000f

const SCTP_FRAGMENT_INTERLEAVE = 0x00000010

const SCTP_PARTIAL_DELIVERY_POINT = 0x00000011

const SCTP_HMAC_IDENT = 0x00000014

const SCTP_AUTH_ACTIVE_KEY = 0x00000015

const SCTP_AUTO_ASCONF = 0x00000018

const SCTP_MAX_BURST = 0x00000019

const SCTP_CONTEXT = 0x0000001a

const SCTP_EXPLICIT_EOR = 0x0000001b

const SCTP_REUSE_PORT = 0x0000001c

const SCTP_EVENT = 0x0000001e

const SCTP_RECVRCVINFO = 0x0000001f

const SCTP_RECVNXTINFO = 0x00000020

const SCTP_DEFAULT_SNDINFO = 0x00000021

const SCTP_DEFAULT_PRINFO = 0x00000022

const SCTP_REMOTE_UDP_ENCAPS_PORT = 0x00000024

const SCTP_ECN_SUPPORTED = 0x00000025

const SCTP_PR_SUPPORTED = 0x00000026

const SCTP_AUTH_SUPPORTED = 0x00000027

const SCTP_ASCONF_SUPPORTED = 0x00000028

const SCTP_RECONFIG_SUPPORTED = 0x00000029

const SCTP_NRSACK_SUPPORTED = 0x00000030

const SCTP_PKTDROP_SUPPORTED = 0x00000031

const SCTP_MAX_CWND = 0x00000032

const SCTP_ENABLE_STREAM_RESET = 0x00000900

const SCTP_PLUGGABLE_SS = 0x00001203

const SCTP_SS_VALUE = 0x00001204

const SCTP_STATUS = 0x00000100

const SCTP_GET_PEER_ADDR_INFO = 0x00000101

const SCTP_PEER_AUTH_CHUNKS = 0x00000102

const SCTP_LOCAL_AUTH_CHUNKS = 0x00000103

const SCTP_GET_ASSOC_NUMBER = 0x00000104

const SCTP_GET_ASSOC_ID_LIST = 0x00000105

const SCTP_TIMEOUTS = 0x00000106

const SCTP_PR_STREAM_STATUS = 0x00000107

const SCTP_PR_ASSOC_STATUS = 0x00000108

const SCTP_SET_PEER_PRIMARY_ADDR = 0x00000006

const SCTP_AUTH_CHUNK = 0x00000012

const SCTP_AUTH_KEY = 0x00000013

const SCTP_AUTH_DEACTIVATE_KEY = 0x0000001d

const SCTP_AUTH_DELETE_KEY = 0x00000016

const SCTP_RESET_STREAMS = 0x00000901

const SCTP_RESET_ASSOC = 0x00000902

const SCTP_ADD_STREAMS = 0x00000903

const SPP_HB_ENABLE = 0x00000001

const SPP_HB_DISABLE = 0x00000002

const SPP_HB_DEMAND = 0x00000004

const SPP_PMTUD_ENABLE = 0x00000008

const SPP_PMTUD_DISABLE = 0x00000010

const SPP_HB_TIME_IS_ZERO = 0x00000080

const SPP_IPV6_FLOWLABEL = 0x00000100

const SPP_DSCP = 0x00000200

const SCTP_ENABLE_RESET_STREAM_REQ = 0x00000001

const SCTP_ENABLE_RESET_ASSOC_REQ = 0x00000002

const SCTP_ENABLE_CHANGE_ASSOC_REQ = 0x00000004

const SCTP_ENABLE_VALUE_MASK = 0x00000007

const SCTP_AUTH_HMAC_ID_RSVD = 0x0000

const SCTP_AUTH_HMAC_ID_SHA1 = 0x0001

const SCTP_AUTH_HMAC_ID_SHA256 = 0x0003

const SCTP_AUTH_HMAC_ID_SHA224 = 0x0004

const SCTP_AUTH_HMAC_ID_SHA384 = 0x0005

const SCTP_AUTH_HMAC_ID_SHA512 = 0x0006

const SCTP_CLOSED = 0x0000

const SCTP_BOUND = 0x1000

const SCTP_LISTEN = 0x2000

const SCTP_COOKIE_WAIT = 0x0002

const SCTP_COOKIE_ECHOED = 0x0004

const SCTP_ESTABLISHED = 0x0008

const SCTP_SHUTDOWN_SENT = 0x0010

const SCTP_SHUTDOWN_RECEIVED = 0x0020

const SCTP_SHUTDOWN_ACK_SENT = 0x0040

const SCTP_SHUTDOWN_PENDING = 0x0080

const SCTP_ACTIVE = 0x0001

const SCTP_INACTIVE = 0x0002

const SCTP_UNCONFIRMED = 0x0200

const SCTP_DATA = 0x00

const SCTP_INITIATION = 0x01

const SCTP_INITIATION_ACK = 0x02

const SCTP_SELECTIVE_ACK = 0x03

const SCTP_HEARTBEAT_REQUEST = 0x04

const SCTP_HEARTBEAT_ACK = 0x05

const SCTP_ABORT_ASSOCIATION = 0x06

const SCTP_SHUTDOWN = 0x07

const SCTP_SHUTDOWN_ACK = 0x08

const SCTP_OPERATION_ERROR = 0x09

const SCTP_COOKIE_ECHO = 0x0a

const SCTP_COOKIE_ACK = 0x0b

const SCTP_ECN_ECHO = 0x0c

const SCTP_ECN_CWR = 0x0d

const SCTP_SHUTDOWN_COMPLETE = 0x0e

const SCTP_AUTHENTICATION = 0x0f

const SCTP_NR_SELECTIVE_ACK = 0x10

const SCTP_ASCONF_ACK = 0x80

const SCTP_PACKET_DROPPED = 0x81

const SCTP_STREAM_RESET = 0x82

const SCTP_PAD_CHUNK = 0x84

const SCTP_FORWARD_CUM_TSN = 0xc0

const SCTP_ASCONF = 0xc1

const SCTP_CC_RFC2581 = 0x00000000

const SCTP_CC_HSTCP = 0x00000001

const SCTP_CC_HTCP = 0x00000002

const SCTP_CC_RTCC = 0x00000003

const SCTP_CC_OPT_RTCC_SETMODE = 0x00002000

const SCTP_CC_OPT_USE_DCCC_EC = 0x00002001

const SCTP_CC_OPT_STEADY_STEP = 0x00002002

const SCTP_CMT_OFF = 0

const SCTP_CMT_BASE = 1

const SCTP_CMT_RPV1 = 2

const SCTP_CMT_RPV2 = 3

const SCTP_CMT_MPTCP = 4

const SCTP_CMT_MAX = SCTP_CMT_MPTCP

const SCTP_SS_DEFAULT = 0x00000000

const SCTP_SS_ROUND_ROBIN = 0x00000001

const SCTP_SS_ROUND_ROBIN_PACKET = 0x00000002

const SCTP_SS_PRIORITY = 0x00000003

const SCTP_SS_FAIR_BANDWITH = 0x00000004

const SCTP_SS_FIRST_COME = 0x00000005

const SCTP_BINDX_ADD_ADDR = 0x00008001

const SCTP_BINDX_REM_ADDR = 0x00008002

const SCTP_DUMP_OUTBOUND = 1

const SCTP_DUMP_INBOUND = 0

# Skipping MacroDefinition: USRSCTP_SYSCTL_DECL ( __field ) int usrsctp_sysctl_set_ ## __field ( uint32_t value ) ; uint32_t usrsctp_sysctl_get_ ## __field ( void ) ;

# exports
const PREFIXES = ["Sctp", "sctp_", "usrsctp_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
