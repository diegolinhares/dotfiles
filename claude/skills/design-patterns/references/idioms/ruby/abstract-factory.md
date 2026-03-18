# Abstract Factory — Ruby

Module or Hash mapping to families of related objects. Duck typing eliminates formal interfaces.

```ruby
class StorageProvider
  PROVIDERS = {
    aws:   { bucket: S3Bucket,   file: S3File,   cdn: CloudFront },
    gcp:   { bucket: GcsBucket,  file: GcsFile,  cdn: CloudCDN },
    local: { bucket: LocalDir,   file: LocalFile, cdn: NullCDN }
  }.freeze

  def initialize(provider)
    @components = PROVIDERS.fetch(provider)
  end

  def create_bucket(name) = @components[:bucket].new(name)
  def create_file(path, content) = @components[:file].new(path, content)
  def create_cdn(origin) = @components[:cdn].new(origin)
end
```

**Reach for**: Modules with `extend self`, Hash mapping symbols to class families, constructor injection

**Avoid**:
- Creating when only one family exists — wait for a second
- `NotImplementedError` abstract base classes — duck typing is simpler in Ruby
