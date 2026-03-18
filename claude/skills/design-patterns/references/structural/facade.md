# Facade

One simple door into a complicated room.

## The problem you feel

Placing an order touches inventory, payment, shipping, email, and analytics. Your controller is 40 lines of orchestration calling five different services in the right sequence. Another controller needs the same flow and copies the code. Every caller duplicates the same multi-step coordination.

## How it works

Put the orchestration behind a single method on a single object. `OrderService.new(user, cart).place` replaces the 40 lines. Calling a restaurant for delivery works the same way — say what you want, the kitchen and driver figure out the rest. You don't phone the kitchen, then the driver, then the cashier. The subsystems still exist and remain accessible for advanced use cases.

## You need this when

- Client code longer than it should be because it orchestrates multiple subsystem objects
- Test setup requiring many collaborating objects for a single operation
- Client code calling subsystem objects in a specific order for correct results
- Multiple callers duplicating the same multi-step coordination logic

## The trap

- God object facade. If the facade grows too large, split it. One facade per logical operation.
- Facade with business logic. A facade should coordinate, not decide. Business rules belong in the domain layer.
- Hiding too much. Clients should still be able to access subsystem classes directly when they need fine-grained control.
