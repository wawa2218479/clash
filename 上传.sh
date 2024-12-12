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

# 添加所有更改到暂存区
git add .

# 提交更改，使用当前时间作为提交信息
git commit -m "Update $(date)"

# 推送到远程仓库的主分支
git push origin main

# 检查推送是否成功
if [ $? -eq 0 ]; then
  echo -e "${GREEN}文件已成功上传到Git仓库。${NC}"
else
  echo -e "${RED}文件上传到Git仓库时出错。${NC}"
fi

# 提醒用户脚本将在5秒后关闭
echo "脚本将在5秒后关闭..."

# 等待5秒
sleep 5
