# Observer — Ruby

Stdlib `Observable` module. Rails: `after_commit` callbacks, `ActiveSupport::Notifications`.

```ruby
require "observer"

class Inventory
  include Observable

  def initialize = @stock = Hash.new(0)

  def receive(item, qty)
    @stock[item] += qty
    changed
    notify_observers(item, @stock[item])
  end
end

class StockAlert
  def update(item, qty)
    puts "LOW STOCK: #{item}" if qty < 5
  end
end

inventory = Inventory.new
inventory.add_observer(StockAlert.new)
inventory.receive("widgets", 10)
```

**Reach for**: `Observable` module, `ActiveSupport::Notifications`, `after_commit` for DB-level observation, blocks as lightweight listeners

**Avoid**:
- `after_save`/`after_create` as general observer — couples business logic to persistence
- Forgetting `changed` before `notify_observers`
- Circular observer chains (A observes B observes A) — causes infinite loops
