#!/bin/bash
# Redis 版本检查脚本
# 自动查询 Redis 官方 GitHub API，检测各大版本系列的最新版本

set -e

REDIS_REPO="redis/redis"
VERSIONS_FILE="versions.json"
API_URL="https://api.github.com/repos/${REDIS_REPO}/releases?per_page=100"

echo "正在查询 Redis 官方版本..."

# 获取所有发布版本
RELEASES=$(curl -s "${API_URL}")

# 检查 API 调用是否成功
if [ -z "$RELEASES" ]; then
  echo "错误: 无法从 GitHub API 获取数据"
  exit 1
fi

# 提取各大版本系列的最新版本
echo "检测到的最新版本："
echo ""

# 8.6.x 系列
LATEST_8_6=$(echo "$RELEASES" | jq -r '[.[] | select(.tag_name | startswith("8.6.")) | select(.prerelease == false) | .tag_name] | first')
echo "8.6.x 系列: ${LATEST_8_6}"

# 8.4.x 系列
LATEST_8_4=$(echo "$RELEASES" | jq -r '[.[] | select(.tag_name | startswith("8.4.")) | select(.prerelease == false) | .tag_name] | first')
echo "8.4.x 系列: ${LATEST_8_4}"

# 8.2.x 系列
LATEST_8_2=$(echo "$RELEASES" | jq -r '[.[] | select(.tag_name | startswith("8.2.")) | select(.prerelease == false) | .tag_name] | first')
echo "8.2.x 系列: ${LATEST_8_2}"

# 8.0.x 系列
LATEST_8_0=$(echo "$RELEASES" | jq -r '[.[] | select(.tag_name | startswith("8.0.")) | select(.prerelease == false) | .tag_name] | first')
echo "8.0.x 系列: ${LATEST_8_0}"

# 7.4.x 系列
LATEST_7_4=$(echo "$RELEASES" | jq -r '[.[] | select(.tag_name | startswith("7.4.")) | select(.prerelease == false) | .tag_name] | first')
echo "7.4.x 系列: ${LATEST_7_4}"

# 7.2.x 系列
LATEST_7_2=$(echo "$RELEASES" | jq -r '[.[] | select(.tag_name | startswith("7.2.")) | select(.prerelease == false) | .tag_name] | first')
echo "7.2.x 系列: ${LATEST_7_2}"

# 6.2.x 系列
LATEST_6_2=$(echo "$RELEASES" | jq -r '[.[] | select(.tag_name | startswith("6.2.")) | select(.prerelease == false) | .tag_name] | first')
echo "6.2.x 系列: ${LATEST_6_2}"

echo ""

# 读取当前配置的版本
if [ ! -f "$VERSIONS_FILE" ]; then
  echo "错误: 找不到 ${VERSIONS_FILE} 文件"
  exit 1
fi

CURRENT_VERSIONS=$(jq -r '.versions[]' "$VERSIONS_FILE")

echo "当前配置的版本："
echo "$CURRENT_VERSIONS"
echo ""

# 对比并提示更新
echo "版本对比："
NEEDS_UPDATE=false

check_version() {
  local series=$1
  local latest=$2
  local current=$(echo "$CURRENT_VERSIONS" | grep "^${series}" || echo "")
  
  if [ -z "$latest" ] || [ "$latest" = "null" ]; then
    echo "⚠️  ${series} 系列: 未找到最新版本"
  elif [ -z "$current" ]; then
    echo "➕ ${series} 系列: ${latest} (新系列，建议添加)"
    NEEDS_UPDATE=true
  elif [ "$current" != "$latest" ]; then
    echo "🔄 ${series} 系列: ${current} → ${latest} (有更新)"
    NEEDS_UPDATE=true
  else
    echo "✅ ${series} 系列: ${latest} (已是最新)"
  fi
}

check_version "8.6" "$LATEST_8_6"
check_version "8.4" "$LATEST_8_4"
check_version "8.2" "$LATEST_8_2"
check_version "8.0" "$LATEST_8_0"
check_version "7.4" "$LATEST_7_4"
check_version "7.2" "$LATEST_7_2"
check_version "6.2" "$LATEST_6_2"

echo ""

if [ "$NEEDS_UPDATE" = true ]; then
  echo "发现版本更新！"
  echo ""
  echo "建议的新 versions.json 内容："
  echo "{"
  echo "  \"versions\": ["
  
  VERSIONS_ARRAY=""
  [ -n "$LATEST_8_6" ] && [ "$LATEST_8_6" != "null" ] && VERSIONS_ARRAY="${VERSIONS_ARRAY}    \"${LATEST_8_6}\",\n"
  [ -n "$LATEST_8_4" ] && [ "$LATEST_8_4" != "null" ] && VERSIONS_ARRAY="${VERSIONS_ARRAY}    \"${LATEST_8_4}\",\n"
  [ -n "$LATEST_8_2" ] && [ "$LATEST_8_2" != "null" ] && VERSIONS_ARRAY="${VERSIONS_ARRAY}    \"${LATEST_8_2}\",\n"
  [ -n "$LATEST_8_0" ] && [ "$LATEST_8_0" != "null" ] && VERSIONS_ARRAY="${VERSIONS_ARRAY}    \"${LATEST_8_0}\",\n"
  [ -n "$LATEST_7_4" ] && [ "$LATEST_7_4" != "null" ] && VERSIONS_ARRAY="${VERSIONS_ARRAY}    \"${LATEST_7_4}\",\n"
  [ -n "$LATEST_7_2" ] && [ "$LATEST_7_2" != "null" ] && VERSIONS_ARRAY="${VERSIONS_ARRAY}    \"${LATEST_7_2}\",\n"
  [ -n "$LATEST_6_2" ] && [ "$LATEST_6_2" != "null" ] && VERSIONS_ARRAY="${VERSIONS_ARRAY}    \"${LATEST_6_2}\",\n"
  
  # 移除最后的逗号
  VERSIONS_ARRAY=$(echo -e "$VERSIONS_ARRAY" | sed '$ s/,$//')
  
  echo -e "$VERSIONS_ARRAY"
  echo "  ]"
  echo "}"
  
  exit 1
else
  echo "所有版本都是最新的！✓"
  exit 0
fi
