# Software Processes
Some software lifecycle activities requirement analysis, design, implementation, integration, testing, and verification, deployment and maintenance.  Software Process puts all of these things together, but how do we combine these activities?  In what order?

## Software Life cycle and Artifacts
The software life cycle is the process of building and maintaining a software system.  The activities from inception to end-of-life can take months or years.  Each activity has specific goals.  It defines a clear set of steps, produces an artifact (tangible item), allows for review, and specifies actions to perform in the next activity.

The activities and their artifacts create a lot of cool stuff.  Requirements analysis produces requirements documents - a Use-Case model and supplementary specifications.  The design produces "design models" - class diagrams, interaction diagrams, ADT specs, and other stuff.  The implementation produces code, specs for classes.  Readability of code is also included in this - style guides!  Testing is the last step - it produces test suites.

## Steps

### Step 1: Requirements and the Use-Case Model

A Use-Case model is a list of actions or event steps typically defining the interactions between a role and a system to achieve a goal.  A role is also called an actor!  For example, in a dice game, the use case is Play Dice Game.  The main success scenario is:

1. Player picks up the two dice and rolls them
2. If face value is 7 then they win
3. if not, yada yada yada

### Step 2: Design

For the dice game, we could create an interaction diagram as shown:
\includegraphics[width=\textwidth]{interaction_diagram.png}
and a Class Diagram as shown:
\includegraphics[width=\textwidth]{class_diagram.png}

### Step 3: Code and Specifications

You might make a UML diagram like this:
\includegraphics[width=6cm]{uml.png}
And code accordingly to produce something like this:

    /* a mutable class ... */
    class DiceGame {
        private Die die1 = new Die();
        private Die die2 = new Die();
        
        // Abstraction Function: ...
        // Rep invariant: ...
        
        // @modifies:
        // @effects:
        public void play() {
            die1.roll();
            int fv1 = die1.getFaceValue();
            ...
        }
    }

### Step 4: Tests

You want to write Unit Tests after specifications, but before code.  Then, once those are squared away, get to System Tests, and then, probably after your code is done, Integration Tests.

### Step 5: Maintenance

This step is iterative, and lasts for as long as the code exists.  This involves Bug Fixes, Enhancements, and Refactoring until the systems end of life.

Other Engineering disciplines have similar processes.  For example, in Civil engineering, you've got:

    - Requirements: architectural design
    - Design: engineering blueprints
    - Implementation: Construction
    - Testing: Inspections throughout construction and after completion
    - Maintenance: inspections, repair, and upgrades

The main differences between software engineering and other disciplines are that requirements changes don't creep into construction.  It's very expensive to change requirements in the middle of a large physical system, while it's easy to do so in code.  The majority of engineering design and construction also use tried and true materials and techniques, because it's a large physical system.  It's easy to innovate in software, because you're usually not hurting anyone when you innovate.  Construction projects are also usually mostly on time, while software projects tend to have much more variable timelines.

## Requirements
Requirements analysis is hard.  Some major causes of project failure are poor user input, incomplete requirements, and changing requirements.  Some essential tools are requirements documents and use cases.

Requirements also change!  Errors can be found in original requirements, so they must conform with what works; the customer needs to evolve to match the requirements.  Technical, schedule, and cost problems can arise; system requirements change as the world does.  It's also often difficult to understand the implications of changes on software design, and in other requirements.  Check this graph out:
\includegraphics[width=\textwidth]{reqs.png}

There are a few ways to measure complexity.  You can use function points, which are roughly the number of interactions of a user with the system, cyclomatic complexity, which is roughly the number of predicate nodes in a control flow graph, and lines of code.  Peep this cool graph:
\includegraphics[width=\textwidth]{fpoints.png}
You can classify requirements in a few different ways.  You can use the FURPS+ model, which is an acronym for Functionality, Usability, Reliability, Performance, and Supportability.  The + stands for Design constraints, implementation requirements, and anything else you feel like throwing in there.

Requirements analysis produces a Use-Case model, which is a set of use cases.  It specifies the functional requirements of the system, and specifies non-functional requirements as well, which are well summed up in the URPS of FURPS+.

## Use Cases}
Use cases describe the interaction of the user with the system as text stories called scenarios.  This is a widely used approach to requirements analysis in modern software practice.  This way, requirements are discovered and recorded through use cases.  All other activities are then influenced by use cases!

