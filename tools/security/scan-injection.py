#!/usr/bin/env python3
"""
Lightweight prompt injection scanner for OpenClaw.
Adapted from lasso-security/claude-hooks patterns.yaml.

Usage:
  python3 scan-injection.py <file_or_text>
  echo "content" | python3 scan-injection.py -
  python3 scan-injection.py --url https://example.com

Only flags HIGH severity patterns to avoid noise.
"""

import re
import sys
import argparse

# HIGH severity patterns only — the ones that actually matter
PATTERNS = {
    "Instruction Override": [
        (r'(?i)\bignore\s+(all\s+)?(previous|prior|above|earlier|preceding)\s+(instructions?|prompts?|rules?|guidelines?|directives?|context)', "Attempts to ignore previous instructions"),
        (r'(?i)\bforget\s+(all\s+)?(previous|prior|above|earlier|your)\s+(instructions?|prompts?|rules?|training|guidelines?)', "Attempts to make AI forget instructions"),
        (r'(?i)\boverride\s+(your\s+|all\s+)?(instructions?|programming|directives?|rules?|guidelines?)', "Attempts to override instructions"),
        (r'(?i)\b(new|updated|revised|real)\s+system\s+prompt\b', "Attempts to inject new system prompt"),
        (r'(?i)\bsystem\s+prompt\s*(:|=|override)', "System prompt injection marker"),
        (r'(?i)\bfrom\s+now\s+on[,\s]+(you\s+)?(will|must|should|are)', "Redefine behavior going forward"),
        (r'(?i)\breset\s+(your\s+)?(context|memory|instructions?|state|conversation)', "Context reset attempt"),
        (r'(?i)\[/?system\]|\{/?system\}|</?system\s*>', "Fake system message markers"),
        (r'(?i)\[\[SYSTEM\]\]|\(\(SYSTEM\)\)|\{\{SYSTEM\}\}', "Fake system block markers"),
        (r'(?i)\bthis\s+(instruction|command|task|directive)\s+(takes?\s+)?(priority|precedence)\s+over', "Priority manipulation"),
        (r'(?i)\b(real|actual|true)\s+(instruction|prompt|task|command)\s*(starts?|begins?)?\s*(here|below|now)', "Fake real instruction marker"),
    ],
    "Jailbreak / DAN": [
        (r'(?i)\byou\s+are\s+(now\s+)?DAN\b', "DAN jailbreak attempt"),
        (r'(?i)\b(enable|activate|enter)\s+(jailbreak|unrestricted|god)\s*mode', "Mode activation jailbreak"),
        (r'(?i)\bDEVELOPER\s+MODE\s+(ENABLED|ACTIVATED|ON)', "Fake developer mode"),
        (r'(?i)\b(without|ignore|bypass|disable|remove)\s+(your\s+)?(restrictions?|filters?|safeguards?|limitations?|guardrails?)', "Restriction bypass"),
        (r'(?i)\b(remove|turn\s+off|disable|deactivate)\s+(your\s+)?(ethical|safety|content)\s+(guidelines?|filters?|restrictions?)', "Safety filter disable"),
        (r'(?i)\byou\s+are\s+(now\s+)?(a|an)\s+(different|new|unrestricted|unfiltered|uncensored)', "Persona change to unrestricted"),
        (r'(?i)\b(evil|shadow|dark|unrestricted|uncensored)\s+(twin|version|mode|side|alter\s*ego)\b', "Evil twin persona"),
    ],
    "Encoding / Obfuscation": [
        (r'[\u200B\u200C\u200D\uFEFF\u00AD]{2,}', "Zero-width/invisible characters"),
        (r'[\u2060\u180E\u2000-\u200F]{3,}', "Unicode whitespace manipulation"),
        (r'[\u034F\u115F\u1160\u17B4\u17B5]{2,}', "Unicode filler characters"),
        (r'[\u0430\u0435\u043E\u0440\u0441\u0443\u0445\u0456]{3,}', "Cyrillic homoglyphs (lookalike letters)"),
        (r'[\u03B1\u03B5\u03BF\u03C1\u03BD\u03C4]{2,}', "Greek homoglyphs"),
        (r'(?i)\b(j41lbr34k|byp4ss|h4ck)\b', "Leetspeak jailbreak terms"),
    ],
    "Context Manipulation": [
        (r'(?i)\b(anthropic|openai|claude\s*team)\s+(says?|requires?|demands?|orders?|instructs?)\b', "False authority (AI company)"),
        (r'(?i)\b(official|authorized|verified)\s+(instruction|message|update|command)\s+from\s+(anthropic|openai|claude)', "Fake official message"),
        (r'(?i)\b(system\s+)?(administrator|admin|root|superuser)\s+(message|override|instruction|command)', "Fake admin message"),
        (r'(?i)<!--\s*(ignore|disregard|override|system|instruction|prompt|forget)', "Instruction in HTML comment"),
        (r'(?i)/\*\s*(ignore|disregard|override|system|instruction|prompt|forget)', "Instruction in code comment"),
        (r'(?i)\{"role"\s*:\s*"system"', "Fake system role JSON"),
        (r'(?i)<system[^>]*>|<instruction[^>]*>|<override[^>]*>', "Fake system XML/HTML tags"),
        (r'(?i)\[INST\]|\[/INST\]|\[SYS\]|\[/SYS\]', "Fake instruction block markers"),
        (r'(?i)\b(show|reveal|tell|display|print|output)\s+(me\s+)?(your\s+)?(full\s+)?(system\s+)?prompt', "System prompt extraction"),
        (r'(?i)\brepeat\s+(your\s+)?(system\s+)?(prompt|instructions?)\s+(back|verbatim|exactly)', "Prompt repetition extraction"),
        (r'(?i)\bignore\s+everything\s+(before|after|above|below)\s+this\s+(line|point|marker)', "Instruction boundary manipulation"),
    ],
}


def scan(text: str) -> list:
    """Scan text for injection patterns. Returns list of (category, reason) tuples."""
    hits = []
    for category, patterns in PATTERNS.items():
        for pattern, reason in patterns:
            try:
                if re.search(pattern, text, re.IGNORECASE | re.MULTILINE):
                    hits.append((category, reason))
            except re.error:
                continue
    return hits


def main():
    parser = argparse.ArgumentParser(description="Scan for prompt injection patterns")
    parser.add_argument("input", nargs="?", default="-", help="File path, - for stdin, or --url")
    parser.add_argument("--url", help="Fetch and scan a URL")
    args = parser.parse_args()

    if args.url:
        import urllib.request
        try:
            with urllib.request.urlopen(args.url, timeout=10) as resp:
                text = resp.read().decode("utf-8", errors="replace")
        except Exception as e:
            print(f"Error fetching URL: {e}", file=sys.stderr)
            sys.exit(1)
    elif args.input == "-":
        text = sys.stdin.read()
    else:
        try:
            with open(args.input, "r", encoding="utf-8", errors="replace") as f:
                text = f.read()
        except FileNotFoundError:
            # Treat as literal text
            text = args.input

    hits = scan(text)

    if not hits:
        print("✅ Clean — no injection patterns detected")
        sys.exit(0)

    print(f"⚠️  {len(hits)} injection pattern(s) detected:\n")
    for category, reason in hits:
        print(f"  🔴 [{category}] {reason}")
    print()
    sys.exit(1)


if __name__ == "__main__":
    main()
