# Strategy

Swap out the algorithm without changing the code that uses it.

## The problem you feel

Your checkout code has `if discount_type == "flat" ... elsif discount_type == "percent" ... elsif discount_type == "bogo"`. Adding a new discount type means editing the checkout. The algorithm selection is tangled with the business logic that uses the result. Every new variant makes the conditional longer and riskier to change.

## How it works

Extract each algorithm into its own object with the same interface (e.g., a `call(price)` method). The checkout receives whichever strategy it needs and calls it — it doesn't know or care which one it got. Like choosing how to get to the airport: bus, taxi, or bike. The trip planner just needs something that gets you there. Swap the transport without rewriting the itinerary. The choice happens outside; the execution is uniform inside.

## You need this when

- Conditional branches selecting an algorithm variant
- Duplicated code differing only in a small algorithmic step
- Methods with format or type parameters controlling behavior
- Need to swap algorithms at runtime

## The trap

- Strategy class hierarchies when a simple function or closure suffices. If it's one method with no state, use a lambda.
- Strings to select strategies instead of passing the callable object directly.
- Strategy classes with multiple public methods. They should have one entry point.
