# Builder — Ruby

`yield self` in the constructor for block-style. Return `self` from setters for chaining.

```ruby
class QueryBuilder
  attr_reader :conditions, :ordering, :result_limit

  def initialize
    @conditions, @ordering, @result_limit = [], nil, nil
    yield self if block_given?
  end

  def where(condition) = tap { @conditions << condition }
  def order(field) = tap { @ordering = field }
  def limit(n) = tap { @result_limit = n }

  def to_sql
    sql = "SELECT * FROM records"
    sql += " WHERE #{@conditions.join(' AND ')}" if @conditions.any?
    sql += " ORDER BY #{@ordering}" if @ordering
    sql += " LIMIT #{@result_limit}" if @result_limit
    sql
  end
end

query = QueryBuilder.new { |q| q.where("active = true").order("name").limit(10) }
```

**Reach for**: `yield self`, method chaining via `tap`/`self`, `Data.define#with` for immutable products, keyword args with defaults as simpler alternative

**Avoid**:
- Builders for < 4 parameters — use keyword arguments
- Forgetting to return `self` from setters
- Mutable builders shared across threads
