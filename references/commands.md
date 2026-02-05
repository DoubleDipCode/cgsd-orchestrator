# CGSD Command Reference

## Table of Contents
- [Core Workflow Commands](#core-workflow-commands)
- [Phase Management](#phase-management)
- [Milestone Management](#milestone-management)
- [Session Commands](#session-commands)
- [Utility Commands](#utility-commands)

---

## Core Workflow Commands

The primary 5-step cycle for each phase:

### /cgsd:new-project
Initialize a new project with deep context gathering.

**Flow:** Questions → Research → Requirements → Roadmap

**When to use:** Starting a greenfield project or onboarding an existing codebase.

**Invocation:**
```bash
claude -p "/cgsd:new-project"
```

---

### /cgsd:discuss-phase [N]
Gather implementation decisions through adaptive questioning before planning.

**When to use:** Before planning a phase, to capture user intent and constraints.

**Invocation:**
```bash
claude -p "/cgsd:discuss-phase 1"
```

---

### /cgsd:plan-phase [N]
Research + plan + verify for a specific phase. Creates PLAN.md files with atomic tasks.

**When to use:** After discussing a phase, before execution.

**Invocation:**
```bash
claude -p "/cgsd:plan-phase 1"
```

---

### /cgsd:execute-phase [N]
Execute all plans in a phase with wave-based parallelization and atomic commits.

**When to use:** After plans are created and verified.

**Invocation:**
```bash
claude -p "/cgsd:execute-phase 1"
```

---

### /cgsd:verify-work [N]
Manual user acceptance testing through conversational UAT.

**When to use:** After phase execution to validate the built features.

**Invocation:**
```bash
claude -p "/cgsd:verify-work 1"
```

---

## Phase Management

### /cgsd:add-phase
Append a new phase to the end of the current roadmap.

**Invocation:**
```bash
claude -p "/cgsd:add-phase"
```

---

### /cgsd:insert-phase [N]
Insert urgent work as a decimal phase (e.g., 2.1) between existing phases.

**When to use:** Urgent work discovered mid-milestone that can't wait.

**Invocation:**
```bash
claude -p "/cgsd:insert-phase 2"  # Creates phase 2.1
```

---

### /cgsd:remove-phase [N]
Remove a future phase from the roadmap and renumber subsequent phases.

**Invocation:**
```bash
claude -p "/cgsd:remove-phase 5"
```

---

### /cgsd:list-phase-assumptions [N]
Surface Claude's intended approach before planning.

**When to use:** To preview and adjust assumptions before committing to a plan.

**Invocation:**
```bash
claude -p "/cgsd:list-phase-assumptions 3"
```

---

## Milestone Management

### /cgsd:new-milestone [name]
Start a new milestone cycle with fresh requirements and roadmap.

**Flow:** Questions → Research → Requirements → Roadmap

**When to use:** Starting v2, v3, or a new major release.

**Invocation:**
```bash
claude -p "/cgsd:new-milestone v2"
```

---

### /cgsd:complete-milestone [version]
Archive the completed milestone and tag the release.

**Invocation:**
```bash
claude -p "/cgsd:complete-milestone v1"
```

---

### /cgsd:audit-milestone [version]
Verify the milestone achieved its definition of done.

**Invocation:**
```bash
claude -p "/cgsd:audit-milestone v1"
```

---

### /cgsd:plan-milestone-gaps
Create phases to close gaps identified by milestone audit.

**When to use:** After audit reveals incomplete requirements.

**Invocation:**
```bash
claude -p "/cgsd:plan-milestone-gaps"
```

---

## Session Commands

### /cgsd:progress
Show current project status and route to the next action.

**Invocation:**
```bash
claude -p "/cgsd:progress"
```

---

### /cgsd:resume-work
Restore context from a previous session.

**When to use:** Continuing work after a break or context reset.

**Invocation:**
```bash
claude -p "/cgsd:resume-work"
```

---

### /cgsd:pause-work
Create a context handoff when pausing mid-phase.

**When to use:** Before stopping work to preserve state.

**Invocation:**
```bash
claude -p "/cgsd:pause-work"
```

---

### /cgsd:map-codebase
Analyze an existing codebase before planning.

**When to use:** Brownfield projects—before /cgsd:new-project.

**Output:** Creates `.planning/codebase/` with STACK.md, ARCHITECTURE.md, etc.

**Invocation:**
```bash
claude -p "/cgsd:map-codebase"
```

---

## Utility Commands

### /cgsd:quick
Execute an ad-hoc task with CGSD guarantees (atomic commits, state tracking) but skip optional agents.

**When to use:** Small tasks that don't need full planning.

**Invocation:**
```bash
claude -p "/cgsd:quick Add a health check endpoint"
```

---

### /cgsd:debug [description]
Systematic debugging with persistent state across context resets.

**When to use:** Investigating bugs that require multiple attempts.

**Invocation:**
```bash
claude -p "/cgsd:debug Login fails with 500 error"
```

---

### /cgsd:add-todo
Capture an idea or task for later work.

**Invocation:**
```bash
claude -p "/cgsd:add-todo Add rate limiting to API"
```

---

### /cgsd:check-todos [area]
List pending todos and select one to work on.

**Invocation:**
```bash
claude -p "/cgsd:check-todos"
```

---

### /cgsd:settings
Configure CGSD workflow toggles and model profile.

**Invocation:**
```bash
claude -p "/cgsd:settings"
```

---

### /cgsd:set-profile [profile]
Quick switch model profile (quality/balanced/budget).

**Profiles:**
- `quality` - Opus for planning and execution (max reasoning)
- `balanced` - Opus planning, Sonnet execution (default)
- `budget` - Sonnet/Haiku throughout (conserve tokens)

**Invocation:**
```bash
claude -p "/cgsd:set-profile quality"
```

---

### /cgsd:help
Show the CGSD command reference.

**Invocation:**
```bash
claude -p "/cgsd:help"
```

---

### /cgsd:update
Update CGSD to the latest version with changelog display.

**Invocation:**
```bash
claude -p "/cgsd:update"
```
