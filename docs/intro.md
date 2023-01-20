# Introduction

This course is about writing correct code.  <span style="color:blue;">Correct</span> in this case describes code that is <span style="color:blue;">error free, maintainable, and does what we want it to do</span>.
To that end, we must ask a few questions about writing correct code:

1. How can we describe the code we intend to write in an enforceable way?
2. How can we guarantee that our code matches our specifications?

The remainder of this book and the course that goes along with it will illuminate the answers.  Though they may seem logically intuitive initially, these concepts are essential in industry and academia.

## Correctness

Correct code is error-free code that does what we want it to do.  That seems simple, right?  No.  Correct code also implies:

1. <span style="color:blue;">maintainability</span>, which we'll get to later
2. that the code adequately matches its specifications.

Programmers achieve correctness through <span style="color:blue;">principled design and development</span>, <span style="color:blue;">abstraction and modularity</span>, and <span style="color:blue;">documentation</span>.  We will outline specific ways to go about doing all of this later.  Additionally, readers can find information about abstraction in the ADT sections, modularity in the Design Pattern and Refactoring sections, and documentation in the Java Doc section.  <span style="color:blue;">Principled design and development</span> refer to programming with the best practices outlined in this book.

 We are also interested in verifying correctness.  Students will do that through <span style="color:blue;">reasoning about code, testing</span>, and <span style="color:blue;">automated verification</span>.  The Halting Problem and Rice's Theorem together prove that these are necessary concepts worthy of attention.  Luckily, correctness is provable in specific cases, and the usefulness of doing so is immense:

> Almost all (92\%) of catastrophic system failures result from incorrect handling of non-fatal errors explicitly signaled in software... In 58\% of the catastrophic failures, the underlying faults could easily have been detected through simple testing of error handling code.
>
> - Ding Yuan et al., Simple Testing Can Prevent Most Critical Failures: An Analysis of Production Failures in Distributed Data-Intensive Systems, 2014

We care about correctness because caring, paired with adequate designing and testing, stops catastrophic failures from occurring often and ultimately saves money and lives.  Programming errors cost the U.S. economy \$60 billion annually in lost efficiency and real harm.  Here are a few examples of such failures:

- **The Mariner 1 Spacecraft, 1962**: before NASA sent a person to space, they sent an unmanned space ship to fly past Venus.  An omitted hyphen caused the craft to veer off course and, fearing a devastating crash-landing moments after launch, the ship self-destructed.  <span style="color:blue;">Total present-day cost of failure: \$169 million</span>.
- **The Morris Worm, 1988**: Then-graduate student Robert Tappan Morris is credited with creating the first software virus, which he sent through an early version of the internet.  Dr. Tappan is now a professor at MIT, and is known for exposing an early digital vulnerability through helpful, chaotic mischief.  <span style="color:blue;">Total present-day cost of failure: \$25 million</span>.
- **Bitcoin Hack, Mt. Gox, 2011**: Mt. Gox was the biggest bitcoin exchange in the world in the 2010's, until they were hit by a software error that ultimately proved fatal.  The glitch led to the exchange creating transactions that could never be fully redeemed, costing up to <span style="color:blue;">Total present-day cost of failure : \$2 million</span>.
- **NASA’s Mars Climate Orbiter, 1998**: The Mars Climate Orbiter burned up after getting too close to the surface of Mars because there was a software error in converting imperial units to metric.  <span style="color:blue;">Total present-day cost of failure: \$580 million</span>.
- **Y2K, 2000**: At the turn of the twenty-first century, software users were concerned that computer systems around the world would not be able to cope with dates after December 31, 1999, because most computers and operating systems only used two digits to represent the year.  Software systems handled the situation well, though governments and citizens alike around the world spent a lot of money preparing for the inevitable collapse.  <span style="color:blue;">Total present-day cost of distrust in the technology: \$172 billion</span>.

The list goes on and on, but hopefully this is enough to convince even the most wary computing students that paying attention to what your software does in the world is very, very important.

## Maintainability

What does code require to be <span style="color:blue;">maintainable</span>?  The code base should be <span style="color:blue;">well-organized, consistent, well-documented, understandable</span> (this is up for interpretation, but can also very importantly refer to variable naming conventions), and <span style="color:blue;">follow the Open-Closed Principle</span>:

