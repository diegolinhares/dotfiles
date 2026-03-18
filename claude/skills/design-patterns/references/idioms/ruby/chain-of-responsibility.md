# Chain of Responsibility — Ruby

Rack middleware is the canonical Ruby CoR. Each wraps the next app, handles or passes through.

```ruby
class AuthenticationMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if valid_token?(env)
      env["current_user"] = find_user(env)
      @app.call(env)
    else
      [401, {}, ["Unauthorized"]]
    end
  end

  private

  def valid_token?(env) = env["HTTP_AUTHORIZATION"]&.start_with?("Bearer ")
  def find_user(env) = User.find_by_token(env["HTTP_AUTHORIZATION"].delete_prefix("Bearer "))
end
```

**Reach for**: Rack middleware stack, `before_action`/`around_action` callbacks, Proc/lambda composition with `Array#reduce`

**Avoid**:
- Class hierarchies for handlers when Procs suffice
- Incorrect middleware ordering — authentication before authorization
- Forgetting Rack must return `[status, headers, body]` array
