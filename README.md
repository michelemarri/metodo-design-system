# Metodo Design System

A shared design system for WordPress plugins developed by Metodo.

## Installation

### From GitHub (recommended)

```bash
npm install github:michelemarri/metodo-design-system
```

Or in `package.json`:

```json
{
  "dependencies": {
    "metodo-design-system": "github:michelemarri/metodo-design-system#main"
  }
}
```

### Local development with npm link

```bash
# In this directory
npm link

# In your plugin directory
npm link metodo-design-system
```

## Usage

### Import in your CSS

```css
/* Import the full design system */
@import 'metodo-design-system/src/index.css';

/* Or import individual components */
@import 'metodo-design-system/src/components/tokens.css';
@import 'metodo-design-system/src/components/buttons.css';
```

### Using with PostCSS

Add the design system path to your `postcss.config.js`:

```javascript
module.exports = {
  plugins: [
    require('postcss-import')({
      path: [
        'node_modules/metodo-design-system/src'
      ]
    }),
    // ... other plugins
  ]
};
```

## CSS Class Prefix

All classes use the `.mds-` prefix (metodo-design-system).

## Available Components

| Component | Description |
|-----------|-------------|
| `tokens.css` | CSS custom properties (colors, spacing, typography, etc.) |
| `base.css` | Base styles and resets for WordPress admin |
| `layout.css` | Layout utilities and containers |
| `navigation.css` | Tab navigation components |
| `cards.css` | Card components |
| `forms.css` | Form elements (inputs, selects, textareas) |
| `buttons.css` | Button styles and variants |
| `toggle.css` | Toggle switch component |
| `badges.css` | Badges and tags |
| `tables.css` | Table styles |
| `alerts.css` | Alert and notice components |
| `utilities.css` | Utility classes |
| `animations.css` | Animations and keyframes |
| `responsive.css` | Responsive breakpoints |

## Design Tokens

All design tokens use the `--mds-` prefix:

```css
/* Colors */
--mds-primary
--mds-success
--mds-warning
--mds-error

/* Spacing */
--mds-space-1 through --mds-space-12

/* Typography */
--mds-font-sans
--mds-font-mono
--mds-text-xs through --mds-text-3xl

/* Border Radius */
--mds-radius-sm through --mds-radius-full

/* Shadows */
--mds-shadow-xs through --mds-shadow-xl

/* Transitions */
--mds-transition-fast
--mds-transition
--mds-transition-slow
```

## Building

```bash
# Install dependencies
npm install

# Build for production
npm run build

# Watch for changes
npm run dev
```

## Wrapper Class

Wrap your plugin's admin content with `.mds-wrap` to apply the design system styles:

```html
<div class="mds-wrap">
  <!-- Your content here -->
</div>
```

## License

GPL-3.0 - See [LICENSE](LICENSE) for details.
