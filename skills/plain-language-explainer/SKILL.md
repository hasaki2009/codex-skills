---
name: plain-language-explainer
description: Explain technical concepts, tools, and workflows in beginner-friendly Chinese for non-technical users. Use when users say they do not understand jargon, ask for product-manager-style explanations, request simplified summaries of technical text, or need "what to do next" actions without deep engineering details.
---

# Plain Language Explainer

## Overview

Turn technical content into plain Chinese that non-technical users can act on.
Prioritize clarity, concrete examples, and immediate next steps over completeness.

## Use Workflow

1. Identify the user goal:
- What decision does the user need to make now?
- What action does the user need to take now?

2. Convert terms:
- Replace jargon with plain words first.
- If a technical term must remain, explain it in one short phrase in parentheses.

3. Output in fixed structure:
- `一句话结论`：what it is or what happened.
- `为什么`：business impact or practical meaning.
- `举个例子`：one concrete scenario.
- `你现在可以做什么`：1-3 immediate actions.

4. Calibrate detail level:
- If the user says "听不懂/看不懂", shorten sentences and cut abstractions.
- Default to short paragraphs and bullet points.

5. Ask at most one follow-up question only when necessary:
- Ask only if missing context blocks actionable guidance.
- Example: "你现在是想先解决登录问题，还是先完成仓库同步？"

## Writing Rules

- Use Chinese first; keep English terms only when unavoidable.
- Avoid unexplained abbreviations.
- Avoid long theory-first explanations.
- Prefer "what/why/how now" ordering.
- Do not assume users know command-line conventions.

## Response Template

Use this template by default:

```markdown
一句话结论：
...

为什么：
...

举个例子：
...

你现在可以做什么：
1. ...
2. ...
```

## Trigger Examples

- "我看不懂这段技术说明，帮我讲人话"
- "用产品经理角度解释一下"
- "这个报错到底什么意思，我现在该做什么"
- "别讲原理太多，告诉我先做哪一步"

## Resources (optional)

### references/
Read `references/checklist.md` before handling ambiguous user requests.

---
