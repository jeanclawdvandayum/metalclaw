# metalclaw 🤘

**OpenClaw enhancement pack for metalface — marketing, design, and Alchemix V3 content.**

## What's In Here

| Directory | Contents |
|-----------|----------|
| `skills/` | 24 skills — UI frameworks, design tools, visual explainers, document generators, workflow utilities |
| `reference/` | Alchemix V3 mechanics reference, Alchemypunk style guide, MYT overview |
| `scripts/` | One-shot install script |

## Install

```bash
# Clone this repo
git clone https://github.com/jeanclawdvandayum/metalclaw.git /tmp/metalclaw

# Run the installer (copies skills to both OpenClaw and Claude Code locations)
bash /tmp/metalclaw/scripts/install.sh
```

That's it. Your agent now has 24 skills covering:
- **10 UI design frameworks** (western, retro, folio, ascii-type, voxel-type, synth, specimen, graffiti, blueprint, monochrome)
- **Visual content creation** (slides, diagrams, explainers, LaTeX styling)
- **Document generation** (Word, PowerPoint, Excel)
- **V3 reference material** for technically accurate marketing content
- **Workflow tools** (kanban, brainstorming, prompt engineering)

## Skills List

### 🎨 UI Design Frameworks
| Skill | Aesthetic | Key Feature |
|-------|-----------|-------------|
| `western-ui` | Warm editorial, Fraunces font | Canvas/linen weave texture, WONK axis |
| `retro-ui` | Bebas Neue, strict 3-color | Zero border-radius, bold contrast |
| `folio-ui` | Playfair Display + DM Sans | Diagonal stripe dividers, grid cards |
| `ascii-type` | ASCII character fields | Bitmap font engine, glow compositing, CRT |
| `voxel-type` | Blocky voxel text | Bitmap font, isometric option |
| `synth-ui` | Synthwave/retrowave | Neon, grids, 80s aesthetic |
| `specimen-ui` | Type specimen sheets | Typography showcase layouts |
| `graffiti-ui` | Street art / urban | Bold, raw, expressive |
| `blueprint-ui` | Technical drawings | Grid paper, annotation style |
| `monochrome-ui` | Single-hue elegance | Minimal, sophisticated |

### 📊 Visual Content
| Skill | Use Case |
|-------|----------|
| `frontend-slides` | Zero-dep HTML presentations, 12 style presets |
| `visual-explainer` | Architecture diagrams, flowcharts, data tables |
| `latex-style` | Academic paper aesthetics for web |
| `ui-designer` | General UI/UX design patterns |

### 📄 Document Generation
| Skill | Format |
|-------|--------|
| `docx` | Word documents with formatting |
| `pptx` | PowerPoint presentations |
| `xlsx` | Excel spreadsheets |

### 🧠 Workflow & Thinking
| Skill | Purpose |
|-------|---------|
| `brainstorming` | Structured ideation before building |
| `chain-of-thought` | Reasoning framework for hard problems |
| `prompt-engineer` | Craft effective prompts |
| `kanban-ai` | Markdown-based task board |
| `article-extractor` | Clean article extraction from URLs |
| `skill-checker` | Audit and validate installed skills |

## V3 Reference

`reference/v3-mechanics.md` — Compact reference covering:
- Three independent forces (yield, redemptions, interest)
- Earmark/redeem lifecycle
- MYT (Meta Yield Token) basics
- Key framings for marketing content
- Common mistakes to avoid

`reference/alchemypunk.md` — Style guide:
- Copper palette, Gnostic framing
- Canon works and their purpose
- Design language and motifs

## Token Efficiency Notes

This pack is designed for API usage. Skills are loaded on-demand (only when matched). The V3 reference is a compact ~3KB summary — not the full audit history. No cron jobs, no memory system, no personal context.

## License

Skills are shared freely. Alchemix-specific content is for team use.
