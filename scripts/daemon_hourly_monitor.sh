#!/bin/bash
# Daemon: Hourly monitor for Conway Cloud Solvers with Telegram Notifications
LOG_FILE="/Users/antoniomachuca/Documents/Conway's 99-Graph Problem/cloud_monitoring.log"
TG_TOKEN="8946638886:AAHhgeJUL9Sk0P4hrzaAC4Oxf6CsJdcmgHY"
TG_CHAT_ID="8235898145"

send_telegram() {
    local MSG="$1"
    curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d parse_mode="Markdown" \
        --data-urlencode "text=${MSG}" >/dev/null 2>&1 &
}

poll_and_notify() {
    DATE_STR=$(date "+%Y-%m-%d %H:%M:%S")
    TIME_SHORT=$(date "+%H:%M")
    echo "[$DATE_STR] Polling Google Cloud VM (conway-sat-worker)..." >> "$LOG_FILE"
    
    # Query VM
    STATS=$(gcloud compute ssh conway-sat-worker --zone=us-central1-b --command="
        for b in a b c; do
            LOG=~/conway/cadical_branch_\${b}.log
            if [ -f \"\$LOG\" ]; then
                RES=\$(grep -E 's UNSATISFIABLE|s SATISFIABLE' \"\$LOG\" | tail -n 1)
                if [ -n \"\$RES\" ]; then
                    echo \"Rama \${b^^}: \$RES\"
                else
                    LAST=\$(grep -E '^[ciuvwWsFpt\-] ' \"\$LOG\" | tail -n 1)
                    CONF=\$(echo \"\$LAST\" | awk '{print \$9}')
                    VARS=\$(echo \"\$LAST\" | awk '{print \$NF}')
                    echo \"Rama \${b^^}: \${CONF:-0} conf (\${VARS:-N/A} vars)\"
                fi
            fi
        done
        df -h ~/conway | tail -n 1 | awk '{print \"Disco libre: \" \$4 \" de \" \$2}'
        free -h | grep Mem | awk '{print \"RAM libre: \" \$7 \" de \" \$2}'
    " 2>/dev/null)
    
    echo "$STATS" >> "$LOG_FILE"
    echo "----------------------------------------" >> "$LOG_FILE"
    
    # Extract metrics for Telegram
    A_INFO=$(echo "$STATS" | grep "^Rama A:")
    B_INFO=$(echo "$STATS" | grep "^Rama B:")
    C_INFO=$(echo "$STATS" | grep "^Rama C:")
    DISK_INFO=$(echo "$STATS" | grep "^Disco libre:")
    RAM_INFO=$(echo "$STATS" | grep "^RAM libre:")
    
    if echo "$STATS" | grep -q "s UNSATISFIABLE"; then
        # Desktop notification
        osascript -e "display notification \"$STATS\" with title \"¡HITO CONWAY 99: UNSATISFIABLE!\" sound name \"Glass\""
        # Urgent Telegram alert
        TG_MSG="🚨 *¡HITO CONWAY 99: RAMA UNSATISFIABLE!* 🚨

Una de las ramas en Google Cloud ha concluido con refutación formal (cláusula vacía derivada):

• \`${A_INFO}\`
• \`${B_INFO}\`
• \`${C_INFO}\`

Hora: \`${TIME_SHORT} CEST\`
La traza DRAT ya puede certificarse con \`drat-trim\`."
        send_telegram "$TG_MSG"

    elif echo "$STATS" | grep -q "s SATISFIABLE"; then
        # Desktop notification
        osascript -e "display notification \"$STATS\" with title \"¡GRAFO ENCONTRADO: SATISFIABLE!\" sound name \"Hero\""
        # Urgent Telegram alert
        TG_MSG="🏆 *¡HISTÓRICO: GRAFO DE CONWAY ENCONTRADO!* 🏆

¡Una de las ramas ha finalizado en *SATISFIABLE*!
Existe solución para el grafo con parámetros srg(99, 14, 1, 2).

• \`${A_INFO}\`
• \`${B_INFO}\`
• \`${C_INFO}\`

Hora: \`${TIME_SHORT} CEST\`"
        send_telegram "$TG_MSG"

    else
        # Normal Hourly update
        SUMMARY=$(echo "$STATS" | grep "^Rama" | tr '\n' ' | ' | sed 's/ | $//')
        osascript -e "display notification \"$SUMMARY\" with title \"Conway 99 Cloud Solvers\" subtitle \"Actualización horaria: $TIME_SHORT\" sound name \"Pop\""
        
        TG_MSG="📊 *Avance Conway 99 Cloud (${TIME_SHORT} CEST)*

• *${A_INFO}*
• *${B_INFO}*
• *${C_INFO}*

💾 \`${DISK_INFO}\`
🧠 \`${RAM_INFO}\`"
        send_telegram "$TG_MSG"
    fi
}

echo "=== Daemon Monitor started at $(date) ===" >> "$LOG_FILE"

# Initial check right now
poll_and_notify

# Loop every hour (3600 seconds)
while true; do
    sleep 3600
    poll_and_notify
done
