#!/usr/bin/env bash 

IS_DRY=0
if [[ "${2:-}" == "--dry" ]]; then
  IS_DRY=1
fi

if [[ -t 1 ]]; then
  RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'
  CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'
else
  RED=''; GREEN=''; YELLOW=''; CYAN=''; BOLD=''; RESET=''
fi

TAB="  "
NAMES=(); SRCS=(); TARGETS=();

link() {
  NAMES+=($1)
  SRCS+=($2)
  TARGETS+=($3)
}

create_links() {
  local new=0 skips=0 errs=0;

  if [[ $IS_DRY -eq 1 ]]; then
    echo -e "\n${BOLD}[DRY] Creating dotfiles symlinks...${RESET}"
  else
    echo -e "\n${BOLD}Creating dotfiles symlinks...${RESET}"
  fi

  for i in "${!NAMES[@]}"; do
    local name="${NAMES[$i]}" src="${SRCS[$i]}" target="${TARGETS[$i]}"

    if [[ ! -e "$src" ]]; then
      echo -e "${TAB}${RED}✖ ERROR${RESET}   [$name] source '$src' does not exist" >&2
      ((errs++));
      continue
    fi

    if [[ -e "$target" || -L "$target" ]]; then
      echo -e "${TAB}${YELLOW}~ SKIPPED${RESET} [$name] symlink '$target' already exists"
      ((skipped++))
      continue
    fi

    if [[ $IS_DRY -eq 0 ]]; then
      mkdir -p "$(dirname "$target")"
      ln -s "$src" "$target"
    fi
    echo -e "${TAB}${GREEN}✔ CREATED${RESET} [$name] '$src' -> '$target'"
    ((new++))
  done

  echo -e "\n${BOLD}Done.${RESET} created: ${GREEN}${new}${RESET}, skipped: ${YELLOW}${skips}${RESET}, errors: ${RED}${errs}${RESET}"
}

delete_links() {
  local deleted=0 skips=0 errs=0;

  if [[ $IS_DRY -eq 1 ]]; then
    echo -e "\n${BOLD}[DRY] Deleting dotfiles symlinks...${RESET}"
  else
    echo -e "\n${BOLD}Deleting dotfiles symlinks...${RESET}"
  fi

  for i in "${!NAMES[@]}"; do
    local name="${NAMES[$i]}" src="${SRCS[$i]}" target="${TARGETS[$i]}"

    if [[ ! -e "$src" ]]; then
      echo -e "${TAB}${RED}✖ ERROR${RESET}  [$name] target '$target' does not exist" >&2
      ((errs++)) 
      continue
    fi

    if [[ ! -e "$target" || ! -L "$target" ]]; then
      echo -e "${TAB}${YELLOW}~ SKIPPED${RESET} [$name] '$target' is not a symlink"
      ((skipped++)) 
      continue
    fi

    if [[ $IS_DRY -eq 0 ]]; then
      unlink "$target"
    fi
    ((deleted++))
    echo -e "${TAB}${GREEN}✔ REMOVED${RESET} [$name] '$src' -> '$target'"
  done

  echo -e "\n${BOLD}Done.${RESET} deleted: ${GREEN}${deleted}${RESET}, skipped: ${YELLOW}${skips}${RESET}, errors: ${RED}${errs}${RESET}"
}

links_status() {
  echo -e "\n${BOLD}dotfiles symlinks status:${RESET}"

  for i in "${!NAMES[@]}"; do
    local name="${NAMES[$i]}" src="${SRCS[$i]}" target="${TARGETS[$i]}"
 
    if [[ -L "$target" ]]; then
      local actual; actual="$(readlink "$target")"
      if [[ "$actual" == "$src" ]]; then
        echo -e "${TAB}${GREEN}✔ LINKED${RESET}   [$name] '$target' -> '$src'"
      else
        echo -e "${TAB}${YELLOW}~ MISMATCH${RESET} [$name] '$target' -> '$actual' (expected '$src')"
      fi
    elif [[ -e "$target" ]]; then
      echo -e "${TAB}${YELLOW}~ EXISTS${RESET}   [$name] '$target' is not a symlink"
    else
      echo -e "${TAB}${RED}✖ MISSING${RESET}  [$name] '$target'"
    fi
  done
}

show_help() {
  echo -e "
${BOLD}Usage:${RESET} $(basename "$0") <command> [--dry]

${BOLD}A dotfiles symlink manager.${RESET}

${BOLD}Commands:${RESET}
${TAB}${CYAN}setup${RESET}    Create all registered symlinks
${TAB}${CYAN}cleanup${RESET}  Remove all registered symlinks
${TAB}${CYAN}status${RESET}   Show the current state of all registered symlinks
${TAB}${CYAN}help${RESET}     Print help

${BOLD}Options:${RESET}
${TAB}${CYAN}--dry${RESET}    Print what would happen without making changes

${BOLD}Examples:${RESET}
${TAB}dotfiles setup
${TAB}dotfiles setup --dry
${TAB}dotifles cleanup --dry
${TAB}dotfiles status
"
}

run() {
  case "$1" in
    "setup")   create_links;;
    "cleanup") delete_links;;
    "status")  links_status;;
    "help"|"-h"|"--help"|*)    show_help;;
  esac
}
