#!/bin/bash
# scripts/cloud_watcher.sh
# Autonomous supervisor for Conway 99 Cloud Solvers on GCP VM
# Detects branch completion in real-time, executes drat-trim on VM, notifies Telegram,
# and automatically powers off the VM upon full completion to eliminate credit costs.

TG_TOKEN="8946638886:AAHhgeJUL9Sk0P4hrzaAC4Oxf6CsJdcmgHY"
TG_CHAT_ID="8235898145"

send_telegram() {
    local MSG="$1"
    curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d parse_mode="Markdown" \
        --data-urlencode "text=${MSG}" >/dev/null 2>&1
}

cd ~/conway || exit 1
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cloud Watcher started in ~/conway"

while true; do
    for b in a b c; do
        LOG="cadical_branch_${b}.log"
        CNF="conway_z2_f1_branch_${b}.cnf"
        DRAT="proof_z2_f1_branch_${b}.drat"
        TRIM_LOG="drat_trim_branch_${b}.log"
        RES_FILE="branch_${b}_result.txt"
        
        if [ -f "$LOG" ] && [ ! -f "$RES_FILE" ]; then
            # Check for UNSAT
            if grep -q "s UNSATISFIABLE" "$LOG"; then
                echo "s UNSATISFIABLE" > "$RES_FILE"
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] Rama ${b^^} UNSATISFIABLE!"
                send_telegram "🚨 *GCP VM: Rama ${b^^} UNSATISFIABLE!* 🚨
CaDiCaL ha derivado la cláusula vacía en la Rama ${b^^}.
Iniciando verificación formal inmediata con \`drat-trim\` en la VM..."
                
                # Run drat-trim on VM
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] Running drat-trim for branch ${b^^}..."
                /usr/local/bin/drat-trim "$CNF" "$DRAT" > "$TRIM_LOG" 2>&1
                
                if grep -q "s VERIFIED" "$TRIM_LOG"; then
                    echo "VERIFIED" >> "$RES_FILE"
                    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Rama ${b^^} drat-trim: s VERIFIED"
                    send_telegram "✅ *GCP VM: Rama ${b^^} VERIFICADA (s VERIFIED)* ✅
La prueba DRAT de la Rama ${b^^} ha sido certificada formalmente con \`drat-trim\` sin errores.
Estado: *PROBADO*."
                else
                    echo "VERIFY_FAILED" >> "$RES_FILE"
                    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Rama ${b^^} drat-trim FAILED"
                    send_telegram "⚠️ *GCP VM: Alerta drat-trim Rama ${b^^}*
La prueba no devolvió s VERIFIED. Revisar log \`$TRIM_LOG\`."
                fi
                
            # Check for SAT
            elif grep -q "s SATISFIABLE" "$LOG"; then
                echo "s SATISFIABLE" > "$RES_FILE"
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] Rama ${b^^} SATISFIABLE!"
                send_telegram "🏆 *GCP VM: ¡¡RAMA ${b^^} SATISFIABLE!!* 🏆
¡CaDiCaL ha encontrado una asignación satisfacible!
Extrayendo modelo para verificación estructural de Conway-99..."
                grep "^v " "$LOG" > "sat_solution_${b}.txt"
                sync
                send_telegram "🔒 *Consumo GCP Congelado:* Modelo guardado en disco. Apagando máquina virtual automáticamente para detener facturación."
                sleep 20
                sudo poweroff
                exit 0
            fi
        fi
    done
    
    # Check if all 3 branches verified UNSAT
    if [ -f "branch_a_result.txt" ] && [ -f "branch_b_result.txt" ] && [ -f "branch_c_result.txt" ]; then
        if grep -q "VERIFIED" "branch_a_result.txt" && grep -q "VERIFIED" "branch_b_result.txt" && grep -q "VERIFIED" "branch_c_result.txt"; then
            if [ ! -f "ALL_Z2_F1_REFUTED.done" ]; then
                touch "ALL_Z2_F1_REFUTED.done"
                send_telegram "🎉 *HITO CIENTÍFICO HISTÓRICO: Z_2 (f=1) TOTALMENTE REFUTADO* 🎉
Las 3 ramas canónicas de ruptura de simetría (Gemela, Secante, Disjunta) han sido refutadas y formalmente certificadas con \`drat-trim\` (s VERIFIED).
Con ello, el caso central f=1 queda matemáticamente cerrado [PROBADO]."
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALL 3 BRANCHES VERIFIED UNSAT! Done."
                sync
                send_telegram "🔒 *Consumo GCP Congelado:* Las 3 ramas han concluido y están verificadas. Apagando la máquina virtual automáticamente (\`sudo poweroff\`) para detener el gasto de créditos. Los certificados y logs quedan preservados en el SSD."
                sleep 20
                sudo poweroff
                exit 0
            fi
        fi
    fi
    
    sleep 15
done
