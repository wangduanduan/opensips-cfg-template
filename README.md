# opensips-cfg-template

opensips cfg 脚本模版例子

# Features

- 使用include指令引入其他文件, 多个文件，方便扩展
- 条件编译根据CF_ENABLE_TCP来决定是否开启TCP监听
- 环境变量注入
- 注入版本号
- 开发环境用dev.env, 生产环境用prd.env覆盖dev.env
- 注入构建时间，版本
