#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "?"')
CWD=$(echo "$input" | jq -r '.cwd // ""')

EMAIL=""
ORG=""
if [ -f "$HOME/.claude.json" ]; then
  EMAIL=$(jq -r '.oauthAccount.emailAddress // empty' "$HOME/.claude.json" 2>/dev/null)
  ORG=$(jq -r '.oauthAccount.organizationName // empty' "$HOME/.claude.json" 2>/dev/null)
fi

DIR_NAME=$(basename "$CWD")

BRANCH=""
if [ -n "$CWD" ] && [ -d "$CWD/.git" ] || git -C "$CWD" rev-parse --git-dir >/dev/null 2>&1; then
  BRANCH=$(git -C "$CWD" branch --show-current 2>/dev/null)
fi

PINK=$'\033[38;5;213m'
CYAN=$'\033[38;5;87m'
YELLOW=$'\033[38;5;229m'
GREEN=$'\033[38;5;120m'
MAGENTA=$'\033[38;5;219m'
GRAY=$'\033[38;5;245m'
RESET=$'\033[0m'

OUT=""
if [ -n "$EMAIL" ]; then
  OUT+="${PINK}${EMAIL}${RESET}"
fi
if [ -n "$ORG" ]; then
  OUT+=" ${GRAY}@${RESET} ${CYAN}${ORG}${RESET}"
fi
if [ -n "$DIR_NAME" ]; then
  OUT+="  ${YELLOW}${DIR_NAME}${RESET}"
fi
if [ -n "$BRANCH" ]; then
  OUT+="  ${GREEN}${BRANCH}${RESET}"
fi
OUT+="  ${MAGENTA}${MODEL}${RESET}"

printf '%s' "$OUT"
