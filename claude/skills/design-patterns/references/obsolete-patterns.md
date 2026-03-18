# Patterns removed from this skill and why

Nine of the original 23 GoF patterns were cut. Some because modern languages absorbed them, others because they turned out to be anti-patterns or needless ceremony. Each removal is backed by academic studies, practitioner experience, or both.

---

## Absorbed by modern languages

### Iterator

Every mainstream language now has a native iteration protocol: Python's `__iter__`/`__next__`, Java's `Iterable`/`Stream`, Rust's `Iterator` trait, JavaScript's `Symbol.iterator`, Ruby's `Enumerable`, C#'s `IEnumerable`/`yield`. The pattern won -- it became infrastructure. There is nothing left to implement by hand.

Norvig (1996) classified Iterator as subsumed by macros in Lisp. The Python Patterns Guide (python-patterns.guide) documents the absorption across languages. endjin (2024), "C# Design Patterns: Iterator as Language Feature," traces the same path in C#.

### Visitor

Visitor is a workaround for languages that lack pattern matching. Seemann proved it is isomorphic to Church encoding -- the OOP way to destructure a sum type. Languages with pattern matching over sealed/algebraic types (Rust `match`, Java 21+ `switch`, Kotlin `when`, Ruby 3.0+ `case/in`, Scala `match`) make the `accept`/`visit_*` protocol unnecessary.

Parlog (nipafx.dev, 2021) titled his analysis "Visitor Pattern Considered Pointless -- Use Pattern Switches Instead." Vokac et al. (Empirical Software Engineering, 2004) ran a controlled experiment and found Visitor "caused much confusion" among professional developers.

### Prototype

Most languages have native cloning: Ruby's `dup`/`clone`, Kotlin's `data class copy()`, Rust's `#[derive(Clone)]`, JavaScript's `structuredClone()`, Python's `copy.deepcopy()`. Calling a built-in copy method is not a design pattern.

Bloch ("Effective Java") documents how Java's `Cloneable` is broken and recommends copy constructors instead. Refactoring Guru acknowledges that languages with native cloning absorb the pattern entirely.

### Flyweight

Modern languages handle the common cases automatically: string interning, small integer caching, frozen/immutable value types. The only remaining use for a manual Flyweight pool is extreme performance work where you have measured allocation as the bottleneck -- and at that point you are doing optimization, not design.

The GoF authors themselves (InformIT, 2009) said they would demote Flyweight to an "Other/Compound" category. Norvig (1996) classified it as subsumed by first-class types. patterns.dev notes modern usage is limited to game engines and rendering pipelines.

---

## Anti-patterns or over-engineering

### Singleton

Erich Gamma, one of the four authors of the GoF book, said in 2009: "I'm in favor of dropping Singleton. Its use is almost always a design smell." On SE Radio (2014) he added: "It's very easy to add global state, but it's very hard to take it out."

The problems: hidden global state, test pollution, SRP and DIP violations, thread-safety minefields. Vokac (IEEE TSE, 2004) found Singleton correlated with more defect-prone code. Hevery (Google Testing Blog, 2008) traced untestable code back to global state repeatedly. Radford (ACCU Overload Journal, 2003) titled his article "SINGLETON: the anti-pattern!" Modern alternative: let a DI container manage singleton scope, or use the language's module system.

### Builder

Languages with named/default parameters (Kotlin, Python, Ruby, Swift, C#) make Builder unnecessary for the common case. The pattern still makes sense for incremental construction where steps happen at different times, but that is the exception.

Kotlin Academy (2018) demonstrates this in "Effective Java in Kotlin." Norvig (1996) classified Builder as subsumed by multimethods.

### Bridge

Bridge decouples an abstraction hierarchy from its implementation hierarchy so both can vary independently. In duck-typed or structurally-typed languages (Ruby, Python, Go, TypeScript), you get this for free: inject any object that responds to the right messages. That is just dependency injection, and it does not need a GoF name.

Ayende Rahien (2013) reviewed Bridge in his "Design Patterns in the Test of Time" series and wrote: "I can't think of a time when I used this approach."

### Interpreter

Internal DSLs built with blocks, macros, or metaprogramming have replaced the GoF expression-tree approach in most ecosystems. For anything that needs a real grammar, parser combinators (nom, Parsec) or parser generators (ANTLR, Treetop) are better tools.

The GoF authors (InformIT, 2009) would demote Interpreter to a peripheral category. Norvig (1996) classified it as subsumed by macros.

### Mediator

A centralized mediator tends to grow into a God Object. Most frameworks already ship event/notification systems that cover the pub/sub use case without a hand-rolled Mediator layer.

Ayende Rahien (2013): "in practice almost all known cases are bad ones." Martini (arialdomartini.github.io) wrote "You Probably Don't Need MediatR," a detailed critique of the most popular Mediator implementation in .NET.

---

## Academic context

These removals line up with what the research says about pattern overuse:

Khomh and Gueheneuc (CSMR, 2008), "Do Design Patterns Impact Software Quality Positively?" -- found that pattern-involved classes negatively impact several quality attributes and recommended "cautious use of design patterns to avoid unnecessary increases in class complexity."

Wendorff (IEEE, 2001), "Assessment of Design Patterns during Software Reengineering" -- reported that uncontrolled pattern use contributed to severe maintenance problems in a large commercial project.

Bijlsma, Stuurman et al. (Software: Practice and Experience, 2022), "Evaluation of Design Pattern Alternatives in Java" -- found that patterns dealing with algorithms and functions (Strategy, Template Method) are good candidates for replacement by functional language features.

Maier, Rompf, and Odersky (EPFL, 2010), "Deprecating the Observer Pattern" -- argued that programming interactive systems with Observer is "hard and error-prone." This work directly influenced Reactive Extensions (Rx).

Walter et al. (PLOS ONE, 2020), "Empirical Study of the Relationship between Design Patterns and Code Smells" -- found that patterns reduce code smells but increase software size (SLOC) and CK complexity metrics.

---

## Norvig's thesis

In 1996, Peter Norvig showed that 16 of the 23 GoF patterns become "invisible or simpler" in languages with first-class functions, first-class types, macros, and multimethods. Most modern languages have all four.

His point: patterns compensate for missing language features. They are not universal truths about software design.

| Language feature | Patterns it replaces |
|---|---|
| First-class functions (closures, lambdas, blocks) | Command, Strategy, Template Method, Visitor |
| First-class types (classes/types as values) | Abstract Factory, Factory Method, State, Proxy, Chain of Responsibility, Flyweight |
| Macros / metaprogramming | Interpreter, Iterator |
| Module systems | Facade, Singleton |

Source: Norvig, P. (1996). "Design Patterns in Dynamic Languages." norvig.com/design-patterns/
