export PATH=$PATH:$HOME/.local/bin

# === Go ===
export CGO_CFLAGS_ALLOW="-Xpreprocessor"
# ==========

# === Android ===
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
# ===============

# === pnpm ===
export PNPM_HOME="/Users/yet3/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# ============

# === Tmux ===
export TMUX_DIR="$HOME/.config/tmux"
export TMUX_SESSIONS_DIR="$TMUX_DIR/sessions"
# ============

# === Neovim ===
export PATH="$HOME/.local/share/bob/nvim-bin":$PATH
# ==============

# ==============
export PATH="/Users/yet3/.bun/bin:$PATH"
# ==============
