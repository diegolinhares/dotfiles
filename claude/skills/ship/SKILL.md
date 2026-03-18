---
name: ship
version: 1.2.0
description: |
  Write human-sounding commit messages and pull requests.
  Finds the project's PR template, fills every section with real content,
  and scrubs AI writing patterns from all text before submitting.
  Use when the user says "commit", "ship", "pr", "open a pull request",
  or asks to prepare changes for review.
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
  - Edit
  - Agent
  - AskUserQuestion
---

# /ship -- commit and PR workflow

Write commits and PRs that sound like a person wrote them. Before finalizing any text, read `references/anti-slop.md` and scrub against it.

## Workflow

`/ship` or `/ship commit` -- commits only:
1. Read the diff
2. Write the message
3. Anti-slop pass (read `references/anti-slop.md`)
4. Stage and commit

`/ship pr` -- full PR:
1. Read all commits on the branch, not just the latest
2. Find the project's PR template
3. Fill every section with prose
4. Anti-slop pass
5. Ask confirmation, then push and create the PR with `gh pr create`

## Step 1: understand the change

```bash
git status
git diff --staged
git diff
git log --oneline -10
```

Figure out what changed, why it changed (ask the user if unclear), and what it affects.

## Step 2: commit message

### Format

```
<imperative verb> <what changed>

<why this change exists -- the problem, the context>
<why this approach -- trade-offs, alternatives rejected>
<anything the reader needs that the diff can't show>
```

Imperative mood: "Fix", "Add", "Remove", "Switch". Not "Fixed", "Adds". The subject completes: "If applied, this commit will ___."

Capitalize first word. No period. 50 chars target, 72 max. Blank line before body. Wrap body at 72.

Explain the problem before the solution. Include numbers when claiming improvements. Name specific things: the file, the function, the error.

Skip the body for obvious changes ("Fix typo in README"). If the subject needs "and", split into two commits.

## Step 3: PR description

### Find the template first

```
.github/pull_request_template.md
.github/PULL_REQUEST_TEMPLATE.md
.github/PULL_REQUEST_TEMPLATE/default.md
docs/pull_request_template.md
```

Fill every section. If a section doesn't apply, write "N/A" -- don't delete it.

If no template exists:

```markdown
### What changed
<the problem and the approach, not a file list>

### Why
<motivation, issue link, who reported it>

### How I tested it
<commands, screenshots, staging results>

### Review guidance
<where to start reading, what feedback you want>
```

### Writing style

Write prose, not bullet lists. One to three sentences per section. Talk like you're explaining to a coworker, not writing a press release.

Start with the problem, not "This PR implements...". Link issues but don't lean on the link alone. For test plans, give actual commands and evidence, not "Tests pass." For technical notes, admit trade-offs and shortcuts honestly.

PR title: imperative mood, under 72 chars, no period. Use conventional commits prefix if the project does (`feat:`, `fix:`, etc.).

## Step 4: anti-slop pass

Read `references/anti-slop.md` and scrub every piece of text against it. Replace slop words, kill bad sentence patterns, run the audit checklist. No text ships without this pass.

## Rules

- Never push without asking the user first
- Never commit to main
- Always use the project's PR template when one exists
- Always read the full diff before writing anything
