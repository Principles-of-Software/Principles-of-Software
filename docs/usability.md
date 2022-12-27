# Usability
Usability is the ease of use and learnability of a human-made object, such as a tool or device.  In software engineering, usability is the degree to which specified consumers can use software to achieve quantified objectives with effectiveness, efficiency, and satisfaction in the context of use.  Ideally, products would be more time-efficient, intuitive, and satisfying to use.  We often refer to usability as UX – User Experience.

Usability is how well users can use the system's functionality.  The dimensions of usability are:

- Learnability: is it easy to learn?
- Efficiency: once learned, is it fast to use?
- Safety: are errors few and recoverable?
- Memorability: is it easy for users to remember what they learned?
- Satisfaction: is it enjoyable to use?
- Simplicity

Different dimensions vary in importance, depending on the user and the task.  Usability is only one aspect of the system, so software designers must worry about other aspects: cost, security, functionality, maintainability, size, and more.

## Learnability and Memorability

In humans, working memory is small: we have `7 +- 2` "chunks" of thought we can keep track of at once.  These are usually gone in ~10 seconds.  **Maintenance Rehearsal** is required to keep short-term memory from decaying, but it costs attention.  Maintenance rehearsal is <span style="color:blue;">the process of repeatedly verbalizing or thinking about a piece of information</span>.  Human short-term memory can be increased to about 30 seconds by using Maintenance Rehearsal.  

For example, Alice wants to order a pizza, and Bob tells Alice the phone number.  Alice repeats the phone number to herself until she can type it into the phone.  Alice just used maintenance rehearsal to order the pizza.

In contrast, long-term memory is practically infinite in size and duration.  Elaborative rehearsal is required to transfer short-term thoughts into long-term memory.  **Elaborative Rehearsal** is <span style="color:blue;">a memory technique that utilizes thinking about the meaning of the term to be remembered</span>.

An excellent example of elaborative rehearsal is a medical student's attempt to remember the term "neuron."  In order to permanently commit the term to memory, they look up what it means, learn its purpose, study a diagram, and think about how a neuron might relate to things they already know.  If they do (*rehearse*) this several times, they will be more likely to remember the term "neuron."

Consistency is required when designing software for learnability.  Similar things should look similar, and different items in an application should behave differently.  Terminology, location, internal, external, and metaphorical design should be consistent with use.  When designing, use common, simple words instead of tech jargon, and rely on recognition instead of recall.  Labeled buttons are better than commands, and combo boxes are better than text boxes.

## Perception

Good design makes heavy use of human perception.  For instance, humans have something called **Perceptual Fusion**, where <span style="color:blue;">stimuli ~100ms apart, or ten frames per second, seem to create a moving picture</span>.  Thus, a computer graphics response of `< 100`ms looks instantaneous.  In many cases, computer response time dictates what design choices we make:

- < 0.1 seconds: seems instantaneous
- 0.1 - 1 seconds: user notices
- 1 - 5 seconds: display a loading animation or busy cursor
- \> 5 seconds: display a progress bar

Software designers must also consider visibility when creating the UI and UX for a system.  For example, color blindness is pervasive, with roughly 8\% of all males unable to distinguish red from green.  With that in mind, it is good practice not to differentiate different items by color alone.  To design for visibility, make the system state visible: keep the user informed about what is happening in the application.  For instance, keep the cursor, selection highlight, and status bar visible.  Prompt feedback about user actions is also helpful and keeps users engaged.

Even motor control and function affect software; humans use **Closed-Loop Control**.  We <span style="color:blue;">get sensory feedback, correct errors accordingly, and consciously, continuously, adjust muscle movements, with a cycle time of about 140ms</span>.  An excellent example is threading a needle - a slow process requiring total attention.  We also use **Open-Loop Control**, where <span style="color:blue;">the motor processor runs with no feedback in a cycle time of around 70ms</span>.  Open-loop control in practice exhibits itself in a gymnast's double-back somersault - it is a swift process!

