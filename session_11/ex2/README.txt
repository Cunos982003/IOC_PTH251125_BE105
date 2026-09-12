Tại sao phải truyền Header X-Forwarded-For?

Khi client gửi request đến Nginx và Nginx chuyển tiếp request đó tới Backend, kết nối TCP thực sự được tạo ra là giữa Nginx và Backend.

Header X-Forwarded-For được dùng để lưu trữ lại danh sách các IP mà request đã đi qua (bao gồm cả IP gốc của Client người dùng cuối).

Nếu không truyền X-Forwarded-For, Backend sẽ thấy IP của ai?

Nếu không cấu hình truyền X-Forwarded-For, Backend sẽ chỉ nhìn thấy IP của Nginx Reverse Proxy (127.0.0.1 hoặc IP nội bộ của Nginx server).

Điều này làm cho Backend không thể xác định được IP thực sự của người dùng, gây ảnh hưởng đến các tính năng như giới hạn truy cập (rate limiting), ghi log an ninh, hoặc chặn IP xấu.