---
paths:
  - "test/**/*.rb"
  - "spec/**/*.rb"
---

# Testing style

## Test names are business specs

Name tests like facts a domain expert would nod at. Use business language, not implementation details.

```ruby
# Good
test "completed order cannot be cancelled" do
test "partner company can view shared results when partnership allows it" do
test "expired partnership prevents cross-company access" do
test "cancelling a draft order requires no refund" do

# Bad
test "status returns false when cancelled after completed" do
test "validates presence of company_id" do
test "calls send_notification after save" do
```

## Arrange-act-assert with blank lines

Blank lines between phases. No `# Arrange` / `# Act` / `# Assert` comments. If the test is three lines or fewer, skip the separation.

```ruby
test "submitting order charges the partner company" do
  partner = create(:partnership, payer: :target)
  order = create(:order, partnership: partner, status: :draft)

  order.submit!

  assert_equal "created", order.reload.status
  assert order.invoice.present?
end
```

## Factories: stay off the database

`build_stubbed` > `build` > `create`. Use the lightest one that works.

- `build_stubbed` -- no DB at all, this is the default
- `build` -- no DB for the object itself, but associations hit DB
- `create` -- only for scopes, uniqueness, queries, or integration tests

One attribute per line when there are several:

```ruby
test = create(:test,
              status: :completed,
              spec_status: "in_spec",
              complete_date: Time.current)
```

## Assertions

Use Rails-specific assertions instead of bare `assert`:

```ruby
assert_difference "Order.count", 1 do
assert_no_difference "Sample.count" do
assert_changes -> { order.status }, from: "draft", to: "created" do
assert_raises(ActiveRecord::RecordInvalid) {
```

Minitest has semantic assertions. Use them:

```ruby
assert_equal expected, actual   # not assert(expected == actual)
assert_nil obj                  # not assert_equal nil, obj
assert_empty collection         # not assert collection.empty?
assert_includes collection, obj # not assert collection.include?(obj)
refute_predicate order, :valid? # not assert !order.valid?
```

## System tests (Capybara)

No `sleep`. No `all()` for counting async elements. Wait for things properly.

```ruby
# Good
assert_selector "[data-test-id='order-row']", minimum: 2, wait: 5
assert_text "Order submitted", wait: 5
assert_no_selector ".modal", wait: 5

# Bad
sleep 2
rows = all("[data-test-id='order-row']")
assert_equal 2, rows.count
```

Use `data-test-id` for React-rendered selectors. Add `wait: 5` after navigation or JS re-renders.

## What not to test

- Private methods directly. Test through the public interface.
- Framework behavior. Don't assert that `has_many` works.
- Trivial validations in isolation. Test the behavior that depends on validity.
- Exact SQL or error message wording.

## Mock boundaries

Mock external services only (Stripe, Qbench, EasyPost, Docspring). Never mock your own models or domain objects. WebMock/VCR for HTTP, `travel_to` for time.
