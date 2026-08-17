#!/bin/bash

# Thêm sudo vào các lệnh docker
sudo docker run -d --name rikkei-course-service -p 8081:80 nginxdemos/hello

sudo docker ps

curl http://localhost:8081
