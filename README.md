# metalclaw 🤘

**OpenClaw enhancement pack — 24 skills + knowledge graph memory system.**

## What's In Here

| Directory | Contents |
|-----------|----------|
| `skills/` | 24 skills — UI frameworks, design tools, visual explainers, document generators, workflow utilities |
| `system/` | Memory system upgrade — knowledge graph, meta-learning files, vault commands |
| `reference/` | Alchemix V3 mechanics reference (for accurate content) |
| `tools/` | Tool guides + install scripts (scrapling web scraper) |
| `scripts/` | One-shot install script |

## Install

```bash
# Clone
git clone https://github.com/jeanclawdvandayum/metalclaw.git /tmp/metalclaw

# Install from your workspace directory
cd ~/your-workspace
bash /tmp/metalclaw/scripts/install.sh
```

The installer:
- Copies 24 skills to `~/.openclaw/skills/` and `~/.claude/skills/`
- Drops memory system files into your workspace (won't overwrite existing files)
- Creates `memory/topics/` directory structure

### Optional: Scrapling (stealth web scraper)
```bash
bash /tmp/metalclaw/scripts/install-scrapling.sh
```
Three-tier fetcher: fast HTTP → Playwright (JS rendering) → Camoufox (Cloudflare bypass). See `tools/scrapling.md` for usage.

## Memory System

The memory system gives your agent persistent context across sessions through files it reads on startup.

### Files Installed

| File | Purpose |
|------|---------|
| `AGENTS.md` | Session startup checklist + workspace conventions |
| `COMMANDS.md` | 18 vault commands (`/today`, `/map`, `/graduate`, `/drift`, etc.) |
| `LESSONS.md` | Mistake → guardrail pipeline. Every failure becomes a permanent rule. |
| `HOLDS.md` | Temporary context filters with expiry dates |
| `FRICTION.md` | Contradiction log — when new instructions conflict with old ones |
| `PREDICTIONS.md` | Decision calibration — track predictions vs outcomes |
| `memory/_index.md` | Knowledge graph entry point (Map of Content) |

### How It Works

```
AGENTS.md (read every session)
    ↓
memory/_index.md (knowledge graph index, ~30 lines)
    ↓
memory/topics/some-topic.md (loaded on demand via [[links]])
    ↓
memory/YYYY-MM-DD.md (daily notes, raw logs)
```

**Daily notes** are raw logs. **Topic files** are curated knowledge. The `/graduate` command promotes insights from daily notes into topic files.

### Vault Commands

Tell your agent `/command` and it executes against the knowledge vault:

| Command | What it does |
|---------|-------------|
| `/today` | Generate a daily plan from recent context |
| `/close-day` | Capture the day's learnings, flag unresolved items |
| `/map` | Topological view of all knowledge |
| `/graduate` | Promote daily note insights → topic files |
| `/bloom` | Expand outward from a concept through linked notes |
| `/backlinks` | Find and wire missing connections |
| `/drift` | Find quietly abandoned topics |
| `/connect` | Surface unexpected bridges between domains |
| `/challenge` | Argue against current thinking using the vault |
| `/contradict` | Find incompatible beliefs held simultaneously |

### You Still Need to Create

| File | What goes in it |
|------|----------------|
| `SOUL.md` | Agent identity, personality, alignment |
| `USER.md` | About the human — name, timezone, preferences, context |

## Skills List

### 🎨 UI Design Frameworks (10)
`western-ui` · `retro-ui` · `folio-ui` · `ascii-type` · `voxel-type` · `synth-ui` · `specimen-ui` · `graffiti-ui` · `blueprint-ui` · `monochrome-ui`

### 📊 Visual Content (4)
`frontend-slides` · `visual-explainer` · `latex-style` · `ui-designer`

### 📄 Document Generation (3)
`docx` · `pptx` · `xlsx`

### 🧠 Workflow & Thinking (7)
`brainstorming` · `chain-of-thought` · `prompt-engineer` · `kanban-ai` · `article-extractor` · `skill-checker` · `self-improving-agent`

## Token Efficiency

Skills are loaded on-demand (only when matched by description). The memory system is lightweight — `_index.md` is ~30 lines, topic files load only when relevant. No cron jobs, no background processes.

## License

Skills shared freely. Reference material is for Alchemix team use.
