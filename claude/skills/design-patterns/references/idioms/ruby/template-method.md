# Template Method — Ruby

Base class defines skeleton with `raise NotImplementedError` for abstract steps. Hook methods for optional steps.

```ruby
class BaseImporter
  def import(source)
    data = read(source)
    records = parse(data)
    results = records.map { |r| transform(r) }
    load(results)
  end

  private

  def read(source) = raise(NotImplementedError)
  def parse(data) = raise(NotImplementedError)
  def transform(record) = record  # hook: override if needed
  def load(records) = records.each { |r| save(r) }
  def save(record) = raise(NotImplementedError)
end

class CsvImporter < BaseImporter
  private

  def read(source) = File.read(source)
  def parse(data) = CSV.parse(data, headers: true).map(&:to_h)
  def transform(record) = record.transform_keys(&:downcase).transform_values(&:strip)
  def save(record) = Product.create!(record)
end
```

**Reach for**: `raise NotImplementedError`, hook methods with default no-ops, module inclusion as alternative to inheritance, `super` to extend steps

**Avoid**:
- Generic `RuntimeError` — `NotImplementedError` communicates intent
- Too many abstract methods (10+) — consider Strategy/composition instead
- Template method when only one step varies — pass a block instead
