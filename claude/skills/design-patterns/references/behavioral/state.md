# State

An object's behavior changes based on its internal state — instead of `if/else` everywhere, let the state itself define the behavior.

## The problem you feel

Every method in your Order class starts with `if status == "pending"... elsif status == "shipped"... elsif status == "delivered"`. Add a new status and you're editing 12 methods. Forget one check and you get bugs like "delivered orders can be shipped again." Boolean flags multiply: `is_active`, `is_published`, `is_archived`.

## How it works

Create a separate object for each state (DraftState, PublishedState, etc). The main object holds a reference to its current state and delegates behavior to it. When the state changes, swap the state object. Each state knows what actions are valid and what transitions are allowed. Your smartphone already does this — same buttons behave differently when locked vs. unlocked vs. low-battery. The phone doesn't check "am I locked?" before every action. The current mode just defines what buttons do.

## You need this when

- Status checks scattered across methods (`if status == "active"`)
- Boolean flag proliferation: `is_active`, `is_published`, `is_archived`
- Methods that only apply in certain states and raise errors otherwise
- Number of states is large and state-specific code changes frequently

## The trap

- String-based state checks instead of typed state objects or predicates.
- State transitions without guard validation.
- Stuffing complex business logic inside transition callbacks instead of extracting it.
