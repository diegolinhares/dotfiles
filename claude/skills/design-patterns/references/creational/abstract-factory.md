# Abstract Factory

Get a matching set of related objects, guaranteed to work together.

## The problem you feel

Your app needs storage components — bucket, file handler, CDN. On AWS that's S3 + CloudFront. On GCP it's GCS + Cloud CDN. If someone accidentally mixes an S3 bucket with a GCS file handler, things break silently. You need families of objects that stay consistent, and switching families should be a single-line change.

## How it works

Group related constructors behind one factory per family. `StorageFactory.new(:aws)` gives you S3Bucket, S3File, and CloudFront. Switch to `:gcp` and everything switches together. Same idea as buying a furniture set — pick "modern" and the chair, table, and sofa all match. You can't accidentally end up with a Victorian chair next to an Art Deco table.

## You need this when

- Multiple related objects always created together (theme widgets, storage backends)
- Configuration switches selecting between families of related objects
- Cross-platform implementations requiring OS-specific components
- Hard-coded vendor calls inside domain logic for related services

## The trap

- Building factory hierarchies for a single product family. Wait until you actually have two families.
- Registering factories in a global registry when constructor injection suffices.
- Creating abstract base factory classes with empty methods when simpler approaches work.
