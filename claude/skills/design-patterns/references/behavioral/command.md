# Command

Turn an action into an object you can store, queue, pass around, or undo.

## The problem you feel

Your controller directly calls business logic. Now you need to queue that same action for later. Or log it. Or undo it. The action isn't a "thing" you can manipulate — it's just a method call that vanishes after execution. And the same business logic is needed in three places, so it's getting copy-pasted.

## How it works

Wrap the action in an object with a single entry point method (like `call` or `execute`). The object carries everything needed to perform the action. Now you can put it in a queue, store it in a history for undo, retry it on failure, or serialize it for background processing. A restaurant order slip works the same way — the request becomes a physical thing the kitchen can process, prioritize, or cancel. The slip exists independently of whoever wrote it.

## You need this when

- Methods that need to be queued, logged, retried, or undone
- Callback chains growing complex and hard to reason about
- Controller actions with business logic that should be extractable
- Need for undo/redo functionality

## The trap

- Command classes for trivial one-liners where a function or closure suffices.
- Using closures when state tracking is needed (undo). Use classes instead.
- Commands with multiple public methods. They should have one entry point.
