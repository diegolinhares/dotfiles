# Mediator

Instead of objects talking to each other directly, they all talk through one coordinator.

## The problem you feel

Component A calls B, which calls C, which calls A back. Everything depends on everything. Change one component and three others break. You can't test A without dragging in B, C, and D. The dependency graph looks like a plate of spaghetti.

## How it works

Remove direct references between components. Each component only knows the mediator. When A needs something from B, it sends a message to the mediator. The mediator routes it to B. Air traffic control works this way — planes never talk to each other, everything goes through the tower. New airline? It just needs to talk to the tower, not every other plane. The coupling moves from many-to-many (chaos) to many-to-one (manageable).

## You need this when

- Objects directly calling methods on many other objects to coordinate behavior
- Circular dependencies between collaborators
- Components that cannot be reused due to excessive dependencies
- One model change triggering actions in unrelated subsystems

## The trap

- Event buses that make debugging impossible because events fire silently with no trace.
- Synchronous mediators blocking on slow subscribers when async would be better.
- Mediator evolving into a God Object that knows too much and does too much.
