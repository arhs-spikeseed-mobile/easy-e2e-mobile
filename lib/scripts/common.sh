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

export E2E_DIR=$E2E_SPECS_PATH

# Install deps
yarn

if [ "$1" == "--run" ]; then
  # Generate tsconfig.json
  npx tsconfig.js --once

  # Compile e2e tests
  npx tsc || true
fi
