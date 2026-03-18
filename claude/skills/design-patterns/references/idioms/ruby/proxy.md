# Proxy — Ruby

Use `BasicObject` for transparent proxies. `SimpleDelegator` when most methods should pass through.

```ruby
class LazyRecord < BasicObject
  def initialize(&loader)
    @loader = loader
    @target = nil
  end

  def method_missing(name, *args, &block)
    (@target ||= @loader.call).send(name, *args, &block)
  end

  def respond_to_missing?(name, include_private = false)
    (@target ||= @loader.call).respond_to?(name, include_private)
  end
end

user = LazyRecord.new { User.find(1) }  # no DB hit yet
user.name  # DB hit happens here
```

**Reach for**: `BasicObject` for transparent proxies, `method_missing` + `respond_to_missing?`, `Rails.cache.fetch` for caching proxies, `ActiveRecord::Relation` as canonical lazy proxy

**Avoid**:
- Inheriting from `Object` — its methods pollute the proxy
- Forgetting `respond_to_missing?` alongside `method_missing`
- Caching without expiration or invalidation
