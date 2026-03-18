# When two patterns look the same

Use this when you've spotted a code smell but multiple patterns seem to fit. The key is asking the right question to tell them apart.

## Structural — they all wrap things, but why?

| Confused pair | Ask yourself |
|---|---|
| Adapter vs Bridge | Can you modify the source? **No, it's foreign code** → Adapter (retrofit). **Yes, designing from scratch** → Bridge (plan for two axes of change). |
| Adapter vs Facade | Wrapping **one object** to change its interface? → Adapter. Wrapping **a whole subsystem** behind one simple call? → Facade. |
| Adapter vs Proxy | Does the wrapper change the interface? **Different interface** → Adapter. **Same interface, adds control** (lazy load, cache, auth) → Proxy. |
| Decorator vs Proxy | Who decides to wrap? **The caller picks which layers** → Decorator. **The system manages it transparently** → Proxy. |
| Decorator vs Composite | Wrapping **one object** with extra behavior? → Decorator. Treating **a tree of objects** uniformly? → Composite. |
| Facade vs Mediator | **One-way** simplification (caller → subsystem)? → Facade. **Two-way** coordination (components ↔ hub ↔ components)? → Mediator. |
| Flyweight vs Singleton | **One** mutable instance globally → Singleton. **Many** immutable shared instances in a pool → Flyweight. |

## Creational — they all make objects, but how?

| Confused pair | Ask yourself |
|---|---|
| Factory Method vs Abstract Factory | Making **one type** of object? → Factory Method. Making a **matching family** that must stay consistent (bucket + file + CDN)? → Abstract Factory. |
| Builder vs Factory Method | **One call** creates it? → Factory Method. **Multiple steps** configure it before it's ready? → Builder. |
| Builder vs Prototype | Building **from scratch** step-by-step? → Builder. **Copying** an existing object and tweaking a few fields? → Prototype. |
| Prototype vs Singleton | **Many** copies from a template → Prototype. **Exactly one** instance, period → Singleton. |
| Abstract Factory vs Builder | Creates a **family of related objects at once**? → Abstract Factory. Builds **one complex thing step-by-step**? → Builder. |

## Behavioral — they all manage how objects talk, but what's the goal?

| Confused pair | Ask yourself |
|---|---|
| Strategy vs State | **Who decides** the behavior? Caller picks it from outside → Strategy. Object changes it internally based on its own state → State. |
| Strategy vs Template Method | Can you swap at **runtime** without changing the class? → Strategy (composition). Fixed at **class definition time** via subclassing? → Template Method (inheritance). |
| Command vs Strategy | Do you need to **undo, queue, or log** the action later? → Command. Just **swap which algorithm** runs? → Strategy. |
| Observer vs Mediator | Subscribers know the publisher and subscribe directly → Observer. Components only know the central hub, never each other → Mediator. |
| CoR vs Decorator | Can a handler **stop the chain** and return early? → Chain of Responsibility. Does every layer **always pass through** to the next? → Decorator. |
| Iterator vs Visitor | Goal is **walking through** elements one by one? → Iterator. Goal is **doing different things** to different element types? → Visitor. |
| Memento vs Command | Capturing a **snapshot of state** for rollback? → Memento. Capturing an **operation** for replay or undo? → Command. |

## Across categories

| Confused pair | Ask yourself |
|---|---|
| Factory Method vs Strategy | Making a **new object**? → Factory Method. Choosing an **algorithm to run**? → Strategy. Both use polymorphism, but for different goals. |
| Builder vs Composite | **Constructing** a tree step-by-step? → Builder. **Working with** an existing tree, treating nodes uniformly? → Composite. |
| Prototype vs Memento | Cloning to create **new independent objects**? → Prototype. Snapshotting to **restore the same object later**? → Memento. |
| Facade vs CoR | **One entry point**, everything behind it? → Facade. Request **flows through multiple handlers** that each decide whether to act? → CoR. |

## Quick flowchart

```
What is the primary goal?

CREATING objects?
├── One product type, varying by subclass? → Factory Method
├── Families of related products? → Abstract Factory
├── Complex object, step-by-step? → Builder
├── Copy existing object? → Prototype
└── Exactly one instance? → Singleton

STRUCTURING objects?
├── Make incompatible interface work? → Adapter
├── Simplify complex subsystem? → Facade
├── Add behavior without modifying original?
│   ├── Runtime, per-instance? → Decorator
│   └── Control access/lifecycle? → Proxy
├── Tree/hierarchical uniform interface? → Composite
├── Reduce memory for many similar objects? → Flyweight
└── Separate two dimensions of variation? → Bridge

MANAGING behavior?
├── Pass request through handlers? → Chain of Responsibility
├── Encapsulate request as object? → Command
├── Traverse collection? → Iterator
├── Reduce component coupling? → Mediator
├── Save/restore state? → Memento
├── Notify on changes? → Observer
├── Behavior changes with state? → State
├── Swap algorithms? → Strategy
├── Same structure, varying steps? → Template Method
└── Add operations to structure? → Visitor
```

## Common mistakes

1. Pattern naming as architecture. Prefer role names (`UserPresenter`, `LazyCollection`, `PaymentGateway`) over pattern names (`UserDecorator`, `PaymentAdapter`).

2. Over-engineering. Many patterns collapse into one or two lines in dynamic languages. Multi-class hierarchies for a simple problem are a smell.

3. Forcing patterns. Not every problem needs a GoF pattern. Sometimes a function, a closure, or a plain class is the right answer.

4. Choosing by similarity, not by goal. Adapter and Proxy both wrap objects, but they solve different problems. Use the flowchart above.
