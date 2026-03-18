# Singleton

Exactly one instance of something, accessible from anywhere. The pattern you should reach for last, not first.

## The problem you feel

Your app needs one configuration object, one database pool, one logger. Without control, different parts of the code create their own instances — three database pools fighting for connections, two conflicting configurations. Or you use global variables, which are impossible to test and reset.

## How it works

The class itself controls its own instantiation. The first request creates the instance; subsequent requests get the same one back. But let's be honest: it's a global variable wearing a disguise. In most cases, you're better off creating the object once at boot and passing it where needed (dependency injection). Singleton is for when you truly need globally coordinated access to a single shared resource and DI is impractical.

## You need this when

- Shared resource that must have exactly one instance (database pool, configuration)
- Need stricter control over global variables
- Want lazy initialization, where the object is created only when first requested

## The trap

- Using Singleton when dependency injection would be simpler and more testable.
- Singletons with mutable state and no thread-safety protections. In threaded servers this creates race conditions.
- Not providing a way to reset or inject alternatives in tests.
- Using Singleton for things that might need multiple instances later.
