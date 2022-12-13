# Usability
Usability is the ease of use and learnability of a human-made object, such as a tool or device.  In software engineering, usability is the degree to which specified consumers can use software to achieve quantified objectives with effectiveness, efficiency, and satisfaction in a quantified context of use.  Ideally, products would be more time-efficient, intuitive, and satisfying to use.  We often refer to usability as UX – User Experience.

Usability is how well users can use the system's functionality.  The dimensions of usability are:

- Learnability: is it easy to learn?
- Efficiency: once learned, is it fast to use?
- Safety: are errors few and recoverable?
- Memorability: is it easy for users to remember what they learned?
- Satisfaction: is it enjoyable to use?
- Simplicity

Different dimensions vary in importance, depending on the user and the task.  Usability is only one aspect of the system, so Software designers need to worry about other aspects: costs,
security, functionality, maintainability, size, and more.

## Learnability and Memorability
Some facts about human learning: Working memory is small; we have 7 +- 2 "chunks."  It is short-lived: gone in ~10 seconds.  Maintenance rehearsal is required to keep it from decaying, but it costs attention.  Maintenance Rehearsal is the process of repeatedly verbalizing or thinking about a piece of information.  Human short-term memory can hold information for about 20 seconds.  However, this time can be increased to about 30 seconds by using Maintenance Rehearsal.  

Long-term memory is practically infinite in size and duration; Elaborative rehearsal transfers chunks to long-term memory.  Elaborative rehearsal is a memory technique that involves thinking about the meaning of the term to be remembered.

For example, Alice wants to order a pizza, and Bob tells Alice the phone number.  Alice repeats the phone number to herself until she can type it into the phone.  Alice just used maintenance rehearsal to order the pizza.

An example of elaborative rehearsal would be a student trying to remember the term "neuron."  In order to permanently commit the term to memory, they look up what it means, find out its purpose, look at a diagram and study its parts, and think about how it relates to things they already know.  If they do this several times (rehearsal), they will be more likely to remember the term.

Consistency is required when designing for learnability; similar things look similar, and different things are different.  Terminology, location, Internal, external, and metaphorical design should be consistent with use.  Use common, simple words, not tech jargon!  Rely on recognition, not recall.  Labeled buttons are better than commands, and combo boxes are better than text boxes.

## Efficiency
Some facts about human perception: Perceptual fusion: stimuli ~100ms apart ten frames/sec is enough to perceive a moving picture, so a computer response of $< 100$ms feels instantaneous.  Many users experience color blindness: ~8\% of all males cannot distinguish red from green.

To design for visibility, make the system state visible.  Keep the user informed about what is going on.  Keep the mouse cursor, selection highlight, and status bar visible.  Give prompt feedback too!  Response time rules-of-thumb:

- < 0.1 seconds seems instantaneous
- 0.1 - 1 seconds user notices
- 1 - 5 seconds display a loading animation or busy cursor
- > 5 seconds display a progress bar

Some facts about motor processing: We use closed-loop control.  Muscle movements are perceived and compared with the desired result.  Cycle time is ~ 140ms.  Humans get sensory feedback, correct errors accordingly, and consciously, continuously, adjust muscle movements.  An excellent example is threading a needle - it is slow and requires total attention.  We also use Open-loop control, where the motor processor runs by itself.  Cycle time is ~ 70ms, and they get no feedback, as in a gymnast's double-back somersault.  It is very fast!

We also have something called Fitt's Law, which measures the time it takes a human to point at a target of $S$ size from a distance $D$.  That function can be measured as $$T = RT + MT = a + b\log{\frac{D}{S}}$$
Where $RT$ is Reaction Time, $MT$ is Movement Time, and $\log{\frac{D}{S}}$ is the index difficulty of the pointing task.  Moving a hand uses a closed-loop control.  Fitt's Law applies only if a path to the target is unconstrained.  When the path is constrained, say, to a tunnel, the Steering Law is applied in $$T = RT + MT = a + b\frac{D}{S}$$

As in Fitt's Law and Steering Law, make important targets big, nearby, or at the screen edges, and avoid steering tasks!  Provide shortcuts - keyboard accelerators, styles, bookmarks, and history, to increase usability.

## Safety
Modes are states in which actions have different meanings, e.g., vim's insert mode vs. command mode.  Avoid mode errors by eliminating them, making them visible, or putting disjoint action sets in different modes.  Programmers need feedback about which mode their program is in.

Use confirmation dialogs sparingly; Prevent errors as much as possible.  Selection is better than typing.  Avoid mode errors.  Disable illegal commands.  Separate risky commands from common ones.  Support Undo.

Use buttons for single independent actions that are relevant to the current screen.  Use toolbars for common actions.  Use menus for infrequent actions that may apply to many or all screens.  Use checkboxes for on/off switches when one switch can be toggled independently of others.  Use radio buttons for related choices, i.e., when only one choice can be activated at a time.  Use text fields when the user needs to enter text information.  Use lists when there are several fixed choices - too many for radio buttons to be practical.  Use combo boxes when there are multiple fixed choices, but the screen would be cluttered if they were all displayed at once.  Use a tabbed pane when there are several screens that the user may want to switch between.  Finally, use dialog boxes to present temporary screens or options.

When programmers come across error messages, they should be precise, speak the user's language, offer constructive help, and be polite.

## Simplicity and Satisfaction
Less is More!  Omit extraneous information, graphics, and features.  Use good graphic design - designers want few, well-chosen colors and fonts — group things with white space and use tooltips.  Also, use concise language!

The user manual is also essential.  When doing so, use program and UI metaphors, and include key functionality, but do not include an exhaustive list of all menus.  What is hard to do?  Who is the target audience?  Power users need a manual; casual users might not.  Software should be obvious to use - piecemeal online help is no substitute for good documentation.

## Prototyping and Testing
Create a low-fidelity prototype before working on the GUI.  Paper is a speedy and effective prototyping tool; it is quick work to sketch windows, menus, dialogs, and widgets.  Paper prototyping can crank out lots of designs and evaluate them.  Thus, hand sketching is preferable because it allows designers to focus on behavior and interactions, not fonts and colors.  The process is similar to the design of ADTs and classes.

Paper prototypes can even be executed!  Use pieces to represent windows, dialogs, and menus.  Simulate a computer's responses by moving pieces around and writing on them.

When testing, start with a prototype, write a few (short but non-trivial) representative tasks, find about three representative users, and watch them do tasks with the prototype.  Brief the user first - tell them, "I am testing the system, not testing you," "If you have trouble, it is the system's fault," and "Feel free to quit at any time."  A significant ethical issue is informed consent.  Ask the user to think aloud.  Be quiet!  Do not help, do not explain, and do not point out mistakes.  There are two exceptions: prod user to think aloud and move on to the next task when stuck.  Take lots of notes.

Programmers test with users to watch for critical incidents that strongly affect task performance or satisfaction.  Responses are usually negative - users can get errors, repeated attempts, and curses.  However, responses can also be positive, like "Cool!" or "Oh, now I see."

## Review
Programmers are not users.

Keep human capabilities and design principles in mind.

Iterate over the design.

Write documentation.

Make cheap, throw-away prototypes.

Evaluate them with users.