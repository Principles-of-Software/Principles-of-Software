# Software Processes

Some software lifecycle activities require analysis, design, implementation, integration, testing, verification, deployment, and maintenance.  A software development process puts all of these things together, but how?  In what order?

## Software Life cycle and Artifacts

The **Software Lifecycle** is <span style="color:blue;">the process of building and maintaining a software system</span>.  The activities from inception to end-of-life can take months or years.  Each activity has specific goals.  It defines a clear set of steps, produces an artifact (tangible item), allows for review, and specifies actions to perform in the next activity.

Prescribed activities create valuable artifacts:

1. **Requirements Analysis** <span style="color:blue;">produces requirements documents and supplementary specifications</span>
2. The **Design Process** <span style="color:blue;">produces design models and artifacts</span>
3. **Implementation** <span style="color:blue;">produces readable, modular code</span>
4. **Testing** <span style="color:blue;">produces test suites as artifacts</span>
5. **Maintenance** <span style="color:blue;">continues software development processes at a smaller scale throughout the whole system for the software's lifecycle</span>

## Steps

### Step 1: Requirements Analysis and the Use-Case Model

A **Use-Case Model** is a <span style="color:blue;">model of how different types of users interact with a system to solve a problem</span> using text stories called scenarios.  A user can also be called an actor or a role at this stage.

A dice game on a gaming platform is an excellent example of a use case.  The main success scenario is:

1. Player (actor) picks up the two dice and rolls them
2. If the player rolls a seven or "doubles" (the dice match), then the player wins
3. If not, then another player gets the chance to roll

Use Cases can take many forms.  First, we have the **Brief Format**, a <span style="color:blue;">one-paragraph summary, usually for the main success scenario</span>.  Next is the **Casual Format**, which <span style="color:blue;">consists of multiple paragraphs covering various scenarios</span>.  Finally, the **Fully Dressed Format** <span style="color:blue;">includes all possible steps and variations the system is capable of supporting</span>.  Use cases are developed iteratively and often go through each stage in turn.

### Step 2: Design Process

The design process is to be taken seriously; iterating over multiple possible designs until developers and clients agree on UI and specifications is the best way to guarantee success and reduce production costs over the long run.

Part of the **Design Process** <span style="color:blue;">includes creating interaction, class, and UML diagrams</span>, all of which are shown below:

![](images\interaction_diagram.png)

![](images\class_diagram.png)

![](images\umlex.png)

### Step 3: Implementation

The implementation process is based on the requirements and designs defined above and should be the shortest step.  Coding according to the dice game specs should produce something like this:

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

### Step 4: Testing

Write Unit Tests after specifications, but before code.  Then, once those are squared away, move on to System Tests.  Then, after implementation is done, Integration Tests.  There is a helpful chapter in this book called Testing, which readers are encouraged to consult before this one.

### Step 5: Maintenance

This step is iterative and lasts for as long as the code exists.  Maintenance involves Bug Fixes, Enhancements, and Refactoring until the system's end of life.

Other Engineering disciplines have similar processes.  For example, Civil engineering has:

- Requirements: architectural design
- Design: engineering blueprints
- Implementation: Construction
- Testing: Inspections throughout construction and after completion
- Maintenance: inspections, repair, and upgrades

The main differences between software engineering and other disciplines are that requirements changes do not creep into construction; changing requirements in the middle of an extensive physical system is costly, while it is easy to do in code.  Most engineering design and construction also use tried and true materials and techniques because it is a large physical system.  Engineers are looking for well-built systems rather than innovation.  In contrast, it is easy to innovate in software because breaking things usually has little to no consequence in the real world - disasters are caught at or before the testing phase.  Additionally, construction projects are usually (mostly) on time, while software projects tend to have much more variable timelines.

## Requirements

Requirements analysis is complicated.  Some significant causes of project failure are poor user input, incomplete requirements, and changing requirements.  Some essential tools are requirements documents and use cases.

Requirements can be complex because they change; errors can be found in original requirements, so they must conform with what works.  The customer also needs to evolve to match new requirements.  Technical, scheduling, and cost problems can arise here because system requirements change as the world does.  It is also often difficult to understand the implications of software design changes and other requirements.  This following graph illustrates this relationship well:

![](images\reqs.png)

There are a few ways to measure complexity.  For example, there are **Function Points**, <span style="color:blue;">roughly the number of user interactions within the system</span>, **Cyclomatic Complexity**, the <span style="color:blue;">number of predicate nodes in a control flow graph</span>, and lines of code.  The following graph illustrates some of this well:

