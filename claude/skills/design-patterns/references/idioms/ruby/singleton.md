# Singleton — Ruby

Prefer `module` + `extend self` over the `Singleton` stdlib module. Inject dependencies for testability.

```ruby
module AppConfig
  extend self

  attr_accessor :database_url, :redis_url, :secret_key

  def configure
    yield self
  end
end

AppConfig.configure do |config|
  config.database_url = ENV["DATABASE_URL"]
end
```

**Reach for**: `module` + `extend self`, dependency injection, `Mutex` for thread-safe init, `class << self` for class-level state

**Avoid**:
- `Singleton` module when `extend self` suffices — harder to test
- Mutable request-specific state on singletons — race conditions in threaded servers (Puma)
- Hiding dependencies behind global access — inject through constructors
