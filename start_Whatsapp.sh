#!/bin/bash

BASE_DIR=~/Repositories/whatsapp-pressTicket-New

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)
WHITE=$(tput setaf 5)
CYAN=$(tput setaf 6)
MAGENTA=$(tput setaf 13)

run_project() {
    local project_path=$1
    local command=$2
    local prefix=$3
    local color=$4

    (cd "$BASE_DIR/$project_path" && stdbuf -oL -eL $command 2>&1 | sed "s/^/${color}[$prefix] ${RESET}/") &
}

run_project "Whatsapp_Ativos/backend" "npm run dev:server" "Backend Whatsapp_Ativos" "$GREEN"
run_project "Whatsapp_Intacto/backend" "npm run dev:server" "Backend Whatsapp_Intacto" "$BLUE"
run_project "Whatsapp_Light/backend" "npm run dev:server" "Backend Whatsapp_Light" "$YELLOW"
run_project "Whatsapp_Omni/backend" "npm run dev:server" "Backend Whatsapp_Omni" "$WHITE"
run_project "Whatsapp_Unidas/backend" "npm run dev:server" "Backend Whatsapp_Unidas" "$CYAN"
#run_project "frontend" "npm start" "Frontend PressTicket" "$RED"

wait
