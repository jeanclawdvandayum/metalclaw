# monochrome — Accessible Headless UI Components (2.2kB)

By Colin van Eenige (@cvaneenige), Director of Design Engineering at Stream.

Use when building accessible interactive UI components (accordion, collapsible, tabs, menus) that need to work without a framework, or when you want minimal runtime overhead with full ARIA compliance. Ideal for static sites, server-rendered pages, Astro, or any project where shipping a UI framework to the client is overkill.

- **Site:** https://monochrome.sh
- **Repo:** https://github.com/vaneenige/monochrome-ui
- **Size:** 2.2kB gzipped
- **Tests:** 350 automated
- **Accessibility:** WCAG 2.2 AA, WAI-ARIA Authoring Practices
- **License:** MIT

---

## Architecture (Why It's Special)

monochrome uses the **DOM as its source of truth**. Instead of managing state in JavaScript, it reads ARIA attributes, responds to user interactions, and updates them directly.

**Key design decisions:**
- Minimal global event listeners handle every component via **event delegation**
- No per-component instances, state objects, or memory allocations
- Zero DOM queries — navigates through direct element pointers
- Adding more components costs **nothing at runtime** (1 component = 1000 components, same overhead)
- Components are inherently dynamic — anything added to the DOM works instantly
- Nothing to initialize, nothing to clean up

**The ID convention:** Components are identified by structured IDs:
- `mcr:component:name` — Root
- `mct:component:name` — Trigger
- `mcc:component:name` — Content

**Headless:** No CSS shipped. You provide all styles.

---

## Installation

```bash
npm install monochrome
```

### Vanilla HTML (no framework)
```html
<script src="https://unpkg.com/monochrome"></script>
```

### React
```tsx
// Import once at app entry point
import "monochrome"
// Then use React wrappers (they generate correct HTML + ARIA, interactivity from monochrome runtime)
import { Accordion, Collapsible, Menu, Tabs } from "monochrome/react"
```

---

## Components

### 1. Accordion

Grouped collapsible panels. Single or multiple open at a time.

**React:**
```tsx
import { Accordion } from "monochrome/react"

<Accordion.Root type="single">
  <Accordion.Item>
    <Accordion.Header>
      <Accordion.Trigger>What is monochrome?</Accordion.Trigger>
    </Accordion.Header>
    <Accordion.Panel>A minimal component library.</Accordion.Panel>
  </Accordion.Item>
  <Accordion.Item open>
    <Accordion.Header as="h4">
      <Accordion.Trigger>This starts open</Accordion.Trigger>
    </Accordion.Header>
    <Accordion.Panel>Visible by default.</Accordion.Panel>
  </Accordion.Item>
</Accordion.Root>
```

**Vanilla HTML:**
```html
<div id="mcr:accordion:faq" data-mode="single">
  <div>
    <h3>
      <button id="mct:accordion:q1" aria-expanded="false" aria-controls="mcc:accordion:q1">
        Question 1
      </button>
    </h3>
    <div id="mcc:accordion:q1" role="region" aria-labelledby="mct:accordion:q1" aria-hidden="true" hidden="until-found">
      Answer 1
    </div>
  </div>
</div>
```

**Props:**
| Component | Prop | Type | Default | Description |
|-----------|------|------|---------|-------------|
| Root | type | "single" \| "multiple" | "single" | One or multiple items open |
| Item | open | boolean | false | Expanded by default |
| Item | disabled | boolean | false | Cannot be toggled |
| Header | as | "h1"-"h6" | "h3" | Heading level |

**Keyboard:** Enter/Space toggle, Arrow Up/Down navigate, Home/End jump.

---

### 2. Collapsible

Single show/hide toggle. Trigger and content can be **disconnected** (live anywhere in the DOM).

