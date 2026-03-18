# Memento — Ruby

Use `Data.define` for immutable snapshots. `dup`/`Marshal.dump` for mutable objects.

```ruby
class Document
  State = Data.define(:content, :cursor_position, :saved_at)

  attr_reader :content, :cursor_position

  def initialize(content = "", cursor_position: 0)
    @content, @cursor_position = content, cursor_position
  end

  def type(text)
    @content = @content.insert(@cursor_position, text)
    @cursor_position += text.length
  end

  def save_state
    State.new(content: @content.dup, cursor_position: @cursor_position, saved_at: Time.now)
  end

  def restore_state(state)
    @content = state.content.dup
    @cursor_position = state.cursor_position
  end
end
```

**Reach for**: `Data.define` for typed immutable snapshots, `Marshal.dump`/`load` for quick deep copies, `dup`/`clone` for shallow state

**Avoid**:
- `Marshal.load` with untrusted data — can execute arbitrary code
- Unbounded history — cap size or use ring buffer
- Forgetting to `dup` mutable state in snapshots
