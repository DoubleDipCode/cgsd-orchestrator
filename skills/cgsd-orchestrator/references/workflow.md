# CGSD Workflow Guide

## Table of Contents
- [The 5-Step Phase Cycle](#the-5-step-phase-cycle)
- [Planning Hierarchy](#planning-hierarchy)
- [Wave-Based Execution](#wave-based-execution)
- [Context Management](#context-management)
- [Typical Session Flow](#typical-session-flow)

---

## The 5-Step Phase Cycle

Each phase follows a consistent workflow:

```
1. /cgsd:discuss-phase N    → Capture user intent
2. /cgsd:plan-phase N       → Research + create plans
3. /clear                   → Reset context (fresh 200k window)
4. /cgsd:execute-phase N    → Wave-based parallel execution
5. /cgsd:verify-work N      → User acceptance testing
```

**Why `/clear` before execution?** Plans are designed to execute within a fresh context window. The accumulated planning context would compete for tokens; clearing ensures maximum quality during implementation.

---

## Planning Hierarchy

CGSD creates a hierarchical structure of planning artifacts:

```
PROJECT.md (vision, ~2-3KB)
    ↓
REQUIREMENTS.md (v1/v2/out-of-scope with REQ-IDs, ~5-10KB)
    ↓
ROADMAP.md (phase breakdown + success criteria, ~3-5KB)
    ↓
For each phase:
    CONTEXT.md (user's vision for this phase)
        ↓
    RESEARCH.md (domain knowledge gathered)
        ↓
    {phase}-{N}-PLAN.md (2-3 atomic tasks per plan)
        ↓
    Execute → {phase}-{N}-SUMMARY.md (what happened)
```

All artifacts live in `.planning/`:
```
.planning/
├── PROJECT.md
├── REQUIREMENTS.md
├── ROADMAP.md
├── STATE.md           # Session state, decisions, blockers
├── config.json        # CGSD configuration
├── research/          # Domain research documents
├── phase-01/
│   ├── CONTEXT.md
│   ├── RESEARCH.md
│   ├── 01-01-PLAN.md
│   ├── 01-01-SUMMARY.md
│   ├── 01-02-PLAN.md
│   └── 01-02-SUMMARY.md
└── codebase/          # For brownfield projects
    ├── STACK.md
    ├── ARCHITECTURE.md
    └── ...
```

---

## Wave-Based Execution

Plans within a phase are grouped into dependency waves:

```
Wave 1: [Plan A, Plan B, Plan C]  ← Execute in parallel
         ↓ (all complete)
Wave 2: [Plan D, Plan E]          ← Execute in parallel
         ↓ (all complete)
Wave 3: [Plan F]                  ← Depends on D, E
```

**Benefits:**
- Each plan runs in a fresh 200k context (zero accumulated garbage)
- Independent plans execute concurrently via Task tool
- Clean git history with atomic per-task commits

**Commit format:**
```
{type}({phase}-{plan}): {task-name}

Examples:
feat(01-01): add user authentication endpoint
fix(01-02): handle null email in validation
docs(01-03): complete checkout flow plan
```

---

## Context Management

CGSD prevents "context rot"—the quality degradation as the context window fills.

**Quality curve:**
- 0-30% context: PEAK quality (thorough, comprehensive)
- 30-50%: GOOD quality (confident, solid)
- 50%+: DEGRADING (efficiency mode begins)

**Strategy:** Plans are designed to complete within ~50% of a fresh context window.

**Key files always in context:**
| File | Purpose | Size Target |
|------|---------|-------------|
| PROJECT.md | Vision | ~2-3KB |
| REQUIREMENTS.md | Scoped requirements | ~5-10KB |
| ROADMAP.md | Phase breakdown | ~3-5KB |
| STATE.md | Decisions, blockers | ~2-5KB |

**Loaded as needed:**
- research/ documents
- PLAN.md for current execution
- SUMMARY.md for context on completed work

---

## Typical Session Flow

### New Project (Greenfield)

```bash
# Session 1: Project setup
claude --dangerously-skip-permissions
/cgsd:new-project
# Answer questions about project vision
# System: creates PROJECT.md, REQUIREMENTS.md, ROADMAP.md

# Session 2: Phase 1
/cgsd:discuss-phase 1
/cgsd:plan-phase 1
/clear
/cgsd:execute-phase 1
/cgsd:verify-work 1

# Session 3: Phase 2
/cgsd:discuss-phase 2
/cgsd:plan-phase 2
/clear
/cgsd:execute-phase 2
/cgsd:verify-work 2

# Continue for remaining phases...

# Final: Complete milestone
/cgsd:audit-milestone v1
/cgsd:complete-milestone v1
```

### Existing Project (Brownfield)

```bash
# Session 1: Map codebase first
claude --dangerously-skip-permissions
/cgsd:map-codebase
# System: creates .planning/codebase/ with analysis

# Session 2: Project setup (informed by codebase)
/cgsd:new-project
# Questions will be tailored to existing patterns

# Continue with normal phase workflow...
```

### Resuming Work

```bash
# After a break or context reset
claude --dangerously-skip-permissions
/cgsd:resume-work
# System: loads STATE.md, shows current position
# Routes to appropriate next action
```

### Quick Ad-hoc Tasks

```bash
# For tasks that don't need full planning
/cgsd:quick Add a health check endpoint at /api/health
# System: executes with atomic commit, skips optional agents
```

---

## Model Profiles

Configure via `/cgsd:set-profile`:

| Profile | Planner | Executor | Verifier | Use Case |
|---------|---------|----------|----------|----------|
| quality | Opus | Opus | Sonnet | Critical work, maximum reasoning |
| balanced | Opus | Sonnet | Sonnet | Standard development (default) |
| budget | Sonnet | Sonnet | Haiku | High-volume, conserve tokens |
