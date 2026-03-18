# Visitor

Add new operations to a set of classes without modifying them.

## The problem you feel

You have Employee types: Manager, Engineer, Intern. You need a salary report. Then a tax calculator. Then an org chart builder. Each new operation means adding a method to every Employee class. The classes keep growing with unrelated responsibilities — salary logic, tax logic, reporting logic all living in the same file.

## How it works

Instead of adding methods to each class, create a separate object for each operation (the "visitor"). Each class has one `accept(visitor)` method that says "I'm a Manager, visit me." The visitor has a method per type — `visit_manager`, `visit_engineer`. New operation? Add a new visitor. No existing classes change. Building inspections work this way — each building opens its doors, the inspector applies their expertise per building type. Need a fire check? Send that inspector. Need electrical? A different one. The buildings never change.

## You need this when

- Adding operations to a class hierarchy without modifying the classes
- Type-checking across multiple methods to decide behavior
- AST or tree processing where node types are stable but operations change frequently
- Cleaning up auxiliary behaviors from business logic

## The trap

- Using Visitor when the node hierarchy changes frequently. Every new node type requires updating every visitor.
- Excessive ceremony when simple dispatch or pattern matching would be cleaner.
- Not handling unknown element types with a fallback.
