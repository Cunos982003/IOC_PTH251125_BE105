#!/bin/bash

# 1. Tạo thư mục trên máy host để lưu trữ dữ liệu
sudo mkdir -p /opt/rikkei/pg-data

# 2. Khởi chạy container PostgreSQL 13 với mật khẩu Rikkei@2026 và mount volume
docker run -d \
  --name rikkei-db \
  -e POSTGRES_PASSWORD=Rikkei@2026 \
  -v /opt/rikkei/pg-data:/var/lib/postgresql/data \
  postgres:13

# 3. Chờ 5 giây để PostgreSQL khởi tạo dữ liệu ban đầu vào thư mục
sleep 5

# 4. Kiểm tra danh sách các file dữ liệu đã được ghi vào thư mục host
ls -l /opt/rikkei/pg-data
