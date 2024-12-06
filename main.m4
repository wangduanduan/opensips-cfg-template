include(`./conf/env.m4')dnl
`#' BUILD_TIME: CF_BUILD_TIME
`#' BUILD_VERSION: CF_VERSION
# ----------------------------------------------------

include(`./conf/global.m4')
include(`./conf/mod.m4')

# mian request route
include(`./conf/request.m4')

include(`./conf/r_relay.m4')
include(`./conf/r_branch_ops.m4')
include(`./conf/r_handle_nat.m4')
include(`./conf/r_missed_call.m4')