> Be open for extension, but closed for modification.

For example, suppose we have an editor that manipulates two-dimensional shapes.  We have created Square and Circle objects, and have a program that moves these shapes around the user's screen.  Adding a Triangle (<span style="color:blue;">open for extension</span>) should be easy without any changes to the existing code that manipulates shapes (<span style="color:blue;">closed for modification</span>).  Modularity depends on the open-closed principle; good programmers do well to remember it.

We can achieve <span style="color:blue;">maintainability</span>, like correctness, through <span style="color:blue;">principled design and development, abstraction and modularity</span>, and <span style="color:blue;">documentation</span>, with the addition of <span style="color:blue;">correct object-oriented approaches</span>.  These are the best practices for software development.  It is vital to take these concepts to heart in this course.

## Complexity

So... why is software so hard?  Software is not very aptly named, is it?  Writing software is hard because of <span style="color:blue;">complexity</span>, and by extension, the symptoms of complexity.  At its core, programming well is about managing <span style="color:blue;">complexity</span> - anything related to a software system's structure that makes it hard to understand and modify.

We manage complexity through modular design.  Software is composed of a collection of relatively independent modules.  A class, a subsystem, a service, or even a method in a script, can all be considered modules.  In an ideal world, modules act entirely independently of one another.  However, modules always have to depend on one another, something we call a <span style="color:blue;">dependency</span>.  Managing these dependencies manages the complexity of the overall system.

One way to manage complexity is to separate the interface from the implementation: the user interacts with a module through an interface, where everything the module does is abstracted away from the user.

How does complexity arise in the first place?  Complexity is sneaky; it creeps into code over time, and if its causes go untreated, it can be fatal to the affected systems.  <span style="color:blue;">Dependencies</span> typically cause complexity.  Dependencies exist when pieces of code cannot be understood without one another.  <span style="color:blue;">Obscurity</span> in code is the existence of dependencies, and is the opposite of the open-closed principle.  When multiple files need modification during debugging or feature creation, dependencies are present.  Luckily, some amount of dependencies are unavoidable - systems with multiple parts require dependencies to link all their modules together.  However, generally avoiding excessive dependency reduces cognitive load during programming.

What are some symptoms of complexity?  <span style="color:blue;">Change amplification</span>, where simple changes in one module require disproportional amounts of changes in other files, is a telling sign of complexity.  Good design's primary goal is to reduce change amplification in the system, reducing cognitive load on the programmer.  <span style="color:blue;">Cognitive load</span> is the amount of knowledge a system developer needs to contribute to a code base.  How will programmers fix bugs and meaningfully contribute if it is unclear what their code is doing?  Best case, each new feature will require excessive code modification, because developers spend more time acquiring enough information to make changes safely.  Worst case, programmers lack the necessary information and break the system.  The bottom line is that complexity makes modifying an existing code base difficult and risky.

## Software Engineering

Building correct software is complicated.  Large software systems are enormously complex; they consist of many moving, perpetually-changing parts.  Large systems often face problems scaling up due to poor <span style="color:blue;">specification quality</span>, which can cause <span style="color:blue;">code smells, bugs</span>, and <span style="color:blue;">misuse</span> of the resulting product.

Software engineering is about mitigating complexity, managing change, and handling software failures.

## Tools

Principles are more important than tools, but good tools are important for acting on principles.  In RPI's version of this class, we use:

- Java: an industry-standard object-oriented programming language
- Eclipse: powerful integrated development environment (IDE)
- Git: version control (more on this coming up)
- JUnit 4: a testing framework for Java
- Submitty: a homework submission server developed by RCOS (Rensselaer Center for Open Source) at RPI.  Submitty is a system for submitting assignments, auto-testing code submissions, and assigning grades.

<span style="color:blue;">Version control</span> records changes to files over time.  With version control, developers may:

- <span style="color:blue;">Checkout</span> (download) files from a centralized repository into a local machine
- Add local files to the centralized repository, where other users can see, obtain, and modify them
- <span style="color:blue;">Commit</span> changes by adding file changes to the repository
- Update local files relative to the repository

