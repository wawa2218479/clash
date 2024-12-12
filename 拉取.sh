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

# 拉取远程仓库的最新更改
git pull origin $(git rev-parse --abbrev-ref HEAD)

# 检查拉取是否成功
if [ $? -eq 0 ]; then
  echo -e "${GREEN}已成功从Git仓库拉取最新更改。${NC}"
else
  echo -e "${RED}从Git仓库拉取更改时出错。${NC}"
fi

# 提醒用户脚本将在5秒后关闭
echo "脚本将在5秒后关闭..."

# 等待5秒
sleep 5
