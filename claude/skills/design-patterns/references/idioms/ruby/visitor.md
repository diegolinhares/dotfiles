# Visitor — Ruby

Dynamic dispatch with `send`. Pattern matching (`case/in`) often eliminates the need for formal visitors.

```ruby
module Visitable
  def accept(visitor)
    visitor.send("visit_#{self.class.name.downcase}", self)
  end
end

class SalaryReport
  def visit_manager(m) = "#{m.name}: $#{m.salary} + $#{m.bonus} bonus"
  def visit_engineer(e) = "#{e.name}: $#{e.salary} + #{e.stock_options} options"
  def visit_intern(i) = "#{i.name}: $#{i.stipend}/month"
end
```

Pattern matching alternative (often simpler):

```ruby
def salary_report(employee)
  case employee
  in { type: :manager, name:, salary:, bonus: }
    "#{name}: $#{salary} + $#{bonus} bonus"
  in { type: :engineer, name:, salary:, stock_options: }
    "#{name}: $#{salary} + #{stock_options} options"
  end
end
```

**Reach for**: `send`/`public_send` for dynamic dispatch, `deconstruct_keys` for pattern matching, `case/in` as visitor replacement, `Visitable` mixin

**Avoid**:
- Full visitor hierarchy when pattern matching is cleaner
- `send` with unsanitized input — use `public_send` or validate
- Mutating elements inside the visitor — visitors compute, not mutate
