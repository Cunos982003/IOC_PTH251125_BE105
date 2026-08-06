#!/bin/bash

# 1. Cập nhật danh sách gói và nâng cấp hệ thống
sudo apt-get update && sudo apt-get upgrade -y

# 2. Cài đặt các gói phần mềm bắt buộc: openjdk-17-jdk, git, curl
sudo apt-get install -y openjdk-17-jdk git curl

# 3. Kiểm tra sự tồn tại của group 'quickbite', nếu chưa có thì tạo mới
if getent group quickbite > /dev/null 2>&1; then
    echo "Group quickbite đã tồn tại."
else
    sudo groupadd quickbite
    echo "Đã tạo group quickbite."
fi

# 4. Kiểm tra và tạo system user 'quickbite'
# Ràng buộc: Thuộc group 'quickbite', không tạo home dir (-r hoặc -M), shell là /bin/false
if id "quickbite" > /dev/null 2>&1; then
    echo "User quickbite đã tồn tại."
else
    sudo useradd -r -g quickbite -s /bin/false quickbite
    echo "Đã tạo user quickbite thành công."
fi
