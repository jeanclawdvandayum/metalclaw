# metalclaw 🤘

**OpenClaw enhancement pack — 31 skills, knowledge graph memory system, tools, and behavioral upgrades.**

## What's In Here

| Directory | Contents |
|-----------|----------|
| `skills/` | 31 skills — UI frameworks, design tools, visual content, documents, dev languages, workflow |
| `system/` | Memory system — knowledge graph, meta-learning files, vault commands, behavioral patterns |
| `tools/` | Tool guides + scripts — scrapling, mermaid, whisper, shaders, here.now, prompt injection scanner |
| `reference/` | Alchemix V3 mechanics reference |
| `scripts/` | Install scripts |

## Install

```bash
# Clone
git clone https://github.com/jeanclawdvandayum/metalclaw.git /tmp/metalclaw

# Install from your workspace directory
cd ~/your-workspace
bash /tmp/metalclaw/scripts/install.sh
```

The installer:
- Copies 31 skills to `~/.openclaw/skills/` and `~/.claude/skills/`
- Drops memory system files into your workspace (won't overwrite existing files)
- Creates `memory/topics/` directory structure
- Copies tool guides + prompt injection scanner

### Optional Tool Installs
```bash
bash /tmp/metalclaw/scripts/install-scrapling.sh   # Stealth web scraper
brew install whisper-cpp                            # Local speech-to-text
npm install beautiful-mermaid tsx                    # ASCII/SVG diagrams
npm install @paper-design/shaders                   # 23 canvas shaders
```

## Memory System

Gives your agent persistent context across sessions through files it reads on startup.

### Architecture
```
AGENTS.md (read every session — startup protocol + behavioral rules)
    ↓
memory/_index.md (knowledge graph index, ~30 lines)
    ↓
memory/topics/some-topic.md (loaded on demand via [[links]])
    ↓
memory/YYYY-MM-DD.md (daily notes, raw logs)
```

### Meta-Learning Files
| File | Purpose |
|------|---------|
| `AGENTS.md` | Session startup, group chat rules, reactions, heartbeats, gateway restart protocol, sub-agent rate limiting + completion gates |
| `COMMANDS.md` | 18 vault commands (`/today`, `/map`, `/graduate`, `/drift`, `/challenge`, etc.) |
| `LESSONS.md` | Mistake → guardrail pipeline |
| `HOLDS.md` | Temporary context filters with expiry dates |
| `FRICTION.md` | Contradiction log (new instructions vs old rules) |
| `PREDICTIONS.md` | Decision calibration tracker |

### Behavioral Patterns (in AGENTS.md)
- **Group chat rules** — when to speak, when to stay silent, participate don't dominate
- **Reaction guidelines** — react like a human (one per message, pick the right one)
- **Platform formatting** — no tables on Discord, no headers on WhatsApp
- **Heartbeat protocol** — proactive checks, quiet hours, memory maintenance cycles
- **Gateway restart protocol** — stop writing after config calls, wait for restart event
- **Sub-agent rate limiting** — sequential only, completion gates mandatory

### Vault Commands
| Command | What it does |
|---------|-------------|
| `/today` | Generate daily plan from recent context |
| `/close-day` | Capture learnings, flag unresolved items |
| `/map` | Topological view of all knowledge |
| `/graduate` | Promote daily note insights → topic files |
| `/bloom` | Expand outward from a concept through links |
| `/backlinks` | Find and wire missing connections |
| `/drift` | Find quietly abandoned topics |
| `/connect` | Surface unexpected bridges between domains |
| `/challenge` | Argue against current thinking |
| `/contradict` | Find incompatible beliefs |

### You Still Need to Create
| File | What goes in it |
|------|----------------|
| `SOUL.md` | Agent identity, personality, alignment |
| `USER.md` | About the human — name, timezone, preferences |

## Skills (31)

### 🎨 UI Design Frameworks (10)
`western-ui` · `retro-ui` · `folio-ui` · `ascii-type` · `voxel-type` · `synth-ui` · `specimen-ui` · `graffiti-ui` · `blueprint-ui` · `monochrome-ui`

### 📊 Visual Content (4)
`frontend-slides` · `visual-explainer` · `latex-style` · `ui-designer`

### 📄 Document Generation (3)
`docx` · `pptx` · `xlsx`

### 💻 Development (7)
`react-expert` · `typescript-pro` · `javascript-pro` · `nextjs-developer` · `python-pro` · `golang-pro` · `rust-engineer`

### 🧠 Workflow & Thinking (7)
`brainstorming` · `chain-of-thought` · `prompt-engineer` · `kanban-ai` · `article-extractor` · `skill-checker` · `self-improving-agent`

## Tools

| Tool | What | Install |
|------|------|---------|
| **Scrapling** | Three-tier web scraper (HTTP → Playwright → Cloudflare bypass) | `bash scripts/install-scrapling.sh` |
| **beautiful-mermaid** | ASCII/SVG diagram rendering from mermaid syntax | `npm install beautiful-mermaid tsx` |
| **Whisper CLI** | Local speech-to-text, offline, no API calls | `brew install whisper-cpp` |
| **Paper Design Shaders** | 23 canvas visual effects (liquid-metal, voronoi, etc.) | `npm install @paper-design/shaders` |
| **here.now** | Instant static hosting, live URL in seconds | API-based, no install needed |
| **Prompt Injection Scanner** | Detect jailbreaks/injection in untrusted content | Included (`tools/security/scan-injection.py`) |

## Token Efficiency

Skills load on-demand (matched by description). Memory system is lightweight — `_index.md` is ~30 lines, topic files load only when relevant. Heartbeat is set to every 60 minutes (adjustable in config).

## License

Skills shared freely. Reference material is for Alchemix team use.
