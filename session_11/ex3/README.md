# Bài 3: Bảo mật bằng HTTPS với Let's Encrypt

## 1. Tổng quan
Bài tập hướng dẫn cài đặt chứng chỉ SSL/TLS miễn phí từ Let's Encrypt bằng Certbot cho domain `api.my-ecommerce.com` và tự động hóa quá trình gia hạn.

---

## 2. Các file cấu hình trong Repository
- `install_certbot.sh`: Lệnh cài đặt Certbot và tự động xin cấp SSL.
- `nginx.conf`: File cấu hình Nginx chi tiết cho Port 80 (Redirect HTTP -> HTTPS) và Port 443 (HTTPS SSL).

---

## 3. Cấu hình tự động gia hạn chứng chỉ (Renew SSL 90 ngày)

### Cơ chế mặc định của Systemd Timer
Khi cài đặt package `python3-certbot-nginx`, hệ thống tự động kích hoạt một **Systemd Timer** (`certbot.timer`) chạy 2 lần/ngày để kiểm tra và gia hạn chứng chỉ khi thời hạn còn dưới 30 ngày.

### Lệnh kiểm tra giả lập quá trình gia hạn:
```bash
sudo certbot renew --dry-run