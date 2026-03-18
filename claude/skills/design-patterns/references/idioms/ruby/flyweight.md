# Flyweight — Ruby

Frozen strings, symbols, and integers are natural flyweights. For custom objects, use a Hash pool.

```ruby
class Color
  POOL = {}

  attr_reader :r, :g, :b

  def initialize(r, g, b)
    @r, @g, @b = r, g, b
    freeze
  end

  def self.of(r, g, b)
    POOL["#{r},#{g},#{b}"] ||= new(r, g, b)
  end
end

Color.of(255, 0, 0).equal?(Color.of(255, 0, 0)) # => true
```

**Reach for**: Symbols (always interned), `freeze`, `# frozen_string_literal: true`, Hash as pool, `Data.define` for immutable value objects

**Avoid**:
- Pooling mutable objects — flyweights must be immutable
- Unbounded pool growth — add eviction or scope to known values
- Pooling cheap-to-create objects — only when allocation cost is measurable
