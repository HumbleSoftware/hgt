# Shared bats helpers. Tests are black-box: they only touch $HGT_BIN, the filesystem, and
# the PATH-shimmed external commands — never hgt's internals. So this suite is agnostic to
# how hgt is implemented (bash today; could be anything).

HGT_REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HGT_BIN="$HGT_REPO/hgt"

setup() {
  TMP="$(mktemp -d)"
  SHIM_LOG="$TMP/shim.log"
  : >"$SHIM_LOG"
  export SHIM_LOG
  # hgt makes the jail's proxy bridge dir under XDG_RUNTIME_DIR: keep it off the developer's box.
  export XDG_RUNTIME_DIR="$TMP/run"
  mkdir -p "$XDG_RUNTIME_DIR"
  export PATH="$HGT_REPO/test/shims:$PATH"
  cd "$TMP"
}

teardown() {
  cd /
  rm -rf "$TMP"
}
