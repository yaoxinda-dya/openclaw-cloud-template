#!/bin/bash
echo "馃殌 鍚姩 OpenClaw Cloud..."
echo "========================================"

# 鍋滄鍙兘杩愯鐨勬湇鍔?echo "娓呯悊鐜版湁杩涚▼..."
pkill -f "openclaw-cn gateway" 2>/dev/null || true
sleep 1

# 鐢熸垚閰嶇疆锛堝鏋滀笉瀛樺湪锛?if [ ! -f ~/.openclaw/openclaw.json ]; then
    echo "鐢熸垚榛樿閰嶇疆..."
    RANDOM_TOKEN=$(openssl rand -hex 24)
    cat > ~/.openclaw/openclaw.json << EOF
{
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "0.0.0.0",
    "auth": {
      "mode": "token",
      "token": "${RANDOM_TOKEN}"
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "deepseek/deepseek-chat"
      },
      "workspace": "/workspaces/$(basename $(pwd))/workspace"
    }
  }
}
EOF
    echo "鉁?閰嶇疆宸茬敓鎴?
fi

# 鍚姩鏈嶅姟
echo "鍚姩 OpenClaw 缃戝叧..."
openclaw-cn gateway --port 18789 --bind 0.0.0.0 > ~/.openclaw/gateway.log 2>&1 &

# 绛夊緟鍚姩
echo "绛夊緟鏈嶅姟鍚姩..."
for i in {1..10}; do
    if curl -s http://localhost:18789 > /dev/null 2>&1; then
        echo "鉁?鏈嶅姟鍚姩鎴愬姛锛?
        break
    fi
    echo -n "."
    sleep 2
done

# 鏄剧ず璁块棶淇℃伅
echo ""
echo "========================================"
echo "馃帀 OPENCLAW CLOUD 宸插氨缁紒"
echo "========================================"

# 鑾峰彇璁块棶鍦板潃
if [ -n "${CODESPACE_NAME}" ]; then
    ACCESS_URL="https://${CODESPACE_NAME}-18789.app.github.dev"
else
    ACCESS_URL="https://$(hostname)-18789.app.github.dev"
fi

# 鑾峰彇Token
TOKEN=$(grep -o '"token": "[^"]*"' ~/.openclaw/openclaw.json | head -1 | cut -d'"' -f4)

echo "馃寪 璁块棶鍦板潃: ${ACCESS_URL}"
echo "馃攽 璁よ瘉Token: ${TOKEN}"
echo ""
echo "馃搵 浣跨敤璇存槑锛?
echo "1. 澶嶅埗涓婃柟璁块棶鍦板潃鍒版祻瑙堝櫒"
echo "2. 杈撳叆Token杩涜璁よ瘉"
echo "3. 寮€濮嬩娇鐢?OpenClaw Cloud"
echo ""
echo "馃挕 鎻愮ず锛?
echo "- 姣忔湀鍏嶈垂60灏忔椂锛屼笉鐢ㄦ椂璇峰仠姝odespace"
echo "- 閲嶈鏁版嵁璇峰強鏃?git commit 淇濆瓨"
echo "- 鍋滄鏈嶅姟锛氬叧闂祻瑙堝櫒鏍囩椤垫垨鍋滄Codespace"
echo "========================================"

# 鏄剧ず绯荤粺鐘舵€?echo ""
echo "馃搳 绯荤粺鐘舵€侊細"
echo "鍐呭瓨浣跨敤: $(free -h | grep Mem | awk '{print $3"/"$2}')"
echo "纾佺洏浣跨敤: $(df -h / | tail -1 | awk '{print $3"/"$2}')"
echo "鏈嶅姟杩愯: $(ps aux | grep -c '[o]penclaw-cn') 涓繘绋?
echo "========================================"

# 淇濇寔鑴氭湰杩愯锛堢洃鍚湇鍔＄姸鎬侊級
echo "鐩戞帶鏈嶅姟鐘舵€佷腑..."
echo "鎸?Ctrl+C 鍋滄鏈嶅姟"
echo "========================================"

while true; do
    if ! curl -s http://localhost:18789 > /dev/null 2>&1; then
        echo "鈿狅笍  鏈嶅姟寮傚父锛屽皾璇曢噸鍚?.."
        pkill -f "openclaw-cn gateway" 2>/dev/null
        sleep 2
        openclaw-cn gateway --port 18789 --bind 0.0.0.0 > ~/.openclaw/gateway.log 2>&1 &
        sleep 5
    fi
    sleep 30
done