**React:**
```tsx
import { Collapsible } from "monochrome/react"

// Standard (wrapped)
<Collapsible.Root open>
  <Collapsible.Trigger>Toggle details</Collapsible.Trigger>
  <Collapsible.Panel>Hidden content here.</Collapsible.Panel>
</Collapsible.Root>

// Disconnected (trigger and panel anywhere in the DOM)
<Collapsible.Trigger id="details">Toggle</Collapsible.Trigger>
{/* ...elsewhere... */}
<Collapsible.Panel id="details">Content lives here.</Collapsible.Panel>
```

**Vanilla HTML:**
```html
<button id="mct:collapsible:demo" aria-expanded="false" aria-controls="mcc:collapsible:demo">
  Toggle
</button>
<div id="mcc:collapsible:demo" aria-hidden="true" hidden="until-found">
  Content appears here.
</div>
```

**Props:**
| Component | Prop | Type | Default | Description |
|-----------|------|------|---------|-------------|
| Root | open | boolean | false | Expanded by default |
| Trigger | id | string | — | Connect to Panel without Root |
| Panel | id | string | — | Connect to Trigger without Root |

**Keyboard:** Enter/Space toggle.

---

### 3. Tabs

Layered panels, one visible at a time. Horizontal or vertical orientation.

**React:**
```tsx
import { Tabs } from "monochrome/react"

<Tabs.Root defaultValue="overview" orientation="horizontal">
  <Tabs.List>
    <Tabs.Tab value="overview">Overview</Tabs.Tab>
    <Tabs.Tab value="features">Features</Tabs.Tab>
    <Tabs.Tab value="api" disabled>API (Coming Soon)</Tabs.Tab>
  </Tabs.List>
  <Tabs.Panel value="overview">Overview content...</Tabs.Panel>
  <Tabs.Panel value="features">Features content...</Tabs.Panel>
  <Tabs.Panel value="api">API content...</Tabs.Panel>
</Tabs.Root>

{/* Vertical tabs */}
<Tabs.Root defaultValue="account" orientation="vertical">
  <Tabs.List>
    <Tabs.Tab value="account">Account</Tabs.Tab>
    <Tabs.Tab value="security">Security</Tabs.Tab>
  </Tabs.List>
  <Tabs.Panel value="account">Account settings...</Tabs.Panel>
  <Tabs.Panel value="security">Security options...</Tabs.Panel>
</Tabs.Root>
```

**Props:**
| Component | Prop | Type | Default | Description |
|-----------|------|------|---------|-------------|
| Root | defaultValue | string | first tab | Initially selected |
| Root | orientation | "horizontal" \| "vertical" | "horizontal" | Layout direction |
| Tab | value | string | required | Links trigger to panel |
| Tab | disabled | boolean | false | Cannot be selected |
| Panel | value | string | required | Links panel to trigger |
| Panel | focusable | boolean | true | Set false if panel has focusable children |

**Keyboard (horizontal):** Arrow Left/Right navigate, Home/End jump.
**Keyboard (vertical):** Arrow Up/Down navigate, Home/End jump.

---

### 4. Menu

Dropdown menus with submenus, checkbox/radio items, and menubar mode.

