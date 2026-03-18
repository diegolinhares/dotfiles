# Prototype — Ruby

`dup` for shallow copy, `clone` for frozen/singleton copy. Override `initialize_copy` for deep copy.

```ruby
class Document
  attr_accessor :title, :content, :metadata

  def initialize(title:, content:, metadata: {})
    @title, @content, @metadata = title, content, metadata
  end

  def initialize_copy(source)
    @metadata = source.metadata.dup
    @title = source.title.dup
    @content = source.content.dup
  end
end

template = Document.new(title: "Report", content: "Revenue: $__", metadata: { dept: "finance" })
q1 = template.dup
q1.title = "Q1 Report"
```

For immutable value objects, `Data.define#with` is the native prototype:

```ruby
Point = Data.define(:x, :y)
origin = Point.new(x: 0, y: 0)
moved = origin.with(x: 5) # => Point(x: 5, y: 0)
```

**Reach for**: `dup` (most common), `clone`, `initialize_copy`, `Data.define#with` for immutable copies

**Avoid**:
- Forgetting `initialize_copy` for nested mutable state — default `dup` is shallow
- `Marshal.dump`/`load` on objects with Procs/IO — raises TypeError
- Mutating the prototype — keep prototypes frozen
