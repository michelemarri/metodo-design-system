#!/bin/bash

# ============================================
# Metodo Design System - Deploy Script
# ============================================
# Questo script:
# 1. Committa e pusha le modifiche del design system
# 2. Aggiorna i plugin che lo usano
# 3. Ricompila il CSS in ogni plugin
# ============================================

set -e  # Exit on error

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Percorsi dei plugin
PLUGINS=(
    "/Users/michelemarri/Sites/menthorq/web/wp-content/plugins/media-toolkit"
    "/Users/michelemarri/Sites/menthorq/web/wp-content/plugins/schema-markup-generator"
)

# Funzioni helper
print_header() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_step() {
    echo -e "${YELLOW}→${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Directory del design system
DS_DIR="$(cd "$(dirname "$0")" && pwd)"

# ============================================
# STEP 1: Design System - Commit & Push
# ============================================
print_header "📦 Design System - Commit & Push"

cd "$DS_DIR"

# Verifica se ci sono modifiche
if [[ -z $(git status --porcelain) ]]; then
    print_step "Nessuna modifica da committare"
else
    # Mostra le modifiche
    print_step "Modifiche rilevate:"
    git status --short
    echo ""
    
    # Chiedi messaggio commit (o usa default)
    read -p "Messaggio commit (invio per 'Update design system'): " COMMIT_MSG
    COMMIT_MSG=${COMMIT_MSG:-"Update design system"}
    
    # Commit
    print_step "Commit delle modifiche..."
    git add -A
    git commit -m "$COMMIT_MSG"
    print_success "Commit completato"
fi

# Push
print_step "Push su GitHub..."
git push origin main
print_success "Push completato"

# ============================================
# STEP 2: Aggiorna e ricompila ogni plugin
# ============================================
for PLUGIN_DIR in "${PLUGINS[@]}"; do
    PLUGIN_NAME=$(basename "$PLUGIN_DIR")
    
    print_header "🔄 Aggiornamento: $PLUGIN_NAME"
    
    if [[ ! -d "$PLUGIN_DIR" ]]; then
        print_error "Directory non trovata: $PLUGIN_DIR"
        continue
    fi
    
    cd "$PLUGIN_DIR"
    
    # Verifica se node_modules esiste
    if [[ ! -d "node_modules" ]]; then
        print_step "Installazione dipendenze..."
        npm install
    fi
    
    # Aggiorna il design system
    print_step "Aggiornamento metodo-design-system..."
    npm update metodo-design-system
    print_success "Design system aggiornato"
    
    # Ricompila CSS
    print_step "Ricompilazione CSS..."
    npm run build:css
    print_success "CSS ricompilato"
    
    # Mostra file aggiornato
    if [[ -f "assets/css/admin.css" ]]; then
        CSS_SIZE=$(du -h "assets/css/admin.css" | cut -f1)
        print_success "Output: assets/css/admin.css ($CSS_SIZE)"
    fi
done

# ============================================
# COMPLETATO
# ============================================
print_header "✅ Deploy completato!"

echo ""
echo -e "Design system deployato e aggiornato in:"
for PLUGIN_DIR in "${PLUGINS[@]}"; do
    PLUGIN_NAME=$(basename "$PLUGIN_DIR")
    echo -e "  ${GREEN}•${NC} $PLUGIN_NAME"
done
echo ""

