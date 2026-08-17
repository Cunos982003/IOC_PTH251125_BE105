#!/bin/bash

# 1. Khởi chạy container nginx với tên rikkei-frontend-qa và truyền biến môi trường API_ENDPOINT
docker run -d --name rikkei-frontend-qa -e API_ENDPOINT=https://qa-api.rikkei.edu.vn nginx

# 2. Truy cập vào shell của container và in biến môi trường ra màn hình
docker exec rikkei-frontend-qa sh -c 'echo $API_ENDPOINT'
