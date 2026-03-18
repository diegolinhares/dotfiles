# Factory Method

Ask for what you need, not how to build it. Put the "which class?" decision in one place.

## The problem you feel

Your code is littered with `case type when :stripe then StripeProcessor.new when :paypal then PaypalProcessor.new end`. Adding a new payment provider means finding and updating every switch statement. Callers know too much about which concrete classes exist, and that knowledge is scattered across files.

## How it works

Move the "which class?" decision into a single method that returns the right object. Callers say `PaymentProcessor.for(:stripe)` and get back something that responds to `charge`. They never import or name the concrete class. Like ordering from a menu — you ask for "espresso" and the barista figures out which machine and technique to use. Your relationship is with the menu, not the equipment.

## You need this when

- Boolean parameters controlling constructor behavior (`Connection.new(host, true)`)
- Conditional chains selecting which class to instantiate scattered across call sites
- Callers needing to know concrete class names when they should not
- Library or framework needs to let users extend internal components

## The trap

- Over-engineering with factory classes when a simple class method suffices.
- Using dynamic class resolution on unsanitized user input (code injection risk).
- Creating factories for classes with trivial constructors.
