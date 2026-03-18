# Proxy

A stand-in that looks identical to the real thing but adds a layer of control.

## The problem you feel

You initialize a heavy database object at startup even though it's only needed 10% of the time. Or you duplicate access-control checks before every method call. Or you're writing cache logic inside business methods. The cross-cutting concern is tangled into the core code.

## How it works

Create an object with the exact same interface as the real one. Callers can't tell the difference. Inside, the proxy decides: lazy-load the real object on first use (virtual proxy), check permissions before delegating (protection proxy), or return cached results (caching proxy). Like a credit card — same "payment" interface as cash, but the bank approves, logs, and limits the transaction transparently.

## You need this when

- Expensive object initialization happening before the object is actually needed
- Access control logic duplicated across multiple call sites
- Logging or caching logic mixed into core object methods
- Code manually checking "is it loaded?" before every access

## The trap

- Silent behavior changes. A proxy should be transparent. If it behaves unexpectedly differently from the real object, it violates substitutability.
- Forgetting to forward all interface methods. Missing methods break the illusion.
- Proxy on hot paths without measuring. Each layer of indirection costs something.
