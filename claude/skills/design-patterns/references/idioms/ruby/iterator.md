# Iterator — Ruby

Include `Enumerable` and define `each`. Return `enum_for` when no block given.

```ruby
class FileLines
  include Enumerable

  def initialize(path) = @path = path

  def each(&block)
    return enum_for(:each) unless block_given?
    File.foreach(@path, &block)
  end
end

lines = FileLines.new("/var/log/app.log")
lines.select { |l| l.include?("ERROR") }
lines.lazy.first(5)
```

**Reach for**: `Enumerable` + `each`, `enum_for`/`to_enum`, `Enumerator.new` for custom sequences, `Enumerator::Lazy` for deferred pipelines

**Avoid**:
- Forgetting `return enum_for(:method_name) unless block_given?` — breaks chaining
- `all.each` on ActiveRecord — use `find_each` for large tables
