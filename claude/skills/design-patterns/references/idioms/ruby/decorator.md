# Decorator — Ruby

`SimpleDelegator` for wrapping instances at runtime. `Module#prepend` for class-level decoration.

```ruby
require "delegate"

class WithMilk < SimpleDelegator
  def cost = super + 0.5
  def description = "#{super}, milk"
end

drink = WithMilk.new(Coffee.new)
```

Module-based with `prepend`:

```ruby
module Auditable
  def save
    result = super
    AuditLog.record(self) if result
    result
  end
end

class Order
  prepend Auditable
end
```

**Reach for**: `SimpleDelegator`, `Module#prepend`, `Forwardable` for selective decoration, `DelegateClass(Target)` for strict typing

**Avoid**:
- Inheritance instead of delegation
- Stacking too many decorators — keep chains short
- `class` on `SimpleDelegator` returns the wrapper's class — use `__getobj__.class` for the original
