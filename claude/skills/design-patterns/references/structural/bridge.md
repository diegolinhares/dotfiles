# Bridge

Separate the "what" from the "how" so you can change either independently.

## The problem you feel

You have notifications (urgent, normal) and delivery methods (email, SMS, push). Without separation, you end up with UrgentEmail, UrgentSMS, NormalEmail, NormalSMS... Every new notification type times every new delivery method equals an explosion. Add Slack and you create three more classes.

## How it works

Split into two halves connected by a reference. One half is the concept (notification types), the other is the mechanism (delivery methods). The concept holds a reference to a mechanism and delegates to it. Cross-platform apps work this way — GUI on one side, OS APIs on the other. Change the GUI without touching platform code. Adding a new delivery method now means one class, not N.

## You need this when

- Class hierarchy exploding across two independent dimensions
- Hard-coded vendor calls inside domain logic
- Difficulty testing because abstraction and implementation are welded together
- Need to switch implementations at runtime

## The trap

- Premature bridging. Don't split when only one implementation exists. Add the bridge when the second appears.
- God abstraction. Keep it thin, delegating to the implementation. Business logic belongs elsewhere.
- Ignoring simpler alternatives. Often dependency injection alone suffices without full Bridge ceremony.
