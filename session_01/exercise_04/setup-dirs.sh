#!/bin/bash

# 1. Tạo thư mục làm việc của dự án
sudo mkdir -p /opt/quickbite/user-service

# 2. Thay đổi chủ sở hữu của /opt/quickbite (và thư mục con) cho user quickbite và group quickbite
sudo chown -R quickbite:quickbite /opt/quickbite

# 3. Đặt quyền hạn truy cập tập tin cho thư mục /opt/quickbite là 750
sudo chmod -R 750 /opt/quickbite

# 4. Giải thích ý nghĩa của mã số phân quyền 750:
# - Chữ số 7 (Owner - quickbite): rwx -> Có đầy đủ quyền Đọc (Read - 4), Ghi (Write - 2), và Thực thi/Truy cập thư mục (Execute - 1).
# - Chữ số 5 (Group - quickbite): r-x -> Chỉ có quyền Đọc (Read - 4) và Thực thi/Truy cập thư mục (Execute - 1), không có quyền Ghi/Sửa file.
# - Chữ số 0 (Others - người dùng khác): --- -> Không có bất kỳ quyền truy cập nào (Không Đọc, Không Ghi, Không Thực thi).
