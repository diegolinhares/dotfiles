# Prototype

Create new objects by copying an existing one instead of building from scratch.

## The problem you feel

You create quarterly reports that are 90% identical — same template, same metadata, same structure. Only a few fields change. Rebuilding from scratch every time means repeating the same 15 constructor arguments. It's wasteful and error-prone when the template evolves.

## How it works

Create one "template" object with the common configuration. When you need a new one, copy the template and change what's different. Like photocopying a form and filling in the blanks, instead of redrawing the form every time. The critical detail: default copy is shallow — nested objects share references. If the copy modifies a nested hash, the original changes too. You must explicitly deep-copy mutable internals.

## You need this when

- Creating multiple similar objects differing in only a few attributes
- Complex initialization to perform once, then replicate
- Repeated construction calls with the same arguments and minor variations
- Need to reduce subclass proliferation for configuration presets

## The trap

- Forgetting that default clone/copy is shallow. Nested mutable objects share references unless you implement deep copy.
- Using serialization-based deep copy on objects with non-serializable fields (closures, file handles, connections).
- Not freezing prototypes — if consumers mutate the original template, all future copies are wrong.
