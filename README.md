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
- `redis-8.6.2-linux-x86_64.tar.gz`
- `redis-7.4.8-macos-arm64.tar.gz`
- `redis-6.2.20-windows-x86_64.zip`

## 自动构建

本项目使用 GitHub Actions 自动构建所有平台的二进制文件。

### 构建方式

#### 1. 批量构建所有版本（推荐）

在 GitHub Actions 页面手动触发 workflow：

1. 访问项目的 Actions 标签页
2. 选择 "Build and Release Redis" workflow
3. 点击 "Run workflow"
4. 选择是否构建所有版本（默认为是）
5. 点击 "Run workflow" 启动构建

这将构建 `versions.json` 中定义的所有 Redis 版本。

#### 2. 构建单个版本

推送与 Redis 官方版本号完全一致的 tag：

```bash
# 示例：构建 Redis 8.6.2
git tag 8.6.2
git push origin 8.6.2
```

**注意**: Tag 名称必须与 Redis 官方仓库的 tag 完全一致（如 `7.2.13`、`8.6.2`），不能使用自定义名称。

### 支持的版本

当前配置支持的 Redis 版本列表在 [`versions.json`](versions.json) 文件中定义：

```json
{
  "versions": [
    "8.6.2",
    "7.4.8",
    "6.2.20"
  ]
}
```

这些版本对应 Redis 各大版本系列的最新稳定版本。

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
