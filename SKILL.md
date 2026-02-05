---
name: cgsd-orchestrator
description: Orchestrate Claude Code with the CGSD framework for reliable multi-phase project development. Use when building complex software projects, managing multi-phase implementations, or when the user needs structured AI-assisted development with atomic commits, wave-based execution, and context management. Triggers on: "build a project", "implement this feature", "multi-phase development", "use CGSD", "reliable development workflow", or any complex software task requiring planning and execution phases.
---

# CGSD Orchestrator

Orchestrate Claude Code using the CGSD (Context-engineered Get Shit Done) framework for reliable, multi-phase software development.

## When to Use CGSD

Use CGSD for projects that:
- Require multiple phases or features
- Need reliable, atomic progress tracking
- Would suffer from context degradation in long sessions
- Benefit from structured planning before implementation

Skip CGSD for:
- Single-file changes or quick fixes (use direct Claude Code)
- Pure research or exploration tasks
- Tasks completable in one short session

## Setup

Verify or install CGSD:

```bash
./scripts/setup.sh
```

Or manually:
```bash
npx get-shit-done-cc --claude --local
```

## Orchestration Pattern

Invoke Claude Code with CGSD commands via bash:

```bash
claude --dangerously-skip-permissions -p "/cgsd:command [args]"
```

The `-p` flag passes a prompt directly. The `--dangerously-skip-permissions` flag enables frictionless automation.

## Core Workflow

For each project, follow this sequence:

### 1. Initialize Project

```bash
claude -p "/cgsd:new-project"
```

Answer the interactive questions about project vision. Creates:
- `.planning/PROJECT.md` - Vision document
- `.planning/REQUIREMENTS.md` - Scoped requirements with REQ-IDs
- `.planning/ROADMAP.md` - Phase breakdown

### 2. For Each Phase (repeat)

```bash
# Capture user intent
claude -p "/cgsd:discuss-phase N"

# Create detailed plans
claude -p "/cgsd:plan-phase N"

# Execute with fresh context
claude -p "/cgsd:execute-phase N"

# Verify the work
claude -p "/cgsd:verify-work N"
```

Replace `N` with the phase number (1, 2, 3...).

### 3. Complete Milestone

```bash
claude -p "/cgsd:audit-milestone v1"
claude -p "/cgsd:complete-milestone v1"
```

## Quick Reference

**Check status:**
```bash
claude -p "/cgsd:progress"
```

**Resume after break:**
```bash
claude -p "/cgsd:resume-work"
```

**Quick ad-hoc task:**
```bash
claude -p "/cgsd:quick Add health check endpoint"
```

**Brownfield (existing codebase):**
```bash
claude -p "/cgsd:map-codebase"  # Run first
claude -p "/cgsd:new-project"    # Then initialize
```

## References

For detailed information:
- **All commands:** See [references/commands.md](references/commands.md)
- **Workflow details:** See [references/workflow.md](references/workflow.md)

## Model Profiles

Optimize for quality vs. cost:

```bash
claude -p "/cgsd:set-profile quality"   # Max reasoning (Opus throughout)
claude -p "/cgsd:set-profile balanced"  # Default (Opus plan, Sonnet execute)
claude -p "/cgsd:set-profile budget"    # Conserve tokens (Sonnet/Haiku)
```

## Orchestration Example

Building a todo app with CGSD:

```bash
# 1. Start project
claude -p "/cgsd:new-project"
# → Answer: "A todo app with user auth, task CRUD, and due date reminders"

# 2. Phase 1: Authentication
claude -p "/cgsd:discuss-phase 1"
claude -p "/cgsd:plan-phase 1"
claude -p "/cgsd:execute-phase 1"
claude -p "/cgsd:verify-work 1"

# 3. Phase 2: Task Management
claude -p "/cgsd:discuss-phase 2"
claude -p "/cgsd:plan-phase 2"
claude -p "/cgsd:execute-phase 2"
claude -p "/cgsd:verify-work 2"

# 4. Phase 3: Reminders
claude -p "/cgsd:discuss-phase 3"
claude -p "/cgsd:plan-phase 3"
claude -p "/cgsd:execute-phase 3"
claude -p "/cgsd:verify-work 3"

# 5. Complete
claude -p "/cgsd:audit-milestone v1"
claude -p "/cgsd:complete-milestone v1"
```

Each phase executes in a fresh 200k context window with wave-based parallel execution and atomic per-task commits.
