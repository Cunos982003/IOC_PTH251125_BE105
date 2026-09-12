Giải thích ý nghĩa của chỉ thị proxy_pass
proxy_pass là chỉ thị cốt lõi của Nginx khi đóng vai trò làm Reverse Proxy.

Chức năng: Chuyển tiếp (forward) toàn bộ yêu cầu (request) từ client đến địa chỉ ứng dụng phía sau (backend/upstream server) — ở đây là http://localhost:3000.

Cơ chế hoạt động: Khi người dùng gửi request tới cổng 80 của Nginx, Nginx đóng vai trò trung gian nhận request, tạo một request nội bộ tới cổng 3000 nơi React app đang chạy, sau đó nhận phản hồi từ React app và trả về lại cho client.


Lỗi HTTP Code khi React App ở port 3000 bị sập
Khi ứng dụng React ở port 3000 bị ngắt/sập, Nginx sẽ không thể kết nối hoặc không nhận được phản hồi từ backend.

Mã lỗi HTTP trả về: 502 Bad Gateway

Giải thích: Lỗi 502 Bad Gateway xuất hiện khi Nginx đóng vai trò là một Proxy/Gateway nhưng nhận được phản hồi không hợp lệ hoặc không thể kết nối tới server backend (upstream server localhost:3000). Nếu kết nối bị ngắt do phản hồi quá hạn (timeout), Nginx cũng có thể trả về lỗi 504 Gateway Timeout.