Finally, we also have something called **Fitt's Law**, which <span style="color:blue;">measures the time it takes a human to point at a target of `S` size from a distance `D`</span>.  That function can be measured as 

`T = RT + MT = a + b log(D / S)`

, where `RT` is Reaction Time, `MT` is Movement Time, and `b log(D / S)` is the index difficulty of the pointing task, such as moving a hand.  Fitt's Law applies only if a path to the target is unconstrained.  The **Steering Law**, ``T = RT + MT = a + b(D / S)``, is <span style="color:blue;">applied when the path is constrained to something like a tunnel</span>.

Keeping Fitt's Law and the Steering Law in mind, make important targets big or nearby and avoid steering tasks in applications.  Provide shortcuts, such as keyboard accelerators, styles, bookmarks, and history, to increase usability.

## Safety

**Modes** are <span style="color:blue;">states in which actions have different meanings</span>, as in vim's insert mode vs. vim's command mode.  Avoid mode errors by eliminating them, making them visible, or putting disjoint action sets in different modes.  Programmers and users alike need feedback about which mode their application is in.

To further increase safety, consider what the user might already know about an application's tools:

- *Buttons* are used for single independent actions relevant to the current screen.
- *Toolbars* are good for common actions.  
- *Menus* are used for infrequent actions that may apply to multiple screens
- *Checkboxes* are for on/off switches when one switch can be toggled independently of others
- *Radio Buttons* are good for related choices when only one choice can be activated at a time
- *Lists* are utilized when there are several fixed choices - too many for radio buttons to be practical.  
- *Text Fields* show up when the user needs to enter text information
- *Combo Boxes* are good for when there are multiple fixed choices, but the screen would be cluttered if they were all displayed at once
- A *Tabbed Pane* is useful when there are several screens that the user may want to switch between
- *Dialog Boxes* present temporary screens or options.

When programmers come across error messages, they should be precise, speak the user's language, offer constructive help, and be polite.

## Simplicity and Satisfaction

In design, less is more!  Always omit extraneous information, graphics, and features.  Good graphic design constitutes few, well-chosen colors and fonts, and groupings with white space tooltips.  In the same vein, concise language helps users understand what is going on while keeping the site simple.

In an extensive system, the user manual is also essential.  When writing it, use program and UI metaphors, and include key functionality, but do not include an exhaustive list of all menus.  Ask:

- What is hard to do?  
- Who is the target audience?

Power users need a manual; casual users might not.  As such, the software should be obvious to use - piecemeal online help is no substitute for good documentation.

## Prototyping and Testing

The first step of design is to create a low-fidelity prototype before working on the GUI.  Paper is a speedy and effective prototyping tool; it is quick work to sketch windows, menus, dialogs, and widgets.  Designers who use paper prototyping can crank many designs and evaluate them quickly.  Thus, hand sketching is preferable because it allows designers to focus on behavior and interactions, not fonts and colors.  With some extra thought, paper prototypes can even be executed.  Use pieces of paper to represent windows, dialogs, and menus, and simulate the computer's responses by moving those pieces around and writing on them.

When testing, start with a prototype, write a few (short but non-trivial) representative tasks, find three representative users, and watch them do tasks with the prototype.  Brief the user first.  Tell them:

1. "I am testing the system, not testing you."
2. "If you have trouble, it is the system's fault."
3. "Feel free to quit at any time."  

A significant ethical issue is informed consent - ensure the user receives this.  Ask the user to think aloud without helping, explaining, or pointing out mistakes.  Only speak up to prod the user to think aloud, and to move on to the next task when stuck.  Take lots of notes.

Programmers test with users to watch for **Critical Incidents** that <span style="color:blue;">strongly affect task performance or satisfaction</span>.  User responses to these are usually negative - they can run into errors, repeat attempts, and may even curse at the tester.  However, responses can also be positive, such as "Cool!" or "Oh, now I see."  

## Review

Programmers are not users.

Keep human capabilities and design principles in mind.

Iterate over the design.

Write documentation.

Make cheap, throw-away prototypes.

Evaluate prototypes and designs with users.