Here's an example use case: we've got a Point-of-sale (POS) system.  Process Sale (Use Case): A customer (Actor) arrives at checkout with items to buy.  The cashier (Actor) uses the POS system to record each purchased item.  The system presents a running total and line-item details.  The customer enters payment information, which the system validates and records.  The system updates inventory.  The customer receives a receipt.  This is the main success scenario.  The use case is a collection of scenarios: main success scenario, and scenario variations.

Use Cases can have take many forms.  We've got the Brief format, which is a one-paragraph summary, usually for the main success scenario.  We've got the Casual format, which consists of multiple paragraphs that cover various scenarios.  Then we've got the fully dressed format, which includes all steps and variations written down.  This is developed iteratively.

## Software Development Processes
The software process puts together software lifecycle activities, including the requirements analysis, design, implementation, testing, deployment, and maintenance.  It also forces attention to these activities and their artifacts.

There are a few different kinds of software development processes.  The benefits of having a software process is that you have a framework to work within, a management tool for unruly systems, and it forces attention to important activities and artifacts.  With a process though, you risk focusing too much attention on process, which can have a negative impact on the development team.  This can slow down development.  Sometimes, a process requires substantial expertise and a learning curve, which can further slow things down.  Let's go through a few of these methods.

### Code-And-Fix or ad-hoc Process

This is where you write some code, make up some inputs, and debug.  Some advantages of this are that there is little or no overhead.  You can just dive in and see progress quickly.  It's applicable for very small, very short-lived projects, but dangerous for most projects.  This process may ignore important tasks and artifacts (design, testing).  Sometimes it's not clear when to start or stop an activity.  It can be hard to review, and scales poorly to multiple people.


### Waterfall Process

\includegraphics[width=\textwidth]{waterfall.png}
This process is best suited for projects with a long life cycle, of 6 months or more.  This is a traditional engineering approach applied to software development, which can work well for projects with very well understood requirements.  You tackles all planning up front with an orderly, easy to follow, sequential process.  Stages are well-defined, so it's easy to perform reviews at each stage to determine if the product is ready to advance.  It's ideal for experienced teams on short term projects.

There are some drawbacks to using the Waterfall process though.  Waterfall assumes requirements are clear and well-understood, and most planning is done upfront.  This is bad when requirements change; it's rigid and sequential, and does not embrace change well.  It can be costly to “swim upstream” back to an earlier phase because iteration is limited to the previous or next step.  There's also no sense of progress until the very end.  Integration also occurs at the very end, which defies the “integrate early and often” rule.  It's inflexible, so you get no feedback until the very end.  The product may ultimately not match the customer’s need!  Reviews are also massive affairs (inertia).  Don't really recommend.

### Iterative Process
\includegraphics[width=\textwidth]{iterative.png}
The iterative process accommodates and embraces change.  It provides constant feedback, and problems are visible early.  It's appropriate at the beginning of the project when requirements are still fluid.  You also always address the biggest risk first, so as costs increase, risks decrease!

It's not great all the time though; this development process can take a lot of planning and management, and there are frequent changes of task.  It requires customer and contract flexibility, developers must be able to assess risk, and must also address the most important issues.

### Staged Delivery

\includegraphics[width=\textwidth]{staged.png}
The advantages of staged delivery are that you can ship at the end of any release, which looks like success to customers, even if you don't hit the original goal.  Intermediate deliveries show progress, customers are happy, and this leads to feedback on how to best attack new issues.  Problems are visible early, which facilitates shorter more predictable release cycles.  It's practical, widely used, and successful, though requires flexibility of management, developers, and users.

### Open Source Development

\includegraphics[width=\textwidth]{oss.png}
This is distributed development, where individuals or small teams of contributors are responsible for the development and maintenance of code.  Contributed features are integrated into a single body of code by one or more maintainers, which ensures that newly submitted code meets the overall vision and standards set for the project.  Feature development life-cycle begins with an idea for a new project feature or enhancement, which is then proposed to project developers.  There is online discussion among contributors, and the features are released as alpha software.

Feature requests are generally tracked and prioritized using processes that are visible to the rest of the development community, which ensures a common understanding of features and their relative priority, their development status, associated bugs and blockers, planned release.

The open source development process encourages transparency and distributed collaboration; many eyes make for fewer bugs.  Because code submissions can come from anyone, most projects have formal procedures in place to track ownership of code when a patch is submitted.

The OSS development model has an interwoven development cycle with constant feature development.  Thus, you release Early and Often, and are subject to peer Review.  Some open source successes include the Linux Kernel, GNU toolchain, LibreOffice, Python Etc.