**React:**
```tsx
import { Menu } from "monochrome/react"

{/* Basic dropdown */}
<Menu.Root>
  <Menu.Trigger>Account</Menu.Trigger>
  <Menu.Popover>
    <Menu.Label>Settings</Menu.Label>
    <Menu.Item>Profile</Menu.Item>
    <Menu.Item>Preferences</Menu.Item>
    <Menu.Separator />
    <Menu.Item disabled>Delete Account</Menu.Item>
    <Menu.Item>Sign Out</Menu.Item>
  </Menu.Popover>
</Menu.Root>

{/* Checkbox + Radio items (menu stays open after toggle) */}
<Menu.Root>
  <Menu.Trigger>Format</Menu.Trigger>
  <Menu.Popover>
    <Menu.CheckboxItem checked>Bold</Menu.CheckboxItem>
    <Menu.CheckboxItem checked={false}>Italic</Menu.CheckboxItem>
    <Menu.Separator />
    <Menu.RadioItem checked>Small</Menu.RadioItem>
    <Menu.RadioItem checked={false}>Medium</Menu.RadioItem>
    <Menu.RadioItem checked={false}>Large</Menu.RadioItem>
  </Menu.Popover>
</Menu.Root>

{/* Menubar (horizontal application menu) */}
<Menu.Root menubar>
  <Menu.Popover>
    <Menu.Group>
      <Menu.Trigger>File</Menu.Trigger>
      <Menu.Popover>
        <Menu.Item>New File</Menu.Item>
        <Menu.Item>Save</Menu.Item>
      </Menu.Popover>
    </Menu.Group>
    <Menu.Group>
      <Menu.Trigger>Edit</Menu.Trigger>
      <Menu.Popover>
        <Menu.Item>Undo</Menu.Item>
        <Menu.Item>Redo</Menu.Item>
      </Menu.Popover>
    </Menu.Group>
  </Menu.Popover>
</Menu.Root>
```

**Required CSS for menus:**
```css
/* Popover visibility */
[popover]:popover-open {
  display: flex;
}

/* Menu positioning (monochrome sets --top, --right, --bottom, --left) */
[role="menu"] {
  position: fixed;
  top: var(--bottom);
  left: var(--left);
}

/* Submenu positioning */
[role="menu"] [role="menu"] {
  top: var(--top);
  left: var(--right);
}
```

**Props:**
| Component | Prop | Type | Default | Description |
|-----------|------|------|---------|-------------|
| Root | menubar | boolean | false | Horizontal menubar mode |
| Item | disabled | boolean | false | Cannot be activated |
| Item | href | string | — | Renders as link |
| CheckboxItem | checked | boolean | false | Toggle state |
| RadioItem | checked | boolean | false | Selection state |

**Keyboard:** Enter/Space activate, Arrow Up/Down navigate, Arrow Right opens submenu, Escape closes, a-z typeahead.

---

## Styling Guide

monochrome is completely headless. Style with whatever you want (Tailwind, vanilla CSS, CSS modules).

**ARIA attribute selectors** are your styling hooks:
```css
/* Expanded state */
[aria-expanded="true"] { /* trigger is open */ }
[aria-hidden="false"] { /* content is visible */ }

/* Selected tab */
[aria-selected="true"] { /* active tab */ }

/* Disabled state */
[aria-disabled="true"] { opacity: 0.5; cursor: not-allowed; }

/* Checked menu items */
[aria-checked="true"]::before { content: "✓"; }
```

**Transition animations:**
```css
/* Smooth accordion/collapsible open/close */
[aria-hidden="true"] {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
}

[aria-hidden="false"] {
  max-height: 500px;
  transition: max-height 0.3s ease-in;
}
```

---

## Browser Support

Requires:
- [Popover API](https://caniuse.com/mdn-api_htmlelement_showpopover) (menus)
- [`hidden="until-found"`](https://caniuse.com/mdn-html_global_attributes_hidden_until-found_value) (find-in-page for hidden content)

Both are Baseline 2024 — all modern browsers supported.

---

## When to Use monochrome vs Alternatives

| Scenario | Use | Why |
|----------|-----|-----|
| Static site, no framework | **monochrome** | 2.2kB, no runtime needed |
| Astro, server-rendered | **monochrome** | HTML-first, works without hydration |
| React SPA with complex state | **Base UI** or **React Aria** | Better framework integration |
| Need 20+ component types | **Radix** or **shadcn/ui** | monochrome only has 4 components |
| Performance-critical, many instances | **monochrome** | O(1) overhead regardless of count |
| Minimal bundle budget | **monochrome** | 2.2kB vs 20-50kB for alternatives |

---

## Key Insight

> "Performance isn't a feature, it's a consequence of the architecture. When you don't have per-component state, per-component listeners, or a rendering framework, there's nothing left to be slow."
> — Colin van Eenige
