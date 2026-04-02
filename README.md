# Redis Archive - 预编译二进制分发包

这个项目提供 Redis 的预编译二进制文件，支持多个平台和架构。

## 支持的平台

- **Linux**
  - x86_64 (AMD64)
  - arm64 (aarch64)
  
- **macOS**
  - x86_64 (Intel)
  - arm64 (Apple Silicon)
  
- **Windows**
  - x86_64 (AMD64)
  - arm64

## 下载

从 [Releases](https://github.com/你的用户名/redis-archive/releases) 页面下载适合你平台的预编译包。

### 文件命名格式

```
redis-{版本号}-{操作系统}-{架构}.{扩展名}
```

例如：
- `redis-7.2.4-linux-x86_64.tar.gz`
- `redis-7.2.4-macos-arm64.tar.gz`
- `redis-7.2.4-windows-x86_64.zip`

## 自动构建

本项目使用 GitHub Actions 自动构建所有平台的二进制文件。当推送新的 Git tag 时，将自动触发构建流程。

### 触发新的构建

```bash
git tag v202604021643
git push origin v202604021643
```

## 版本说明

构建的版本对应于 Redis 官方仓库的 tag 版本。访问 [Redis GitHub](https://github.com/redis/redis) 查看所有可用版本。

## 许可证

本项目遵循 Redis 的 BSD 3-Clause 许可证。详见 [LICENSE](LICENSE) 文件。

## 相关链接

- [Redis 官方网站](https://redis.io/)
- [Redis GitHub 仓库](https://github.com/redis/redis)
- [Redis 文档](https://redis.io/docs/)

## 免责声明

本项目仅提供预编译的 Redis 二进制文件分发，不对 Redis 本身进行任何修改。所有二进制文件均从 Redis 官方源码编译而来（Windows 版本除外，使用社区维护的版本）。
