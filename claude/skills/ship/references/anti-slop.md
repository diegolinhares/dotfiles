# Anti-slop reference

Word and pattern kill list for commit messages and PR descriptions.

## Words to replace

| Slop | Write instead |
|------|--------------|
| ensure | make sure, check, verify |
| leverage | use |
| enhance | improve, speed up, fix |
| streamline | simplify, cut |
| utilize | use |
| facilitate | help, let |
| introduce | add |
| comprehensive | full, complete |
| robust | solid, reliable |
| seamless | smooth |
| additionally | also |
| crucial / pivotal / vital | important, needed |
| align with | match, follow |
| in order to | to |
| address | fix, handle |
| implement | add, build, write |

## Sentence patterns to kill

- "This commit introduces..." -- just describe the change
- "This PR enhances..." -- say what improved and by how much
- "This change ensures..." -- say what it checks or guards
- "In this pull request, we..." -- drop the preamble
- Starting every sentence with "This..."
- "by implementing X, ensuring Y, and enhancing Z" -- the -ing chain
- "Not only X but also Y" -- just say both things
- Paired adjectives: "seamless and secure", "robust and reliable"
- Bold inline headers in lists: "- **Performance:** Optimized..."
- Rule of three: "speed, reliability, and maintainability"
- Em dashes for dramatic effect -- use commas or periods instead

## What human writing looks like

Starts with the problem, not the solution. Names specific things (the file, the function, the number). Admits shortcuts and uncertainty. Varies sentence length. Short ones. Then a longer one that takes its time. Uses "I" when appropriate: "I went with cursor pagination because..." Says "use" not "utilize", "fix" not "address", "add" not "introduce."

## Good vs bad examples

### Commit messages

Bad:
```
Enhance user authentication flow for improved session management

This commit introduces improvements to the authentication module,
leveraging JWT tokens to streamline the login process.
```

Good:
```
Switch session auth to JWT

Cookie-based sessions hit the 4KB size limit for users with many
roles. JWTs don't have that problem. Existing sessions still work
-- they rotate to JWT on next login.
```

### PR descriptions

Bad:
```
## Summary
This PR implements cursor-based pagination for the billing invoices
endpoint, enhancing performance for accounts with large volumes.

## Changes
- **Backend:** Added cursor-based pagination to InvoicesController
- **Frontend:** Updated InvoiceList component for infinite scroll
- **Database:** Added index on invoices.created_at
```

Good:
```
The billing page was falling over for Acme Corp (~2000 invoices).
Loading all of them on mount was the problem.

Switched to cursor-based pagination using created_at. Went with
cursor over offset because offset gets slower as you page deeper.

Added an index on invoices.created_at -- EXPLAIN showed a seq scan
before, now it's an index scan. Load time: ~3s down to ~200ms on
staging.

The frontend does infinite scroll. I considered a "Load more" button
but the design team preferred scroll.
```

## The audit checklist

1. Does any sentence start with "This PR" or "This commit"? Rewrite it.
2. Any word from the kill list? Replace it.
3. Could a reviewer learn the "why" from this text alone? If not, add it.
4. Does it sound like something you'd type in Slack? If not, loosen up.
5. Is there a bullet list that should be a paragraph? Convert it.
