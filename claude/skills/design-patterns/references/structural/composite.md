# Composite

Treat "one thing" and "a group of things" with the exact same interface.

## The problem you feel

You have a file system with files and folders. Every operation — size, permissions, display — starts with `if folder? then recurse else handle_file`. Add a new operation, write the same branch again. The type-checking multiplies with every feature.

## How it works

Give single items and containers the same interface. A file has `total_size`. A folder also has `total_size` — it just sums its children's. The caller never asks "are you a file or folder?" It just calls `total_size` and the right thing happens at every level of nesting. Like military orders cascading down a hierarchy — divisions, brigades, platoons all respond to "advance" without the general specifying each unit's type.

## You need this when

- Repeated type checks when processing hierarchical data
- Methods that manually recurse through nested structures with different logic at each level
- Code treating a single item and a group of items with entirely different APIs
- Core model representable as a tree structure

## The trap

- Separate Leaf and Composite classes when a single class with an empty children list would suffice.
- Type checking within the composite. Checking whether a child is a leaf or composite defeats the uniform interface.
- Exposing tree management methods (add, remove) on leaf nodes where they make no sense.
