#!/bin/bash
# Auto-stop local CaDiCaL solver on Sunday Sep 13, 2026 at 22:00 CEST
# Safely flushes CaDiCaL, offloads DRAT trace to external drive, and alerts via Telegram

BASE_DIR="/Users/antoniomachuca/Documents/Conway's 99-Graph Problem"
LOG_FILE="$BASE_DIR/auto_stop_sunday.log"
EXT_DIR="/Volumes/Untitled/conway_drat_archives"
TARGET_EPOCH=1789329600 # 2026-09-13 22:00:00 CEST
TG_TOKEN="8946638886:AAHhgeJUL9Sk0P4hrzaAC4Oxf6CsJdcmgHY"
TG_CHAT_ID="8235898145"

send_telegram() {
    local MSG="$1"
    curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d parse_mode="Markdown" \
        --data-urlencode "text=${MSG}" >/dev/null 2>&1
}

echo "[$(date '+%Y-%m-%d %H:%M:%S')] auto_stop_sunday supervisor started. Target: $(date -r $TARGET_EPOCH)" >> "$LOG_FILE"

while true; do
    NOW=$(date +%s)
    if [ "$NOW" -ge "$TARGET_EPOCH" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Reached deadline Sunday 22:00 CEST ($NOW >= $TARGET_EPOCH). Executing stop procedure..." >> "$LOG_FILE"
        break
    fi
    # Sleep 30 seconds between checks
    sleep 30
done

# Step 1: Locate local CaDiCaL process
LOCAL_PIDS=$(pgrep -f "cadical conway_z2_f1.cnf" | tr '\n' ' ')

if [ -n "$LOCAL_PIDS" ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Found running local CaDiCaL process(es): $LOCAL_PIDS. Sending SIGINT for clean statistics flush..." >> "$LOG_FILE"
    for pid in $LOCAL_PIDS; do
        kill -INT "$pid" 2>/dev/null
    done
    
    sleep 5
    
    # Check if still running
    REMAINING=$(pgrep -f "cadical conway_z2_f1.cnf")
    if [ -n "$REMAINING" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Solver still active. Sending SIGTERM..." >> "$LOG_FILE"
        for pid in $REMAINING; do
            kill -TERM "$pid" 2>/dev/null
        done
        sleep 3
    fi
    STOP_MSG="✅ CaDiCaL local detenido limpiamente."
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] No local CaDiCaL process running (already terminated)." >> "$LOG_FILE"
    STOP_MSG="ℹ️ El solver local ya había finalizado previamente."
fi

# Step 2: Offload local DRAT file to external storage if mounted
DRAT_FILE="$BASE_DIR/proof_z2_f1.resume-1.drat"
DRAT_STATUS="No se encontró traza local activa."

if [ -f "$DRAT_FILE" ]; then
    DRAT_SIZE=$(ls -lh "$DRAT_FILE" | awk '{print $5}')
    if [ -d "$EXT_DIR" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Moving $DRAT_FILE ($DRAT_SIZE) to $EXT_DIR..." >> "$LOG_FILE"
        mv "$DRAT_FILE" "$EXT_DIR/"
        DRAT_STATUS="Traza DRAT ($DRAT_SIZE) movida al disco externo (/Volumes/Untitled). SSD del Mac liberado."
    else
        DRAT_STATUS="Traza DRAT ($DRAT_SIZE) conservada en local (disco externo no montado)."
    fi
fi

# Step 3: Desktop Notification
osascript -e 'display notification "Solver local detenido y archivado para las clases del lunes. Google Cloud sigue activo 24/7." with title "Conway 99: Fin Solver Local" sound name "Glass"' 2>/dev/null

# Step 4: Telegram Alert
TG_ALERT="🛑 *[Conway 99] Solver Local Detenido (Domingo 22:00 CEST)* 🛑

$STOP_MSG
• $DRAT_STATUS

🎒 *Tu Mac queda completamente libre y listo para tus clases del lunes.*
☁️ *Google Cloud VM sigue resolviendo las Ramas A, B y C de forma ininterrumpida.*"

send_telegram "$TG_ALERT"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completion alert sent to Telegram. Task finished successfully." >> "$LOG_FILE"
