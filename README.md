# opensips-cfg-template

这个demo的用意是介绍一种用M4来合理规划opensips脚本目录的方案。

# Features

- 使用include指令引入其他文件, 多个文件，方便扩展
- 条件编译根据CF_ENABLE_TCP来决定是否开启TCP监听
- 环境变量注入
- 注入版本号
- 开发环境用dev.env, 生产环境用prd.env覆盖dev.env
- 注入构建时间，版本

# Docker环境

在docker环境里，我们只需要在启动的entrypoint.sh里先执行m4来生成opensips脚本再启动，就可以了

```
#!/bin/bash

if [ -f /usr/local/etc/opensips/main.m4 ]; then
    # 根据main.m4来生成opensips.cfg
    echo "build opensips.cfg from /usr/local/etc/opensips/main.m4";
    cd /usr/local/etc/opensips/ || exit
    m4 ./main.m4 > ./opensips.cfg;
    echo opensips.cfg
fi

# 检查OpenSIPS配置文件是否合法
if opensips -C /usr/local/etc/opensips/opensips.cfg ; then
  echo "INFO: opensips.cfg is ok"
else
  echo "ERROR: opensips.cfg check error"
  exit 1;
fi

# 执行opensips
opensips -F $@
```
