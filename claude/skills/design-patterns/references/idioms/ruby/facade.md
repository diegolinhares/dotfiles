# Facade — Ruby

A plain class (or module with `extend self`) that coordinates multiple objects behind a single method.

```ruby
class PlaceOrder
  def initialize(user, cart)
    @user = user
    @cart = cart
  end

  def call
    return { error: "Unavailable" } unless InventoryChecker.new(@cart.items).available?

    order = Order.create!(user: @user, items: @cart.items)
    PaymentGateway.charge(@user.payment_method, order.total)
    ShippingService.schedule(order)
    EmailNotifier.order_confirmation(order)
    { success: true, order: order }
  end
end
```

**Reach for**: Single public method classes (`call`, `perform`), `extend self` on modules, Rails `app/services/` convention

**Avoid**:
- God object facades that contain business logic — facades coordinate, not compute
- Facades for a single class — adds indirection without simplification
