#!/bin/bash

# 定义颜色常量
GREEN='\033[0;32m'
RED='\033[0m'
NC='\033[0m' # No Color

# 设置要排除的文件名数组
EXCLUDE_FILES=("上传.sh" "拉取.sh" "还原.sh")

# 检查是否在Git仓库中
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "当前目录不是一个Git仓库。"
  exit 1
fi

# 构建排除文件参数
EXCLUDE_PARAMS=()
for FILE in "${EXCLUDE_FILES[@]}"; do
  EXCLUDE_PARAMS+=(":!$FILE")
done

# 添加所有更改到暂存区，排除特定文件
git add --all "${EXCLUDE_PARAMS[@]}"

# 检查是否有文件被修改或新增
if git diff-index --quiet HEAD --; then
  echo "没有文件需要提交。"
  exit 0
fi

# 提交更改
git commit -m "Update repository"

# 推送到远程仓库
git push origin $(git rev-parse --abbrev-ref HEAD)

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
