# Iterator

Walk through a collection's elements one at a time without knowing how the collection is built inside.

## The problem you feel

You're iterating with `for i in 0...array.length` — index math, off-by-one bugs. Or you have a tree structure and traversal logic is copy-pasted into every consumer. Or you load 10 million records into memory just to process them one at a time. The consumer is coupled to the collection's internal structure.

## How it works

The collection provides an object that knows how to step through elements one at a time. The consumer just asks "give me the next one" without knowing if it's an array, tree, database cursor, or paginated API. This enables lazy iteration — produce elements only as they're consumed, not all at once. Hit "next" on a playlist — you don't know or care how songs are stored or what picks the next one.

## You need this when

- Manual index-based loops over collections
- Methods returning full arrays when they could yield elements lazily
- Complex structures needing multiple traversal strategies
- Traversal logic duplicated across consumers of the same collection

## The trap

- Not supporting lazy iteration when the collection is large or infinite.
- Modifying the underlying collection during iteration.
- Exposing internal structure through the iterator interface.
