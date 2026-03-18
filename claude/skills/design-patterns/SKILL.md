---
name: design-patterns
description: "Analyze code for design pattern opportunities. 10 core patterns + 4 modernized alternatives. Use when reviewing architecture, planning refactors, or when user asks 'which pattern', 'how to structure this', or mentions design patterns."
---

# Design patterns analyzer

Spot design pattern opportunities in code. 9 of the original 23 GoF patterns were removed for being obsolete, absorbed by modern languages, or anti-patterns. See [obsolete-patterns.md](./references/obsolete-patterns.md) for why.

## Workflow

1. Read the code under analysis
2. Match code smells to candidates using the tables below
3. Load ONLY the matched pattern reference (`references/<category>/<pattern>.md`)
4. If the project language has an idiom file (`references/idioms/<lang>/<pattern>.md`), load that too
5. Show findings with before/after sketches using actual classes from the codebase
6. Wait for user input before changing anything

Do NOT pre-load all references. Load one pattern at a time as needed.

## Smell-to-pattern tables

### Core patterns (10)

| Code Smell | Pattern | Ref |
|---|---|---|
| `if/case` branches selecting by vendor/library | Adapter | `structural/adapter.md` |
| Wrapper methods translating names between objects | Adapter | `structural/adapter.md` |
| Type checks on hierarchies (`if collection? ... else ...`) | Composite | `structural/composite.md` |
| Manual recursion through nested structures | Composite | `structural/composite.md` |
| Model mixing domain + presentation logic | Decorator | `structural/decorator.md` |
| `formatted_*`, `display_*` methods on models | Decorator | `structural/decorator.md` |
| Subclass explosion differing only in behavior layers | Decorator | `structural/decorator.md` |
| Controller/handler > 10 lines assembling data | Facade | `structural/facade.md` |
| Client calling subsystem objects in specific order | Facade | `structural/facade.md` |
| Boolean params controlling constructor behavior | Factory Method | `creational/factory-method.md` |
| `case/if` chains selecting which class to instantiate | Factory Method | `creational/factory-method.md` |
| Multiple related objects always created together | Abstract Factory | `creational/abstract-factory.md` |
| Config switches selecting families of objects | Abstract Factory | `creational/abstract-factory.md` |
| Nested `if/elsif` deciding who handles a request | Chain of Resp. | `behavioral/chain-of-responsibility.md` |
| Before/after hooks wrapping an inner operation | Chain of Resp. | `behavioral/chain-of-responsibility.md` |
| Methods that need queuing, logging, retry, or undo | Command | `behavioral/command.md` |
| Callback chains growing out of control | Command | `behavioral/command.md` |
| `if status == "x"` / `case state` scattered across methods | State | `behavioral/state.md` |
| Boolean flag proliferation (`is_active`, `is_published`) | State | `behavioral/state.md` |
| Multiple classes with nearly identical method sequences | Template Method | `behavioral/template-method.md` |
| Copy-paste code where structure is same but details vary | Template Method | `behavioral/template-method.md` |

### Modernized alternatives (4)

These smells map to valid concepts, but the GoF class-hierarchy form is obsolete in most modern languages. Check the language idiom file for the right implementation.

| Code Smell | Concept | GoF name | Note |
|---|---|---|---|
| `case/if` selecting an algorithm variant | Callable injection | Strategy | Pass a function/lambda/block, not a class hierarchy |
| Duplicated code differing in one algorithmic step | Callable injection | Strategy | Extract the varying step as a function parameter |
| One change triggering side effects in unrelated subsystems | Reactive patterns | Observer | Use language/framework event system, not hand-rolled pub/sub |
| Expensive initialization before object is actually needed | Lazy delegation | Proxy | Prefer explicit delegation over transparent proxying |
| Undo/redo or audit trail requirements | Immutable snapshots | Memento | Prefer event sourcing or immutable state over full-object snapshots |

## Report format

```
## Design pattern analysis
### What I looked at
[One paragraph]
### Findings
#### 1. [Pattern] for [Target class/module]
- Smell / Now / Suggestion / Confidence / Payoff
### Considered but skipped
### Suggested order (by payoff-to-effort)
```

## Rules

- Load only the pattern you need, then its language idiom file. One at a time.
- Only suggest a pattern for a concrete smell. Three similar lines beats a premature abstraction.
- Name by role, not pattern: `UserPresenter` not `UserDecorator`, `PaymentGateway` not `PaymentAdapter`.
- Pick the highest-payoff pattern first.
- When two patterns look similar, load [cross-patterns.md](./references/cross-patterns.md).
- Never suggest removed patterns (Singleton, Iterator, Visitor, Prototype, Flyweight, Builder, Bridge, Interpreter, Mediator). Suggest the modern alternative instead. See [obsolete-patterns.md](./references/obsolete-patterns.md) if asked why.

## Reference paths

All references live under `./references/`. Load on demand, never all at once.

- Pattern docs: `<category>/<pattern>.md` (e.g. `structural/adapter.md`)
- Language idioms: `idioms/<lang>/<pattern>.md` (e.g. `idioms/ruby/adapter.md`)
- Disambiguation: `cross-patterns.md`
- Removal rationale: `obsolete-patterns.md`