With version control, programmers can also <span style="color:blue;">merge</span> files.  Merges occur when multiple users have modified the same file in a repository.  Hopefully, the changes do not conflict, though sometimes they do.  When changes cannot automatically merge, programmers manually resolve conflicts as they occur.

## JUnit testing framework

<span style="color:blue;">JUnit</span> is a unit testing framework for Java that supports writing and running unit tests.  <span style="color:blue;">Unit testing</span> is a testing class whose scope is just one module.  In object-oriented programming, the smallest testable unit is the class.  Therefore, unit testing can also be called class testing.

JUnit uses annotations to specify test runs:

- `@BeforeClass` is the static method that configures the test run.  The JUnit framework runs this method before all tests and creates an instance of the module being tested
- `@Test` marks a method as a test method; it is run in JUnit as a test
- `assertEquals` takes in an expression and its expected result, and displays a message if the two arguments match.
    - Syntax for this is: `assertEquals(message, expected_result, expression)`
- `assertTrue` takes in a boolean expression and displays a message if the expression resolves to `true`.
    - Syntax for this is: `assertTrue(message, boolean_expression)`

For example:

    public class SaleTest {
        private static Sale sale = null;
        private static double ITEM_PRICE = 2.5;
     
        @BeforeClass
        public static void setupBeforeTests() { sale = new Sale(); }
     
        @Test
        public void testGetTotal() {
            sale.makeLineItem( "item1", 1, ITEM_PRICE );
            sale.makeLineItem( "item2", 2, ITEM_PRICE );
            assertEquals( "sale.getTotal()", 7.5, sale.getTotal() );
        }

## Test-Driven Development (TDD)

Modern software development methodologies, such as Extreme Programming (XP), Agile, and the Unified Process (UP), significantly emphasize unit testing.  They advocate for <span style="color:blue;">Test-Driven Development (TDD)</span>, or test-first development.  The idea is to write all unit tests before writing software and after designing.  Test-first development allows the software engineer to take care of inadequacies in the code base before they even exist.  TDD is also helpful because:

- Unit tests are always written
- Programmers are satisfied with their work, which leads to more consistent test writing
- Correct interface behavior is clarified, so code is easier to write
- Programmers are forced to think about correct inputs, outputs, and edge case handling
- Repeatable, automated verification is built into the code base

## Object Oriented Programming (OOP)
An <span style="color:blue;">object</span> is a piece of software that can store values and perform operations.  Here, value storage is called "state," and operations are called "methods."  Objects are integral to <span style="color:blue;">objecty-oriented programming</span>, a standard of organization many modern programming languages adhere to.  The four object-oriented programming concepts are:

- Inheritance
- Encapsulation
- Abstraction
- Polymorphism

Object Oriented Programming requires discipline.  Luckily, we have codified that discipline into a series of <span style="color:blue;">design principles</span>:

- <span style="color:blue;">Single Responsibility Principle</span>: a class should only have one responsibility
- <span style="color:blue;">Open-Closed Principle</span>: software entities should be open for extension, but closed for modification
- <span style="color:blue;">Interface Segregation Principle</span>: many client-specific interfaces are better than one general-purpose interface
- <span style="color:blue;">Dependency Inversion Principle</span>: one should depend on abstractions instead of concrete implementations

Though it is the only one covered here, object-oriented programming is only one of many ways to think about software.  Object-oriented programming is a superset of <span style="color:blue;">imperative programming</span>, a model which executes a series of steps in a specific order.  <span style="color:blue;">Procedural programming</span> groups instructions into procedures.  In <span style="color:blue;">declarative programming</span>, the programmer declares properties of the desired result, but not how to compute it.  In <span style="color:blue;">functional programming</span>, the result is declared as the value of a series of function applications.  In <span style="color:blue;">logical programming</span>, the result is written as the answer to a question about a system of facts and rules.  Lastly, in <span style="color:blue;">mathematical programming</span>, the result is the solution to an optimization problem.  Studying functional, logical, and mathematical programming outside this class is encouraged, but not required.  These concepts are widely used in industry and higher-level computing courses at RPI.  This class focuses on object-oriented programming as applied to principles of software.
\newpage
