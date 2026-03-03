# here.now — Instant Static Hosting

## What
Free, instant static hosting. Publish HTML/CSS/JS and get a live URL in seconds. No auth needed.

- **Site:** https://here.now
- **Backed by:** Cloudflare R2 edge network
- **Limits:** Anonymous publishes expire in 24h. Authenticated = permanent.

## Install (optional CLI)
```bash
curl -fsSL https://here.now/install.sh | bash
```

## API Usage (no CLI needed)

```bash
# 1. Create publish
RESPONSE=$(curl -sS https://here.now/api/v1/publish \
  -H "content-type: application/json" \
  -d "{\"files\": [{\"path\": \"index.html\", \"size\": $(wc -c < index.html), \"contentType\": \"text/html; charset=utf-8\"}]}")

# 2. Extract upload URL and metadata
UPLOAD_URL=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['uploads'][0]['url'])")
FINALIZE_URL=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['finalizeUrl'])")
VERSION_ID=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['versionId'])")

# 3. Upload file
curl -X PUT "$UPLOAD_URL" \
  -H "Content-Type: text/html; charset=utf-8" \
  --data-binary @index.html

# 4. Finalize
curl -sS -X POST "$FINALIZE_URL" \
  -H "content-type: application/json" \
  -d "{\"versionId\": \"$VERSION_ID\"}"
```

## Tips
- Each file needs its own upload call (repeat steps for CSS, JS, images)
- Use explicit file paths — no trailing-slash directory links
- Rate limit: 5 anonymous publishes per hour
- For permanent publishes: sign in at here.now, get API key, add `Authorization: Bearer <key>` header

## When to Use
- Quick prototypes and demos
- Sharing single-file HTML builds
- Publishing from private repos
- Previewing before deploying to production hosting
