# Adapter — Ruby

Use `Forwardable` for explicit delegation. Reserve `method_missing` for truly dynamic APIs.

```ruby
require "forwardable"

class UnifiedPrinter
  extend Forwardable

  def initialize(legacy_printer)
    @legacy_printer = legacy_printer
  end

  def_delegator :@legacy_printer, :print_document, :print
end
```

For many-method adapters, `SimpleDelegator` passes everything through and lets you override selectively.

**Reach for**: `Forwardable`/`def_delegator`, `SimpleDelegator`, `respond_to_missing?` with `method_missing`

**Avoid**:
- `method_missing` when methods are known at load time — use `Forwardable`
- Forgetting `respond_to_missing?` alongside `method_missing`
- Subclassing the adaptee — adapters compose, not inherit
