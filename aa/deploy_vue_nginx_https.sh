#!/bin/bash

# === 参数 ===
DEPLOY_PATH=${1:-"/project"}
BUILD_DIR=${2:-"/home/project/dist"}
SERVER_NAME=${3:-"your.domain.com"}

NGINX_CONF="/etc/nginx/sites-available/default"
BACKUP_DIR="/etc/nginx/backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# === 证书路径（请按需替换）===
SSL_CERT="/etc/letsencrypt/live/$SERVER_NAME/fullchain.pem"
SSL_KEY="/etc/letsencrypt/live/$SERVER_NAME/privkey.pem"

# === 检查构建目录 ===
if [ ! -d "$BUILD_DIR" ]; then
  echo "❌ 构建目录不存在: $BUILD_DIR"
  exit 1
fi

# === 备份配置文件 ===
sudo mkdir -p $BACKUP_DIR
if [ -f "$NGINX_CONF" ]; then
  sudo cp $NGINX_CONF $BACKUP_DIR/default.backup.$TIMESTAMP
  echo "🗂 配置备份已保存: $BACKUP_DIR/default.backup.$TIMESTAMP"
fi

echo "📦 构建目录: $BUILD_DIR"
echo "🌐 路由路径: $DEPLOY_PATH"
echo "🔐 HTTPS 证书: $SSL_CERT"
echo "🖥 域名/IP: $SERVER_NAME"

# === 写入 nginx 配置（含 HTTPS）===
sudo tee $NGINX_CONF > /dev/null <<EOF
server {
    listen 80;
    server_name $SERVER_NAME;
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name $SERVER_NAME;

    ssl_certificate     $SSL_CERT;
    ssl_certificate_key $SSL_KEY;

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

    location /api/ {
        proxy_pass http://localhost:8080/;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

# === 启用配置文件 ===
if [ ! -L /etc/nginx/sites-enabled/default ]; then
  sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
fi

# === 测试并重启 Nginx ===
sudo nginx -t && sudo systemctl restart nginx

echo "✅ 部署完成：https://$SERVER_NAME$DEPLOY_PATH/"
