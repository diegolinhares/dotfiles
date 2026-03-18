# Factory Method — Ruby

Class methods that return instances. Registry hash for open/closed factories.

```ruby
class PaymentProcessor
  REGISTRY = {}

  def self.register(name, klass) = REGISTRY[name] = klass
  def self.for(name) = REGISTRY.fetch(name) { raise "Unknown: #{name}" }
end

class StripeProcessor
  PaymentProcessor.register(:stripe, self)
  def charge(amount) = # ...
end

class PaypalProcessor
  PaymentProcessor.register(:paypal, self)
  def charge(amount) = # ...
end

processor = PaymentProcessor.for(:stripe)
```

**Reach for**: `case/in` for config-driven selection, class methods (`.for`, `.build`), `const_get` for convention-based factories, registry Hash

**Avoid**:
- `eval` or `constantize` on user input — use registry or whitelist
- Factories for a single product — use a plain constructor
- Returning objects with incompatible interfaces from the same factory
