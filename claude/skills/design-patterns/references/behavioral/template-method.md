# Template Method

Define the skeleton of a process; let subclasses fill in the specific steps.

## The problem you feel

You have three importers — CSV, API, and XML. Each follows the same sequence: read, parse, transform, save. The structure is identical but the details of each step differ. You've copy-pasted the same flow three times, and now they're drifting apart. Fix a bug in the sequence and you need to fix it in three places.

## How it works

Put the shared sequence in a base class method. Mark the varying steps as abstract (override required) or provide sensible defaults (hook methods). Subclasses override only the steps that differ. The base class controls the flow, subclasses control the details. Think of a recipe — "prep, cook, plate" is fixed. Each chef follows that sequence but brings different ingredients and techniques to each step.

## You need this when

- Multiple classes with nearly identical method sequences differing in one or two steps
- Copy-paste code where the structure is the same but details vary
- Need extension points for optional behavior
- A fixed sequence of steps where individual steps need to be customizable

## The trap

- Deep inheritance hierarchies (more than two levels). Prefer composition or Strategy.
- Not providing hooks for optional steps, forcing subclasses to override more than they need.
- Using Template Method when Strategy would be simpler. One varying step doesn't justify inheritance.
