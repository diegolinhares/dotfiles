# Bridge — Ruby

Inject the implementation through the constructor. Duck typing makes bridges natural.

```ruby
class Notification
  def initialize(sender)
    @sender = sender
  end

  def send(recipient, message)
    @sender.deliver(recipient, message)
  end
end

class UrgentNotification < Notification
  def send(recipient, message)
    super(recipient, "URGENT: #{message}")
  end
end

# Any notification × any sender
UrgentNotification.new(SmsSender.new).send("+1234", "Server down")
```

**Reach for**: Constructor injection, duck typing, `extend` with module at instance level, Procs for single-method bridges

**Avoid**:
- Over-engineering with only one implementation — YAGNI
- Inheritance for both dimensions — use composition on at least one axis
