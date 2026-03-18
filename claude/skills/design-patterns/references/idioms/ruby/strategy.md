# Strategy — Ruby

Blocks for inline strategies, callable objects (`#call`) for configured ones.

```ruby
class FlatDiscount
  def initialize(amount) = @amount = amount
  def call(price) = [price - @amount, 0].max
end

class PercentDiscount
  def initialize(percent) = @percent = percent
  def call(price) = price * (1 - @percent / 100.0)
end

class ShoppingCart
  def initialize(pricing: ->(p) { p })
    @items = []
    @pricing = pricing
  end

  def add(item) = @items << item

  def total
    @pricing.call(@items.sum { |i| i[:price] })
  end
end

cart = ShoppingCart.new(pricing: PercentDiscount.new(20))
cart.add(name: "Widget", price: 100)
cart.total  # => 80.0
```

**Reach for**: Blocks for one-off strategies, `#call` protocol with `.()`, lambdas for stored strategies, `method(:name)` to convert methods to callables, constructor injection

**Avoid**:
- Strategy class when a lambda suffices — single method + no state = use lambda
- Strings/symbols to select strategies — pass the callable directly
- Hardcoding strategy selection in the context
