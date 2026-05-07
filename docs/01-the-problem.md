# The Problem EDDIE Was Built to Solve

## How this started

I was building my website with an AI coding agent. I'd been using a skill called `superpowers:brainstorming` — it's good, it helps you think through features — but two problems kept coming back.

**First: I couldn't remember *why* anything was designed the way it was.** The brainstorming felt productive in the moment. It gave me multiple-choice answers and moved on. But six weeks later, when I wanted to add a new feature, there was no document that captured the *reasoning* behind a choice. Just the choice itself. I was stuck reconstructing my own logic from scratch.

**Second: the AI kept picking "what it knew" instead of "what was actually best."** Without forced research, the agent would default to the obvious option — the one in its training data — even when a different approach was more stable, more efficient, or more correct for my domain. I'm not a programmer by training. I had no way to push back.

So the brief became: build a meta-skill that fixes both things, in plain language a non-technical person can follow, while still producing professional-grade output.

A third thing emerged while designing it: this discipline isn't software-specific. The same "think before you build, document why you decided" pattern applies to robotics guides, process redesigns, and research write-ups. EDDIE should work for all of them.

## The two failures EDDIE fixes

| Failure mode | What happens without EDDIE | What EDDIE does instead |
|--------------|---------------------------|------------------------|
| **Decision amnesia** | Six weeks later, nobody remembers why a choice was made. Rebuild the same reasoning every time. | Every major decision is recorded in an anchor doc (PRD, architecture-design.md) with the *why* preserved alongside the *what*. |
| **AI defaults to "good enough"** | The agent picks the option it recognizes, not the option that's actually best. Non-technical user has no lever. | Research is a mandatory, first-class phase *before* architecture. The agent is forced to look outward before it decides inward. |

## The non-technical gap

Existing AI-coding skills have solved phase-gating. They've solved "skills as markdown." They've solved session persistence. What they haven't solved is **the non-technical user's need for professional discipline without professional vocabulary.**

You shouldn't need to know what an ADR is to benefit from one. You shouldn't need to have read *Shape Up* to get the value of shaped work. EDDIE borrows from the best methodologies — Architecture Decision Records, Amazon's PR-FAQ, Google's design docs, NASA mission gates — but translates them into a conversation. It produces the same durable artifacts, just without requiring you to already speak the language.
