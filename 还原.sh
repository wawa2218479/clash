#!/bin/bash

# 定义颜色常量
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 检查是否在Git仓库中
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "当前目录不是一个Git仓库。"
  exit 1
fi

# 提醒用户所有未提交的更改将被丢弃
read -p "这将丢弃所有未提交的更改。你确定要继续吗？[${GREEN}y${NC}/${RED}n${NC}] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "操作已取消。"
  exit 1
fi

# 重置本地分支到远程仓库的最新状态
git fetch --all
git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)

# 检查还原是否成功
if [ $? -eq 0 ]; then
  echo -e "${GREEN}本地分支已成功还原到远程仓库的最新状态。${NC}"
else
  echo -e "${RED}还原操作失败。${NC}"
fi

# 提醒用户脚本将在5秒后关闭
echo "脚本将在5秒后关闭..."

# 等待5秒
sleep 5
