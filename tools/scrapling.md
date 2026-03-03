# Scrapling — Stealth Web Scraper

## Install
```bash
bash scripts/install-scrapling.sh
```

## What It Does
Three-tier web fetcher. Pick the lightest tool that works:

| Fetcher | Speed | Use When |
|---------|-------|----------|
| `Fetcher` (Adaptor) | ⚡ Fast | Static pages, APIs, most sites |
| `DynamicFetcher` (Playwright) | 🔄 Medium | JS-rendered SPAs, React sites |
| `StealthyFetcher` (Camoufox) | 🥷 Slow | Cloudflare-protected, anti-bot sites |

## Quick Usage

### From Python (inline scripts)
```python
from scrapling.fetchers import Fetcher, StealthyFetcher, DynamicFetcher

# Fast HTTP (impersonates Chrome TLS fingerprint)
page = Fetcher.get('https://example.com')
print(page.text)                          # Full text
titles = page.css('h1::text').getall()    # CSS selectors
links = page.css('a::attr(href)').getall()

# JS-rendered (Playwright browser)
page = DynamicFetcher.get('https://spa-site.com', network_idle=True)

# Cloudflare bypass (stealth browser)
page = StealthyFetcher.get('https://protected-site.com')
```

### CSS Selectors
```python
page.css('.content::text').getall()     # Text from elements
page.css('a::attr(href)').getall()      # Attribute values
page.css('.item').first()               # First match
page.css('.item').last()                # Last match
page.css('.item')[2]                    # Index access
```

### Common Patterns
```python
# Extract article content
page = Fetcher.get(url)
title = page.css('h1::text').get()
body = page.css('article::text').getall()

# Bulk fetch
urls = ['https://a.com', 'https://b.com']
for url in urls:
    page = Fetcher.get(url)
    # process...
```

## When to Use vs Built-in Tools

| Tool | Best For |
|------|----------|
| `web_fetch` (OpenClaw built-in) | Simple page grabs, quick lookups |
| `Fetcher` (scrapling) | When you need CSS selectors, bulk fetching, or Chrome TLS fingerprinting |
| `DynamicFetcher` | SPAs, sites that render content via JavaScript |
| `StealthyFetcher` | Sites that block bots, Cloudflare protection |
| `browser` tool | Interactive pages, filling forms, clicking buttons |

**Rule of thumb:** Start with `web_fetch`. If it fails or returns garbage, step up to scrapling.

## Installed Via
- `pipx` (isolated Python environment)
- Playwright Chromium (for DynamicFetcher)
- Camoufox (for StealthyFetcher)
