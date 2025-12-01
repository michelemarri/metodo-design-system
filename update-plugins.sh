#!/bin/bash

# ============================================
# Update Design System in Plugins
# ============================================
# Pull e ricompila il design system in tutti i plugin
# ============================================

set -e

# Colori
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Plugin da aggiornare
PLUGINS=(
    "/Users/michelemarri/Sites/menthorq/web/wp-content/plugins/media-toolkit"
    "/Users/michelemarri/Sites/menthorq/web/wp-content/plugins/schema-markup-generator"
)

echo ""
echo -e "${BLUE}🔄 Aggiornamento Design System nei plugin${NC}"
echo ""

for PLUGIN_DIR in "${PLUGINS[@]}"; do
    PLUGIN_NAME=$(basename "$PLUGIN_DIR")
    
    if [[ ! -d "$PLUGIN_DIR" ]]; then
        echo -e "${YELLOW}⚠${NC}  $PLUGIN_NAME - Directory non trovata"
        continue
    fi
    
    cd "$PLUGIN_DIR"
    
    echo -e "${YELLOW}→${NC} $PLUGIN_NAME"
    
    # Update + rebuild
    npm update metodo-design-system --silent 2>/dev/null
    npm run build:css --silent 2>/dev/null
    
    # Mostra dimensione file
    if [[ -f "assets/css/admin.css" ]]; then
        CSS_SIZE=$(du -h "assets/css/admin.css" | cut -f1)
        echo -e "  ${GREEN}✓${NC} Aggiornato e ricompilato ($CSS_SIZE)"
    fi
done

echo ""
echo -e "${GREEN}✓ Fatto!${NC}"
echo ""

