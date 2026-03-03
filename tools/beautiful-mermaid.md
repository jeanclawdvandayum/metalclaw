# beautiful-mermaid — ASCII/SVG Diagram Rendering

## Install
```bash
cd ~/your-workspace
npm install beautiful-mermaid tsx --save-dev
```

## What It Does
Renders Mermaid diagram syntax into ASCII/Unicode art (for chat/terminal) or SVG (for UI/web).

## Usage

### Quick render (CLI)
```bash
npx tsx -e "
import { renderMermaidASCII } from 'beautiful-mermaid';
const result = await renderMermaidASCII('graph LR; A --> B --> C');
console.log(result);
"
```

### In a script
```typescript
import { renderMermaidASCII } from 'beautiful-mermaid';

const diagram = `
graph LR
  A[Deposit] --> B[Borrow]
  B --> C[Yield]
  B --> D[Repay]
`;

const ascii = await renderMermaidASCII(diagram);
console.log(ascii);
```

### Supported diagram types
- Flowcharts (`graph LR` / `graph TD`)
- State diagrams
- Sequence diagrams
- Class diagrams
- ER diagrams

### Tips
- Use `LR` (left-right) layout for Discord/chat — `TD` (top-down) gets too tall
- Wrap output in ``` code blocks for monospace alignment
- ASCII output works great in Telegram, Discord, terminal
