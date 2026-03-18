# State — Ruby

Duck-typed state objects sharing the same interface. Context delegates to current state.

```ruby
class Draft
  def publish(post)
    post.published_at = Time.now
    post.transition_to(Published.new)
  end

  def unpublish(_post) = puts("Already a draft.")
  def to_s = "draft"
end

class Published
  def publish(_post) = puts("Already published.")

  def unpublish(post)
    post.published_at = nil
    post.transition_to(Draft.new)
  end

  def to_s = "published"
end

class Post
  attr_accessor :published_at

  def initialize(title) = (@title, @state = title, Draft.new)
  def transition_to(state) = @state = state
  def publish = @state.publish(self)
  def unpublish = @state.unpublish(self)
  def status = @state.to_s
end
```

**Reach for**: Duck-typed state classes, endless methods (`def to_s = "draft"`), AASM gem for ActiveRecord integration, `case/in` for simple state checks

**Avoid**:
- `if/elsif` chains on string/symbol fields — use state objects
- Direct `state =` assignment — bypasses guards and callbacks
- More than 7-8 states — consider splitting into multiple machines
