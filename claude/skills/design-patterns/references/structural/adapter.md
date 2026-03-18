# Adapter

Your code speaks one language, the library speaks another. The adapter is a translator sitting between them.

## The problem you feel

You're integrating a third-party library, but its API doesn't match what your code expects. You can't change the library (closed source or shared dependency), and rewriting all your callers is impractical. So you end up with `if library_a ... else library_b` scattered everywhere.

## How it works

You create a thin wrapper object. Its public methods match what YOUR code already calls. Inside, each method just calls the equivalent method on the foreign object, translating arguments and return values as needed. Like a power plug adapter when traveling — your plug doesn't change, the adapter handles the conversion. Your code never knows it's talking to something incompatible.

## You need this when

- Multiple conditional branches selecting behavior based on which external library is in use
- Wrapper methods that just translate method names between two objects
- Tight coupling to a specific vendor's API scattered across multiple files
- Need to swap implementations without changing client code

## The trap

- Over-abstraction. Don't create an adapter with only one implementation and no prospect of a second. YAGNI applies.
- Leaking the adaptee. Exposing the wrapped object's original interface alongside the new one defeats the purpose.
- Deep inheritance hierarchies when simple delegation gets the job done.
