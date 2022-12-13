# Testing
Testing is exactly what it sounds like - executing software to find bugs.  Good testing creates a high probability of finding undiscovered bugs; successful testing discovers those bugs.

    Program testing can be used to show the presence of bugs, but never to show their absence.
    Edsger Dijkstra 1970

We have seven rules for testing:

1. Exhaustive testing is usually not possible
2. A small number of modules usually contain most of the defects (aka defect clustering)
3. The Pesticide Paradox: repetitive use of the same pesticide builds stronger bugs.  Old tests will not find new bugs.
4. Testing shows the presence of defects, not the absence
5. The absence of Error fallacy: absence of evidence is not evidence of absence of bugs!
6. Test early and often
7. Testing is context dependent; different data will reveal different bugs

Testing is complicated because rule number 1 is true.  Exhaustive testing is costly.  The key problem is choosing a set of inputs for the test suite, so it finishes quickly, but is large enough to validate the program.

## Quality Assurance (QA)
We test for quality assurance, so we know our code is good.  We can also use the following:

- static analysis (finding bugs without executing code (by reading the code))
- proofs of correctness (theorems)
- code reviews (peer review)
- software process (good development)

Nothing can guarantee software quality, which is why we have so many checks.  

## Scope (Phases) of Testing
There are a few different kinds of testing: unit testing checks that each module does what it should.  Integration testing verifies that all parts work together as expected.  System testing checks whether the program satisfies functional requirements and works within a large software project.

## Testing Strategies
Unit Testing Tests a single unit in isolation from all others.  In OOP, unit testing means class testing.

Black Box Testing: We ignore the program's code and look at its specification.  Given some input, was the produced output correct according to the spec?  Black Box Tests are specification tests.

Black Box Testing is advantageous because it is robust concerning changes in implementation.  Black box testing is independent of implementation, and the test data does not need to be changed when the code is changed.  It also allows for independent testing, where folks unfamiliar with the code base can contribute.  Most importantly, black box tests can be written before their corresponding code! 

White Box Testing: We use knowledge of the code of the program for white box testing.  We write tests to cover internal paths.  We choose paths with knowledge of the implementation to cover as much ground as possible.

White Box Testing is advantageous because we can ensure that the test suite covers all of the program.  Thus, successful tests with high coverage imply few errors in the program.  The focus is not on features described in the program, but on control-flow details, performance optimizations, and alternate algorithms for different cases.

The bottom line for testing is to test early and often.  Write tests before code!  Catch bugs early, before they propagate through the system.  Automate the process.  Regression testing saves time in the long run!  Be systematic about testing, too; writing tests is an excellent way to understand the spec.  Specs can also be buggy!  When finding bugs, write tests that verify their absence before eradicating them.

## Equivalence Partitioning
Equivalence partitioning divides input and output domains into
equivalence classes.  Equivalence classes are partitions of comparable data from which test cases can be derived.  They usually apply to input data, and it is best to test each partition once.

Intuitively, values from different equivalence classes will drive the program through different paths.  We do not formally define equivalence classes, though we know:

- input values have valid and invalid ranges
- we want to choose tests from the valid and invalid regions and values near or at the boundaries of regions to cover our edge cases

Note that we can only run tests on invalid arguments if the spec tells us what will happen for invalid data.

When partitioning values, carve them into sets of valid data.  Suppose our specification says that valid input is an array of 4 to 24 numbers, and each number is a 3-digit positive integer.  One equivalence class could be the size of an array:

- Classes are $n<4$, $4 \leq n \leq 24$, $n > 24$ 
- Chosen values: $3,4,5, 14, 23,24,25$

Another equivalence class could be integer values:

- Classes are $x<100$, $100 \leq x \leq 999$, $x > 999$
- Chosen values: $99,100,101, 500, 998,999,1000$

Because these dimensions of data are unrelated to one another (orthogonal), we need to test a range of array sizes and values in the array.  We want to get arithmetic boundaries - either the smallest, most significant, or zero values.  Objects should be null, circular, and the same object passed to multiple arguments (aliasing).
\includegraphics[width=\textwidth]{eqpartition.png}

## Control-Flow-Based-Testing
Control Flow Based White Box Testing requires developers to extract a control flow graph (CFG) from the code.  The test suite must cover certain elements of this control-flow graph.  The idea is to define a coverage target and ensure the test suite covers the target.  The coverage target approximates the whole program.

In a CFG, each node represents a block of code.  In that, there is an entry block and an exit block.  Directed edges within the graph represent the control flow.

\includegraphics[width=\textwidth]{if.png}

\includegraphics[width=\textwidth]{else.png}

## Coverage
A traditional coverage target is statement coverage, which covers all statements (nodes) in the CFG.  This way, we can see that code that might never get executed will be tested.

Branch coverage tests all the edges in a CFG, where true/false statements and if/else blocks create branches.  The two branch edges correspond to conditions of the loop.  In modern languages, branch coverage implies statement coverage.

The motivation for branch coverage is to test decision-making in the code.  However, statement coverage does not imply branch coverage because it is possible to hit all nodes without getting full edge-covering.

## Definition-Use (DU) Pairs
A def-use pair consists of a definition and a variable, where at least one path exists from the definition to the use.  For example, $x = 1$ could be a definition, and $y = x + 3$ could be the use.  A DU Path could be from the definition of a variable to the use of the same variable with no other definition of the variable on the path.  Loops can create infinite DU paths.

\includegraphics[width=\textwidth]{du.png}

We want to test all DU pairs, all DU paths, and all definitions.  Sometimes, we do not have possible DU paths, so we make up for the gaps in representation.  Detecting infeasibility can be difficult; in practice, the goal is to get reasonable testing coverage.  Aliasing, infeasible paths, and worst cases can hinder testing, but pragmatism is imperative here.

\includegraphics[width=\textwidth]{infeasible.png}