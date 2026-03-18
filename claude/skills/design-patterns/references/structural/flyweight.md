# Flyweight

When thousands of objects share most of their data, store the shared part once and point to it.

## The problem you feel

You're rendering a map with 50,000 tree icons. Each tree stores its sprite, color, and texture — identical data repeated 50,000 times. Memory balloons. GC thrashes. The application slows to a crawl or crashes.

## How it works

Split each object into shared state (sprite, color, texture — same for all pine trees) and unique state (x, y position — different per tree). Store the shared state in a pool of frozen objects. Each tree holds just a reference to "pine tree type" plus its own coordinates. 50,000 objects drop from megabytes to kilobytes because they're mostly pointers. The critical rule: shared objects must be immutable, or one consumer's mutation corrupts them all.

## You need this when

- Creating thousands of similar objects where most state is identical
- High memory consumption from many small objects with overlapping data
- Profiling reveals garbage collection pressure from excessive allocations of near-identical objects

## The trap

- Mutable flyweights. Shared objects must be immutable. Mutating a shared flyweight corrupts all references.
- Premature optimization. Don't apply unless profiling shows a real memory problem.
- Complex extrinsic state management. If shared/unique state is hard to separate cleanly, the pattern adds complexity for little benefit.
