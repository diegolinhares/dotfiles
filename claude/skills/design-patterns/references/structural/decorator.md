# Decorator

Wrap an object to add behavior without touching its class. Stack wrappers like Russian dolls.

## The problem you feel

Your User model needs different display logic for admin views, public profiles, and API responses. Subclassing gives you AdminUser, PublicUser, ApiUser... then you need AdminPublicUser? The combinations explode. And inheritance is permanent — you can't add or remove behaviors at runtime.

## How it works

Create a wrapper object with the same interface as the original. It intercepts calls, adds its behavior, then passes through to the wrapped object. Stack multiple wrappers — each adds one behavior independently. Same principle as clothing layers — add a sweater for warmth, toss a jacket on top for wind. Take either off without affecting what's underneath.

## You need this when

- Conditional logic adding behavior based on context (admin vs. regular user display)
- Subclass explosion where variants differ only in optional behaviors
- Need to combine behaviors at runtime in arbitrary order
- Presentation or formatting logic layered on top of core objects

## The trap

- Inheritance instead of decoration. A deep subclass chain for combining behaviors signals that decoration is wanted.
- Adding a decorator library when simple delegation gets the job done.
- The decorated object may not pass identity checks against the original type. Plan for this.
