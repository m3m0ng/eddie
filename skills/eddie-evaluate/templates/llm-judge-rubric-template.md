# <Feature name> — LLM-Judge Rubric

Used by EDDIE's Evaluate phase when the PRD declares an AI-output feature. The product (using the generating model) produces outputs; a *different* judge model scores them against this rubric.

## Feature being evaluated

[Brief description of the AI-output feature, with PRD Req ID.]

## Generating model

[Model name + version that produces the outputs in production.]

## Judge model

[A DIFFERENT model — must not be the same family/version as the generating model. Anthropic-recommended pattern: judge model ≠ generating model to avoid rubber-stamping.]

## Scoring dimensions

(3-5 dimensions. Each on a 1-5 scale with concrete anchor descriptions.)

### Dimension 1: [name]

- **5** — [concrete description of a 5]
- **4** — [...]
- **3** — [...]
- **2** — [...]
- **1** — [concrete description of a 1]

**Pass threshold:** [e.g. ≥4]

### Dimension 2: [name]

(same structure)

### Dimension 3: [name]

(same structure)

## Test cases

(5-10 input cases with expected qualities — NOT exact outputs. The judge scores the actual output against the rubric, not against an expected string.)

| ID | Input | Expected qualities | Notes |
|----|-------|--------------------|-------|
| TC-001 | "..." | helpful, accurate, polite | edge case: ambiguous request |
| TC-002 | "..." | refuses politely, no PII leak | adversarial input |
| ... | ... | ... | ... |

## Judge prompt template

```
You are evaluating an AI-generated output against a rubric.

Rubric:
{{rubric}}

Input that was given to the generating model:
{{input}}

Output that the generating model produced:
{{output}}

First, think through how the output performs on each dimension. Consider concrete reasons.
Then, output ONLY a JSON object with the score per dimension (1-5) and an overall pass/fail:

{
  "dimension_1": <score>,
  "dimension_2": <score>,
  "dimension_3": <score>,
  "pass": <true|false>
}

Your reasoning will be discarded. Only the JSON is recorded.
```

## Pass criteria

The output passes if ALL dimensions meet their pass thresholds.

## How this layer reports into the RTM

Each test case becomes a row in `evaluation/rtm.md` with `Layer = LLM-Judge`. Aggregate pass rate is reported on each `/eddie:evaluate` wrap-up run.
