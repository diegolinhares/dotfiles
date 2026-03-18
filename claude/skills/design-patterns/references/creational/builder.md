# Builder

Build complex objects step by step instead of cramming everything into one constructor call.

## The problem you feel

`Report.new(title, subtitle, header, footer, font, page_size, margins, landscape, watermark)` — nine parameters, you can't remember which order, and you only need three. Or worse, boolean flags: `Connection.new(host, true, false, true)` — what do those mean? The constructor is impossible to read and easy to misuse.

## How it works

Replace the mega-constructor with named step methods that each set one thing. `ReportBuilder.new.title("Q1").font("Helvetica").landscape(true).build`. Each step returns the builder so you can chain. The final `.build` validates and produces the finished object. You name each piece as you go instead of rattling off nine things in a breath and hoping the order is right.

## You need this when

- Constructors with 4+ parameters or boolean flags
- Objects requiring multi-step configuration before they are usable
- Configuration options growing unwieldy
- Different representations of the same construction process

## The trap

- Creating a builder for objects with fewer than 4 parameters. Use keyword arguments instead.
- Forgetting to return the builder from each step method, breaking the fluent chain.
- Mutable builders shared across threads without safeguards.
