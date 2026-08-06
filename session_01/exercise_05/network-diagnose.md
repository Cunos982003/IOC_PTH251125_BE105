# Báo Cáo Chẩn Đoán Kết Nối Mạng Và Xử Lý Trùng Cổng

## Tình huống 1: Khắc phục lỗi trùng cổng 8080 (Address already in use)

### Các câu lệnh thực hiện:
1. **Kiểm tra tiến trình đang chiếm cổng 8080:**
   ```bash
   sudo ss -tulpn | grep :8080
