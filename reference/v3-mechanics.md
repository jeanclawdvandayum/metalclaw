# Alchemix V3 — Quick Reference for Content Creators

> **Read this before writing ANY V3 content.** Getting mechanics wrong erodes credibility.

## One-Liner
Self-repaying loans: deposit collateral, borrow synthetics, your debt decreases automatically.

## How It Works
1. **Deposit** collateral (USDC, ETH, etc.)
2. **Borrow** up to 90% LTV as synthetics (alUSD, alETH) — like-kind, always redeemable 1:1
3. **Three independent forces** act on your position:

| Force | Effect | Source |
|-------|--------|--------|
| **Yield** ↑ | Collateral grows | MYT strategies earning in DeFi |
| **Redemptions** ↓↓ | Debt shrinks (collateral drops too, but debt drops MORE) | Transmuter processing redemptions |
| **Interest** ↑ | Debt grows (if applicable) | Borrowing cost |

**Critical:** These three forces are INDEPENDENT. Yield ≠ debt repayment. Yield grows collateral. Redemptions shrink debt. They happen simultaneously but are separate mechanisms.

## Key Features
- **No liquidation risk** (like-kind collateral — USDC backing alUSD can't depeg against itself)
- **No loan term** — no schedule, no pressure, no margin calls
- **No management required** — deposit and forget
- **90% LTV** — borrow up to 90% of your collateral value

## MYT (Meta Yield Token)
Strategy abstraction layer. You deposit → MYT allocates across yield strategies → you do nothing. MYT share price rises as strategies earn.

## Killer Framings (use these)
- "Banks invented self-repaying loans centuries ago. They just kept them for themselves."
- "Democratized fractional reserve banking"
- "Your money works for you while you sleep"
- "The future repays itself"
- "Netflix where your money works for you" (for subscription use cases)
- Third path: cyberpunk warned, solarpunk dreamed, alchemypunk transmutes

## Common Mistakes (DON'T write these)
- ❌ "Yield pays off your debt" → Yield grows collateral. Redemptions reduce debt. Different forces.
- ❌ "No risk" → Like-kind means no PRICE-based liquidation. Strategy loss is still possible.
- ❌ "Passive income" → It's debt reduction, not income generation.
- ❌ "DeFi yield optimizer" → It's a self-repaying debt protocol. Yield optimization is a component, not the product.
- ❌ Treating earmark as yield distribution → Earmark = Transmuter claiming debt for redemption.

## Competitor Positioning
- **vs. Aave/Compound:** They give you loans. We give you loans that pay themselves off.
- **vs. Maker/DAI:** They charge stability fees (interest). We eliminate them.
- **vs. Traditional banks:** Same fractional reserve mechanics, but transparent, permissionless, and the debt shrinks.
