log_level=3
log_stderror=no
log_facility=LOG_LOCAL0
children=4
debug_mode=yes
disable_dns_blacklist=no
dns_try_ipv6=yes
auto_aliases=no

server_header="Server: Cool CF_VERSION"
user_agent_header="User-Agent: Cool CF_VERSION"

listen=udp:CF_LOCAL_IP:CF_LOCAL_PORT as CF_PUBLIC_IP:CF_PUBLIC_PORT

# 根据环境变量决定是否要启用tcp listen
ifelse(CF_ENABLE_TCP,yes,
listen=tcp:CF_LOCAL_IP:CF_LOCAL_PORT as CF_PUBLIC_IP:CF_PUBLIC_PORT
)dnl
