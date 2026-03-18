# Observer

When something changes, automatically notify everyone who cares — without the source knowing who they are.

## The problem you feel

An order gets placed. Now the mailer has to send a confirmation, analytics has to track it, inventory has to reserve stock, and the cache needs clearing. You stuff all of this into `create_order`, and now it's 50 lines of side effects that have nothing to do with creating orders. New side effect? Edit the core method again.

## How it works

The publisher maintains a list of subscribers. After the event happens, it notifies all subscribers. Each subscriber reacts independently — the publisher doesn't know or care what they do. Magazine subscriptions work this way — the publisher sends issues to the list without knowing what any reader does with theirs. Join or leave anytime, nobody else notices.

## You need this when

- One change triggering side effects in unrelated subsystems (mailers, analytics, caches)
- Dynamic set of observers unknown at design time
- GUI components reacting to user actions
- Need to decouple the thing producing events from the things consuming them

## The trap

- Observers modifying the subject during notification, causing infinite loops.
- Not handling observer exceptions, so one failure breaks all subsequent notifications.
- Using observers for core business flow where explicit calls would be clearer and easier to debug.
