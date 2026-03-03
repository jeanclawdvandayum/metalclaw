# COMMANDS.md — Vault Commands

When the user invokes any of these commands, execute the described behavior against the knowledge vault (memory/topics/, memory/YYYY-MM-DD.md, LESSONS.md, project files).

"The vault" = all memory files, daily notes, topic files, project context files, LESSONS.md, and any project CONTEXT.md/ACTIVITY.md files.

---

## Self & Context

### /context
Read across the vault to build a full picture of who the user is, what they're working on, and what they care about right now. Start with memory/_index.md, follow links to active topics, read recent daily notes (last 3-5 days). Output a cohesive narrative, not a list.

### /ghost
Answer any question as the user by reading notes, beliefs, and writing style from the vault. Channel their voice, opinions, and reasoning patterns.

### /stranger
Read the entire vault and write a portrait of the user as if from someone who's never met them. What would an outsider conclude about this person from their notes alone?

---

## Daily Operations

### /today
Pull from recent daily notes, active project files, and open threads to generate a daily plan grounded in what's actually happening. Not aspirational — realistic.

### /close-day
Review what happened today (check daily note, git logs, session history). Capture what was learned. Flag anything unresolved for tomorrow. Update memory/YYYY-MM-DD.md. Promote insights to topic files if warranted.

### /7plan
Look at what's most alive in the user's thinking right now (recent daily notes, active topics). Reshape the next 7 days around it. Energy-aware, not just a todo list.

---

## Knowledge Graph Operations

### /map
Generate a topological view of everything in the vault. Show clusters, themes, and how ideas relate via [[wiki-links]].

### /bloom
Take a single question and expand outward through linked notes to visualize all surrounding context. Follow [[links]] 2-3 levels deep.

### /backlinks
Find notes that should be linked but aren't. Scan for concepts that reference each other implicitly. Wire new connections by editing the files.

### /graduate
Extract ideas buried in daily notes and promote them into standalone permanent notes (memory/topics/). Look for repeated themes, crystallized insights, or decisions that deserve their own topic file. Update memory/_index.md.

---

## Thinking & Analysis

### /trace
Track how thinking about an idea changed over time through daily notes. Show the evolution as a timeline narrative.

### /emerge
Find ideas never explicitly written but strongly implied by patterns across multiple notes.

### /connect
Surface unexpected bridges between unrelated domains in the vault.

### /contradict
Find places where two incompatible beliefs are held at the same time across different notes.

### /drift
Identify topics or commitments that have been quietly avoided based on gaps in the notes.

### /challenge
Read current thinking on a topic and argue against it using evidence from the vault itself. Steel-man the opposing position.

---

## Content Creation

### /ideas
Generate new ideas by reading current projects, interests, and open questions. Cross-pollinate between domains.

### /learned
Turn recent learnings into a polished summary. Pull from daily notes, LESSONS.md, and topic file updates from the last 1-2 weeks.

### /weekly-learnings
Compile the week's insights from daily notes into a single summary organized by theme, not by day.

---

## Notes

- All commands should READ files before acting — don't hallucinate vault contents
- Commands that modify files should show what they're changing
- Prioritize recent notes (last 30 days) unless the command asks for historical sweep
- Output format: narrative by default, structured/diagram when it serves clarity
- Commands can be combined: `/close-day` naturally feeds into `/graduate`
