#!/bin/bash

# 1. Tạo user mới có tên rikkeilms
sudo useradd -m -s /bin/bash rikkeilms

# 2. Tạo thư mục chứa mã nguồn và cấu hình
sudo mkdir -p /opt/rikkei/course-service

# 3. Chuyển quyền sở hữu (owner và group) cho user rikkeilms
sudo chown -R rikkeilms:rikkeilms /opt/rikkei/course-service

# 4. Cấp quyền: Chủ sở hữu có toàn quyền (rwx - 7), Group và Others chỉ có quyền đọc và thực thi (r-x - 5)
# Chuỗi quyền tương đương: drwxr-xr-x
sudo chmod 755 /opt/rikkei/course-service

# 5. Kiểm tra lại kết quả
ls -ld /opt/rikkei/course-service

