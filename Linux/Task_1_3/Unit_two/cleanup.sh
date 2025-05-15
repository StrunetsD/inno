#!/bin/bash

OVERLOAD_LOG="/var/log/overload"
CLEANUP_LOG="/var/log/cleanup"
MAX_SIZE_KB=50  

while true; do
    if [ -f "$OVERLOAD_LOG" ]; then
        size_kb=$(du -k "$OVERLOAD_LOG" | cut -f1)
        
        if [ "$size_kb" -ge "$MAX_SIZE_KB" ]; then
            > "$OVERLOAD_LOG"

            echo "[$(date +'%F %T')] Очищен файл $OVERLOAD_LOG (размер: ${size_kb}KB)" >> "$CLEANUP_LOG"
        fi
    fi
    
    sleep 30
done