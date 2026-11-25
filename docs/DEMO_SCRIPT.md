# Demo video script (about 2 min 30 s)

Record the screen with your voice (OBS, or the built-in screen recorder).
Have these open before you start: the live demo
(https://originguard.vercel.app), the README on GitHub scrolled to "Results
on real public attacks", and page 1 of `docs/main.pdf`. Speak slowly; the
words below are about 330, which fits.

## 0:00 – 0:15  The problem (face the demo page)
"AI agents read web pages and emails, then send emails and run tools. Text
hidden in a page can tell the agent to steal your files. That is called
prompt injection, and it already hit real products. I built OriginGuard, a
firewall that sits between the agent and its tools."

## 0:15 – 0:55  Live demo (the Vercel page)
Pick "Hidden instruction on the page", click Run.
"Here a simulated agent reads a page with a hidden instruction. Left: no
protection. The agent reads my private key and emails it to an attacker.
Right: OriginGuard. Both calls are blocked, rule R1, because the target came
from untrusted page content and not from me. My own email to my boss still
goes through. All secrets here are fake."
Then pick "Claimed authority" and Run: "Even when the page claims I approved it."

## 0:55 – 1:20  How it works (stay on the page, point at the rule text)
"OriginGuard labels every piece of content as trusted, from the user, or
untrusted, from the web. A risky action aimed at a target that only untrusted
content named is blocked. A second check reads the agent's final answer, so a
link or image that carries a secret, the shape of the Slack AI and EchoLeak
attacks, is stopped too."

## 1:20 – 1:55  Real data (README results section)
"I tested it on 46 real attacker goals from AgentDojo, a public benchmark from
ETH Zurich and Google DeepMind. OriginGuard held 41 of 46, 89 percent. To be
honest about that: 38 are attacks that name an attacker address, which the
rules catch by design, and 3 more came from a rule I wrote after seeing them.
The regex detector on its own is weak on plain text attacks, so the target
rules do the real work."

## 1:55 – 2:15  The real model (README, live results)
"I also ran Meta's Muse Spark as the agent, with and without the firewall,
about twenty runs each, even telling it to obey instructions in pages. It never
followed the attacks, zero leaks. That is good news for the model, but it also
means my firewall's blocking is shown by the benchmark and replays, not by a
live block."

## 2:15 – 2:30  Limits and close (page 1 of the PDF)
"Limits: it only sees tool calls and answers that go through it, and a user
who approves a prompt out of habit can still be tricked. It is open source,
scales with Redis, runs in Docker, and the paper lists every gap. OriginGuard:
a small, honest firewall for AI agents. Code and live demo are linked below."

## Do not say
- "100 percent safe", "stops all prompt injection", or "99 percent".
- That the 41 of 46 is a clean held-out test.
- That the live model was blocked by the firewall (it never attacked).
