# OpenClaw Config Guide — Heartbeats & Cron

## Heartbeat Setup

Add to your `openclaw.json` (or use `openclaw config edit`):

```json
{
  "heartbeat": {
    "enabled": true,
    "intervalMinutes": 60
  }
}
```

**Recommended interval:** 60 minutes for API users (token-efficient). Adjust down to 30 if you want more frequent check-ins.

The agent reads `HEARTBEAT.md` each cycle and decides what to check. Edit `HEARTBEAT.md` to customize the checklist.

## Cron Jobs

Cron jobs run isolated from the main session. Good for exact-time tasks.

### Example: Daily Standup (8am)
```
openclaw cron add \
  --name "daily-standup" \
  --schedule "0 8 * * *" \
  --task "Check calendar for today's events. Summarize any urgent items. Post to the main channel."
```

### Example: Weekly Review (Monday 9am)
```
openclaw cron add \
  --name "weekly-review" \
  --schedule "0 9 * * 1" \
  --task "Run /weekly-learnings. Compile insights from the past week's daily notes."
```

### Example: One-Shot Reminder
```
openclaw cron add \
  --name "reminder" \
  --schedule "in 30 minutes" \
  --task "Remind the user about the meeting with the design team."
```

### Cron Management
```bash
openclaw cron list          # See all cron jobs
openclaw cron remove <id>   # Delete a cron job
```

## Heartbeat vs Cron Decision Tree

```
Need exact timing?
  YES → cron
  NO  → heartbeat

Need main session context?
  YES → heartbeat
  NO  → cron

Multiple checks at once?
  YES → heartbeat (batch them)
  NO  → cron (isolate it)

Different model or thinking level?
  YES → cron
  NO  → heartbeat
```
