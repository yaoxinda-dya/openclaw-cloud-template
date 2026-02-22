#!/bin/bash
echo "馃敡 璁剧疆 OpenClaw Cloud 鐜..."
echo "========================================"

# 璁剧疆鐜鍙橀噺
export NODE_OPTIONS="--max-old-space-size=2048"

# 瀹夎 OpenClaw
echo "瀹夎 OpenClaw..."
if ! command -v openclaw-cn &> /dev/null; then
    npm install -g openclaw-cn
    echo "鉁?OpenClaw 瀹夎瀹屾垚"
else
    echo "鉁?OpenClaw 宸插畨瑁?
fi

# 鍒涘缓鐩綍缁撴瀯
echo "鍒涘缓鐩綍..."
mkdir -p ~/.openclaw
mkdir -p /workspaces/$(basename $(pwd))/workspace
mkdir -p /workspaces/$(basename $(pwd))/memory
mkdir -p /workspaces/$(basename $(pwd))/config

# 鍒涘缓绗﹀彿閾炬帴锛堟暟鎹寔涔呭寲锛?echo "璁剧疆鏁版嵁鎸佷箙鍖?.."
ln -sf /workspaces/$(basename $(pwd))/workspace ~/.openclaw/workspace 2>/dev/null || true
ln -sf /workspaces/$(basename $(pwd))/memory ~/.openclaw/memory 2>/dev/null || true

# 妫€鏌ラ厤缃枃浠?if [ -f /workspaces/$(basename $(pwd))/config/openclaw.json ]; then
    cp /workspaces/$(basename $(pwd))/config/openclaw.json ~/.openclaw/
    echo "鉁?浣跨敤鐜版湁閰嶇疆"
else
    echo "鈿狅笍  浣跨敤榛樿閰嶇疆"
fi

echo "========================================"
echo "鉁?鐜璁剧疆瀹屾垚锛?
echo "涓嬩竴姝ワ細鑷姩鍚姩 OpenClaw 鏈嶅姟"
echo "========================================"