using Sctp
using Test
import Sockets: IPv4, @ip_str

@testset "Sctp.jl" begin
    # Write your tests here.
    sctp_init()
    sock = SctpSocket()
    
    bind(sock, ip"0.0.0.0", 5050)
    
    # TODO listen()
end

@testset "Bind socket" begin
end
