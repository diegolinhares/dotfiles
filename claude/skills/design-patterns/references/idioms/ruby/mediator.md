# Mediator — Ruby

Event bus with `Hash.new` auto-init. Rails: `ActiveSupport::Notifications`.

```ruby
class EventBus
  def initialize = @listeners = Hash.new { |h, k| h[k] = [] }
  def subscribe(event, &handler) = @listeners[event] << handler

  def publish(event, **payload)
    @listeners[event].each { |h| h.call(payload) }
  end
end

bus = EventBus.new
bus.subscribe(:order_placed) { |data| puts "Confirm #{data[:order_id]}" }
bus.publish(:order_placed, order_id: 42)
```

**Reach for**: `Hash.new { |h, k| h[k] = [] }`, `ActiveSupport::Notifications`, blocks/Procs as callbacks

**Avoid**:
- Global mediator for everything — scope to bounded contexts
- Forgetting to unsubscribe — causes memory leaks with long-lived subscribers
- Synchronous dispatch for slow work — consider async
