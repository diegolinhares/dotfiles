# Chain of Responsibility

Pass a request down a line of handlers until one of them deals with it.

## The problem you feel

Your authentication check calls an authorization check, which calls a rate limiter, which calls a validator... Nested `if/elsif` chains grow into unreadable spaghetti. Adding a new check means modifying the middle of the chain. Removing one breaks others. The checks can't be reused across different endpoints.

## How it works

Each handler has the same interface: receive a request, either handle it or pass it to the next handler. They're linked like a chain. The request flows until someone handles it or it falls off the end. Like tech support escalation — automated FAQ first, then human agent, then engineer. Each level either solves the problem or passes it up. You can reorder, add, or remove handlers without touching the others.

## You need this when

- Nested conditional chains deciding who handles a request
- Multiple objects each partially processing data before passing it on
- Before/after hooks wrapping an inner operation
- Set of handlers and their order need to change at runtime

## The trap

- Chains that silently swallow requests without logging or raising.
- Overly long chains where a simple method call would suffice.
- No terminal handler, so the chain falls off the end returning nothing.
