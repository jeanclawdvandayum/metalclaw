# Paper Design Shaders — Canvas Visual Effects

## Install
```bash
npm install @paper-design/shaders @paper-design/shaders-react
```

## What
Zero-dependency canvas shaders. 23 visual effects you can drop into any web project.

## Available Shaders
`liquid-metal` · `mesh-gradient` · `neuro-noise` · `metaballs` · `voronoi` · `god-rays` · `waves` · `water` · `halftone` · `smoke-ring` · `spiral` · `warp` · `perlin-noise` · `paper-texture` · `dot-orbit` · `grain-gradient` · `fluted-glass` · `heatmap` · `swirl` · `pulsing-border` · `dithering` · `color-panels` · `dot-grid`

## Usage

### Vanilla JS (CDN)
```html
<canvas id="shader" width="800" height="600"></canvas>
<script type="module">
import { ShaderMount, liquidMetalFragmentShader } from 
  'https://esm.sh/@paper-design/shaders@0.0.42';

const canvas = document.getElementById('shader');
const mount = new ShaderMount(canvas, liquidMetalFragmentShader);
// Customize uniforms
mount.setUniform('u_color1', [0.42, 0.23, 0.13]);  // burnt copper
mount.setUniform('u_color2', [0.78, 0.52, 0.31]);  // warm copper
</script>
```

### React
```jsx
import { LiquidMetal } from '@paper-design/shaders-react';

function Hero() {
  return <LiquidMetal style={{ width: '100%', height: '400px' }} />;
}
```

### Vanilla JS (npm)
```javascript
import { ShaderMount, liquidMetalFragmentShader } from '@paper-design/shaders';

const canvas = document.querySelector('canvas');
const mount = new ShaderMount(canvas, liquidMetalFragmentShader);
```

## Best Shaders for Marketing
| Shader | Vibe | Good For |
|--------|------|----------|
| `liquid-metal` | Premium, metallic | Hero sections, brand pages |
| `mesh-gradient` | Soft, modern | Backgrounds, cards |
| `neuro-noise` | Organic, techy | Data visualizations |
| `voronoi` | Cellular, scientific | DeFi/protocol aesthetics |
| `grain-gradient` | Warm, editorial | Blog headers, portfolios |

## License
PolyForm Shield — free for non-competing use, link required.
