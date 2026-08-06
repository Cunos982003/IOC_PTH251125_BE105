#!/bin/bash

# Khai báo màu sắc cho thông báo
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

APP_DIR="/opt/quickbite/user-service"
JAR_NAME="user-service-0.0.1.jar"
LOG_FILE="/var/log/quickbite-app.log"

echo -e "${YELLOW}=== BẮT ĐẦU TRIỂN KHAI TỰ ĐỘNG (DEPLOYMENT) ===${NC}"

# Bước 1: Biên dịch mã nguồn (Build & Test - Fail-fast)
echo -e "\n[1/5] Đang biên dịch mã nguồn (Build & Test)..."
if [ -f "./gradlew" ]; then
    ./gradlew clean bootJar
    BUILD_EXIT_CODE=$?
    if [ $BUILD_EXIT_CODE -ne 0 ]; then
        echo -e "${RED}[LỖI] Quá trình Build mã nguồn thất bại (Exit code: $BUILD_EXIT_CODE). Dừng triển khai ngay lập tức!${NC}"
        exit 1
    fi
else
    echo -e "${RED}[LỖI] Không tìm thấy file ./gradlew trong thư mục hiện tại!${NC}"
    exit 1
fi
echo -e "${GREEN}-> Build mã nguồn thành công!${NC}"

# Bước 2: Chuẩn bị hạ tầng thư mục
echo -e "\n[2/5] Kiểm tra và chuẩn bị thư mục ứng dụng..."
if [ ! -d "$APP_DIR" ]; then
    mkdir -p "$APP_DIR"
    echo -e "Đã tạo thư mục: $APP_DIR"
fi
chown -R quickbite:quickbite /opt/quickbite
echo -e "${GREEN}-> Hạ tầng thư mục đã sẵn sàng!${NC}"

# Bước 3: Sao chép ứng dụng & Dừng dịch vụ cũ
echo -e "\n[3/5] Dừng dịch vụ cũ và sao chép file JAR..."
# Dừng tiến trình cũ đang chạy file JAR (nếu có)
pkill -f "$JAR_NAME" || true

# Tìm và sao chép file JAR vừa build
JAR_SRC=$(find build/libs -name "*.jar" ! -name "*-plain.jar" | head -n 1)
if [ -f "$JAR_SRC" ]; then
    cp "$JAR_SRC" "$APP_DIR/$JAR_NAME"
    chown quickbite:quickbite "$APP_DIR/$JAR_NAME"
    echo -e "${GREEN}-> Đã sao chép $JAR_SRC vào $APP_DIR/$JAR_NAME${NC}"
else
    echo -e "${RED}[LỖI] Không tìm thấy file JAR sau khi build!${NC}"
    exit 1
fi

# Bước 4: Khởi động dịch vụ
echo -e "\n[4/5] Khởi động dịch vụ chạy ngầm bằng user quickbite..."
su -s /bin/bash quickbite -c "nohup java -jar $APP_DIR/$JAR_NAME > $LOG_FILE 2>&1 &"
echo -e "${GREEN}-> Tiến trình ứng dụng đã được khởi chạy ngầm!${NC}"

# Bước 5: Smoke Test
echo -e "\n[5/5] Thực hiện Smoke Test (Chờ 5 giây)..."
sleep 5

# Kiểm tra cổng 8080 xem đã lắng nghe chưa
if ss -tulpn | grep -q ":8080"; then
    echo -e "\n${GREEN}===============================================${NC}"
    echo -e "${GREEN}  DEPLOYS DỊCH VỤ THÀNH CÔNG! (Cổng 8080 MỞ)   ${NC}"
    echo -e "${GREEN}===============================================${NC}"
else
    echo -e "\n${RED}===============================================${NC}"
    echo -e "${RED}  DEPLOY THẤT BẠI! Dịch vụ không lắng nghe cổng 8080 ${NC}"
    echo -e "${RED}===============================================${NC}"
    echo -e "${YELLOW}Trích xuất 30 dòng log cuối cùng để debug:${NC}"
    echo "--------------------------------------------------"
    tail -n 30 "$LOG_FILE"
    echo "--------------------------------------------------"
    exit 1
fi
