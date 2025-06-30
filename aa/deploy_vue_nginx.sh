#!/bin/bash

ENV=$1
if [ -z "$ENV" ]; then
  echo "❗ 请输入环境名称，例如: ./deploy_vue_nginx.sh prod"
  exit 1
fi

ENV_FILE=".env.deploy.$ENV"
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ 配置文件 $ENV_FILE 不存在"
  exit 1
fi

source $ENV_FILE

if [ -z "$DEPLOY_PATH" ] || [ -z "$BUILD_DIR" ] || [ -z "$SERVER_NAME" ]; then
  echo "❌ 缺少 DEPLOY_PATH、BUILD_DIR、SERVER_NAME 变量"
  exit 1
fi

NGINX_CONF="/etc/nginx/sites-available/default"

echo "📦 构建目录: $BUILD_DIR"
echo "🌐 路由路径: $DEPLOY_PATH"
echo "🖥 服务器域名: $SERVER_NAME"

if [ ! -d "$BUILD_DIR" ]; then
  echo "❌ 构建目录不存在: $BUILD_DIR"
  exit 1
fi

# 默认后端路径和目标
API_PROXY_PATH=${API_PROXY_PATH:-/api/}
API_PROXY_TARGET=${API_PROXY_TARGET:-http://localhost:8080/}
API_EXTRA_HEADERS=${API_EXTRA_HEADERS:-"
proxy_set_header Host \$host;
proxy_set_header X-Real-IP \$remote_addr;
"}

sudo tee $NGINX_CONF > /dev/null <<EOF
server {
    listen 80;
    server_name $SERVER_NAME;

    location = / {
        return 302 $DEPLOY_PATH/;
    }

    location = $DEPLOY_PATH {
        return 301 $DEPLOY_PATH/;
    }

    location $DEPLOY_PATH/ {
        alias $BUILD_DIR/;
        index index.html;
        try_files \$uri \$uri/ /index.html;
    }

    location $API_PROXY_PATH {
        proxy_pass $API_PROXY_TARGET;
        $API_EXTRA_HEADERS
    }
}
EOF

if [ ! -L /etc/nginx/sites-enabled/default ]; then
  sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
fi

sudo nginx -t && sudo systemctl restart nginx

echo "✅ [$ENV] 部署完成：http://$SERVER_NAME$DEPLOY_PATH/"
