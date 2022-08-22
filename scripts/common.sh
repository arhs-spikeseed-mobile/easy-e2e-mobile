#!/bin/bash
set -e

# Load .env file
set -a
source configs/.env
set +a

# Colors functions
YELLOW='\033[0;33m'
function yellow {
  printf "${YELLOW}$@${NC}\n"
}

export E2E_DIR=$(basename $E2E_SPECS_PATH)

rm -rf tmp/$E2E_DIR

mkdir -p tmp/

cp -R $E2E_SPECS_PATH tmp/$E2E_DIR/
