# Prompt Injection Scanner

## What
Scans files or URLs for prompt injection attacks before processing untrusted content.

Detects: instruction overrides, DAN/jailbreak, zero-width chars, homoglyphs, encoded payloads, hidden HTML comments, fake system prompts, authority spoofing.

## Usage
```bash
# Scan a file
python3 tools/security/scan-injection.py /path/to/file.md

# Scan piped content
curl -s https://example.com | python3 tools/security/scan-injection.py -

# Scan a URL directly
python3 tools/security/scan-injection.py --url https://example.com
```

## Exit Codes
- `0` = clean
- `1` = patterns detected

## When to Use
- Before processing web-scraped content
- Before feeding Discord/forum crawls into sub-agent tasks
- Before processing user-submitted files
- Any time untrusted text will be used as context for AI operations

## Location
`tools/security/scan-injection.py` — standalone Python script, no dependencies.
