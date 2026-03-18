# Command — Ruby

Convention: objects responding to `#call`. Use `.()` shorthand. Lambdas for stateless commands.

```ruby
class CreateUser
  def initialize(user_repo:, mailer:)
    @user_repo = user_repo
    @mailer = mailer
  end

  def call(name:, email:)
    user = @user_repo.create(name:, email:)
    @mailer.welcome(user)
    user
  end
end

command = CreateUser.new(user_repo: UserRepository.new, mailer: UserMailer)
command.(name: "Ada", email: "ada@example.com")
```

**Reach for**: `#call` convention, `.()` shorthand, lambdas for simple commands, `ActiveJob` for queued commands

**Avoid**:
- Noun names (`UserCreator`) — use verb phrases (`CreateUser`)
- Commands doing too many things — one coherent operation each
