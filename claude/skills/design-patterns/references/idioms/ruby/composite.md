# Composite — Ruby

Include `Enumerable` on composite nodes. Leaves and containers share the same interface.

```ruby
class FileItem
  attr_reader :name, :size

  def initialize(name, size) = (@name, @size = name, size)
  def total_size = size
end

class Directory
  include Enumerable
  attr_reader :name

  def initialize(name) = (@name, @children = name, [])
  def <<(child) = tap { @children << child }
  def each(&block) = @children.each(&block)
  def total_size = sum(&:total_size)
end
```

**Reach for**: `Enumerable` on composites, `<<` for adding children, `Set` for unique children

**Avoid**:
- Giving leaves child-management methods (`add`, `remove`)
- Forgetting recursive delegation in aggregate operations
