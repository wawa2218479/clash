#!/bin/bash

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
  echo "文件已成功上传到Git仓库。"
else
  echo "文件上传到Git仓库时出错。"
  
# 等待5秒后关闭脚本
sleep 5
fi

