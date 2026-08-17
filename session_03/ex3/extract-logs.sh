#!/bin/bash

# Lấy 15 dòng log cuối cùng (--tail 15) kèm mốc thời gian (--timestamps) của container
docker logs --tail 15 --timestamps rikkei-course-service
