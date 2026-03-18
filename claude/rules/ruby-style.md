---
paths:
  - "**/*.rb"
  - "**/*.rake"
---

# Ruby style

## Naming

Name from the business domain. Code should read like a conversation with a domain expert, not a programmer.

Methods are verbs the business uses. Models are nouns the business uses. No technical suffixes (`Manager`, `Handler`, `Processor`, `Service`, `DTO`).

```ruby
# Good
order.cancel
partnership.activate
shipment.deliver_to(laboratory)

# Bad
order.set_status_cancelled
partnership.update_active_flag
shipment.process_delivery_action
```

## Controllers: REST or nothing

Only the seven CRUD actions. If an action doesn't fit, make a new controller.

```ruby
# Good -- new controller for the concept
module Orders
  class CancellationsController < ApplicationController
    def create = # ...
  end
end

# Bad -- bolting non-REST actions onto existing controllers
class OrdersController < ApplicationController
  def cancel = # ...
end
```

## Records over booleans

Track state transitions as records, not boolean columns. You get who, when, and why for free.

```ruby
class Order < ApplicationRecord
  has_one :cancellation
  def cancelled? = cancellation.present?
end

# Not this -- you lose all context
add_column :orders, :cancelled, :boolean, default: false
```

## Concerns named as behaviors

Name concerns as adjectives or capabilities. Each one is a cohesive behavior: its associations, scopes, validations, and callbacks all belong together.

```ruby
# Good
module Trashable    # soft-delete: associations + scopes + callbacks
module Searchable   # full-text search behavior
module Billable     # payment-related logic
module Trackable    # shipment tracking

# Bad
module OrderCallbacks
module ValidationHelpers
```

## Value objects with `Data.define`

`Data.define` over `Struct`. Frozen by default, works with pattern matching.

```ruby
Measurement = Data.define(:value, :unit) do
  def to_s = "#{value} #{unit}"
end
```

## Modern Ruby idioms

Use `it` for single-parameter blocks. Always `it`, never `_1`.

```ruby
orders.select { it.pending? }
results.filter_map { it.value if it.in_spec? }
```

Endless methods for computed properties and predicates. Not for side effects.

```ruby
def total = line_items.sum { it.subtotal }
def complete? = status == :completed
def editable? = draft? && !locked?
```

## Pattern matching

`case/in` for matching structure. `=>` for destructuring. `in` for boolean checks.

```ruby
case payment
in {status: :paid, amount: (1..)}  then fulfill_order
in {status: :failed, retries: (..3)} then retry_payment
in {status: :failed} then notify_support
end

response => {data: {id:, attributes: {name:}}}
```

## Declarative over imperative

Enumerable methods over loops: `filter_map`, `tally_by`, `group_by`, `flat_map`.

```ruby
# Good
in_spec = results.filter_map { it.value if it.in_spec? }

# Bad
in_spec = []
results.each { |r| in_spec << r.value if r.in_spec? }
```

`.then` for readable pipelines. `.tap` for side effects mid-chain.

```ruby
raw_input
  .then { normalize(it) }
  .then { validate(it) }
  .then { persist(it) }
```

## Shape of methods

Guard clauses over nesting. Keyword arguments when meaning isn't obvious. Shorthand hash syntax when variable names match keys.

```ruby
def process(order)
  return unless order.pending?
  return if order.line_items.empty?

  order.submit
end

transfer(amount: 100, from: checking, to: savings)
User.new(name:, email:, role:)
```