![](images\fpoints.png)

Requirements can be classified in a few different ways.  For example, the **FURPS+ Model** is an acronym for <span style="color:blue;">Functionality, Usability, Reliability, Performance, and Supportability</span>.  The + stands for design constraints, implementation requirements, and anything else specific to the system.

## Software Development Processes

The software process puts together software lifecycle activities, including requirements analysis, design, implementation, testing, deployment, and maintenance.  It also forces attention to these activities and their artifacts.

There are a few different software development strategies.  The benefits of having a software process are the provided framework to work within, a management tool for unruly systems, and the forced attention to essential activities and artifacts.  However, With a process, developers risk focusing too much on process artifacts, hurting their team and slowing development.  Sometimes, a process requires substantial expertise and a learning curve, which can further slow things down.

### Code-And-Fix or Ad-Hoc Process

The **Code-And-Fix** or **Ad-Hoc** process is familiar to those readers who have taken RPI's data structures: <span style="color:blue;">developers write some code, make up inputs, and debug accordingly</span>.  Some advantages of this are that there is little or no overhead; programmers can dive right in and see progress quickly.  This process is useful for small, short-lived projects, but is dangerous for most other projects.  This process may ignore important tasks and artifacts such as design or testing.  Sometimes, it is not clear when to start or stop an activity.  In addition, it can be hard to review code with the ad-hoc method, so scales poorly to multiple people.

### Waterfall Process

![](images\waterfall.png)

With the **Waterfall Process** process, <span style="color:blue;">developers tackle all planning up front with an orderly, easy-to-follow sequential process</span>.  Stages are well-defined, so reviews at each stage determine if the product is ready to advance.  Thus, the waterfall process is ideal for experienced teams on short-term projects and projects with very well-understood requirements.  

There are some drawbacks to using the Waterfall process, though.  Waterfall assumes requirements are clear and well-understood, and most planning is done upfront.  Because of that assumption, its rigid and sequential nature does not embrace change well.  It can be costly to "swim upstream" back to an earlier phase because iteration is limited to the previous or next step.  

There is also no sense of progress until the very end - Integration occurs then, which defies the "integrate early and often" rule.  This practice increases inflexibility because there is no feedback until the very end.  At its worst, the product may ultimately not match the customer's need.  Reviews are also massive affairs due to inertia.  The writers of this book do not recommend the waterfall method.

### Iterative Process

![](images\iterative.png)

The iterative process accommodates and embraces change.  It provides constant feedback, so problems are visible early.  The iterative process is especially apt at the beginning of any project when requirements are still fluid.  Additionally, the most significant risks are usually addressed first, so as costs increase, risks decrease.

However, the iterative process could be better; it can take a lot of planning and management, and there are frequent changes in tasks.  In addition, this process requires customer and contract flexibility, as well as developers able to assess risk accurately.

### Staged Delivery

![](images\staged.png)

With **Staged Delivery**, <span style="color:blue;">developers can ship their product at the end of any release, which looks like a success to customers, even if all original goals are not met</span>.  Intermediate deliveries show progress and customers are happy, leading to feedback on how to best attack new issues.  Problems are also visible early, facilitating shorter, more predictable release cycles.  Staged delivery is practical, widely used, and successful, though it requires the flexibility of management, developers, and users.

### Open Source Development

![](images\oss.png)

**Open Source Development** uses a distributed model, where <span style="color:blue;">individuals or small teams of contributors are responsible for the development and maintenance of code</span>.  Contributed features are integrated into a single body of code by one or more maintainers, which ensures that newly submitted code meets the overall vision and standards set for the project.  The feature development lifecycle begins with an idea for a new project feature or enhancement, which is then proposed to project developers.  There is online discussion among contributors, and the features are released as alpha software.

Feature requests are generally tracked and prioritized using processes visible to the rest of the development community, ensuring a common understanding of features and their relative priority, development status, associated bugs, blockers, and planned release.

The open-source development process encourages transparency and distributed collaboration, as many eyes make for fewer bugs.  In addition, because code submissions can come from anyone, most projects have formal procedures to track code ownership when a patch is submitted.

The OSS development model has an interwoven development cycle with constant feature development - its structure ensures early and frequent release and peer review.  Some open-source successes include the Linux Kernel, GNU toolchain, LibreOffice, Python, and the repository this text is hosted on.