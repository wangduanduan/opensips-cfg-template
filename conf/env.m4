divert(-1)

# 内网地址
define(`CF_LOCAL_IP', `esyscmd(`printf "${CF_LOCAL_IP}"')')dnl
define(`CF_LOCAL_PORT', `esyscmd(`printf "${CF_LOCAL_PORT:-5060}"')')dnl

# 公网地址
define(`CF_PUBLIC_IP', `esyscmd(`printf "${CF_PUBLIC_IP}"')')dnl
define(`CF_PUBLIC_PORT', `esyscmd(`printf "${CF_PUBLIC_PORT:-5060}"')')dnl

# 数据库连接地址
define(`CF_DB', `esyscmd(`printf "${CF_DB}"')')dnl

# 获取VERSION版本号
define(`CF_VERSION', `esyscmd(`cat VERSION | tr -d "\n"')')dnl

# 是否开启TCP, 默认yes
define(`CF_ENABLE_TCP', `esyscmd(`printf "${CF_ENABLE_TCP:-yes}"')')dnl

define(`CF_BUILD_TIME', `esyscmd(`date | tr -d "\n"')')dnl

divert(0)dnl
