# Testing
Testing is exactly what it sounds like - executing software to find bugs.  Good testing creates a high probability of finding undiscovered bugs; successful testing discovers those bugs.

>   Program testing can be used to show the presence of bugs, but never to show their absence.
>   - Edsger Dijkstra 1970

We have seven rules for testing:

1.  Exhaustive testing is usually not possible
2.  A small number of modules usually contain most of the defects (aka defect clustering)
3.  The Pesticide Paradox: repetitive use of the same pesticide builds more substantial bugs.  Old tests will not find new bugs.
4.  Testing shows the presence of defects, not the absence
5.  The absence of Error fallacy: absence of evidence is not evidence of the absence of bugs
6.  Test early and often
7.  Testing is context-dependent; different data will reveal different bugs

Testing is complicated because rule number one is true; exhaustive testing is prohibitively costly.  The critical problem is choosing a set of inputs for the test suite so it finishes quickly, but is large enough to validate the program.

## Quality Assurance (QA)

Testing for *quality assurance* is self-explanatory: test code to ensure that it is up to spec.  We can also use the following testing methods:

- static analysis (finding bugs without executing code (by reading the code))
- proofs of correctness (theorems)
- code reviews (peer review)
- software process (good development)

Nothing can guarantee software quality, so we have several different testing methods.  

## Testing Scope

There are a few different testing scopes: **Unit Testing** <span style="color:blue;">checks that each module does what it should</span>.  In Object-Oriented Programming (OOP), unit testing means *class testing*, since classes are easy to break into distinct modules.  **Integration Testing** <span style="color:blue;">verifies that all parts work together as expected</span>.  Finally, **System Testing** <span style="color:blue;">checks whether the program satisfies functional requirements and works within a large software project</span>.

## Testing Strategies

In addition to different scopes, there are a few different testing strategies, or points of view, we can use to cover our bases.

**Black Box Testing** requires developers to <span style="color:blue;">ignore the code and test according to specifications</span>.  Ask, "given some input, is the produced output correct according to the spec?"  Black Box Tests are specification tests; equivalence partitioning, discussed below, is a black box testing strategy.

![](images\bbt.png)

Black Box Testing is advantageous because it is robust concerning changes in implementation.  Furthermore, it is independent of implementation, so test data does not need to be changed when the code is changed.  Black Box Testing also allows for independent testing, where developers unfamiliar with the code base can contribute.  Most importantly, black box tests can be written before their corresponding code; it is good practice to do so.

**White Box Testing** is the practice of <span style="color:blue;">covering all possible internal logical paths of the program</span>.  Choose paths with knowledge of the implementation to cover as many use cases (or input conditions) as possible.  Unit testing, integration testing, and control-flow-based testing are white box testing strategies.

![](images\wbt.png)

White Box Testing is advantageous because the test suite can cover the entire program.  Thus, successful tests with high coverage imply few errors in the program.  The focus is not on features described in the program, but on control-flow details, performance optimizations, and alternate algorithms for different cases.

The bottom line for white and black box testing is to *test early and often*.  Write tests before code to catch bugs early, before they propagate through the system.  Automate the process - thorough testing saves time in the long run.  Be systematic about it, too; writing tests is an excellent way to understand the spec and, by extension, the code.  Specifications can also be buggy - when finding bugs, write tests that verify their absence before eradicating them.

## Equivalence Partitioning

**Equivalence Partitioning** <span style="color:blue;">divides input and output domains into equivalence classes</span>.  Equivalence partitioning is a good variety of black-box testing.  **Equivalence Classes** are <span style="color:blue;">partitions of comparable data from which test cases can be derived</span>.  They usually apply to input data, and it is best to test each partition once.

Intuitively, values from different equivalence classes will drive the program through different logical paths.  We do not formally define equivalence classes, though we know:

- input values have valid and invalid ranges
- we want to choose tests from the valid and invalid regions, and values near or at the boundaries of regions to cover edge cases

Note that we can only run tests on invalid arguments if the spec tells us what will happen for invalid data.

When partitioning values, carve them into sets of valid data.  For example, suppose our specification says that valid input is an array of 4 to 24 numbers, and each number is a 3-digit positive integer.  One equivalence class could be the size of an array:

- Classes are `n < 4`, `4 <= n <= 24`, `n > 24`
- Chosen values: `3, 4, 5, 14, 23, 24, 25`

Another equivalence class could be integer values:

- Classes are `x < 100`, `100 <= x <= 999`, `x > 999`
- Chosen values: `99, 100, 101, 500, 998, 999, 1000`

Because these data dimensions are unrelated, we need to test a range of array sizes and values within the array.  We want to get arithmetic boundaries: the smallest, most significant, or zero values.

![](images\eqpartition.png)

## Control-Flow-Based Testing

**Control Flow Based White Box Testing** requires developers to extract a control flow graph (CFG) from the code; the <span style="color:blue;">test suite must cover essential elements of this control flow graph</span>.  The idea is to define a coverage target and ensure the test suite covers the target.  The coverage target approximates the whole program.

In a CFG, each node represents a block of code.  In that, there is an entry block and an exit block.  Directed edges within the graph represent the control flow.

![](images\if.png)

![](images\else.png)

## Coverage

A traditional coverage target is **Statement Coverage**, which<span style="color:blue;"> covers all statements (nodes) in the CFG</span>.  This way, we can ensure that even code that never gets executed will be tested.

**Branch Coverage** <span style="color:blue;">tests all the edges in a CFG, where true/false statements and if/else blocks create branches</span>.  In a loop, two branch edges correspond to its boolean conditions.  In modern languages, branch coverage implies statement coverage.

The motivation for branch coverage is to test decision-making in the code.  However, statement coverage does not imply branch coverage because it can hit all nodes without a top edge covering.

## Definition-Use (DU) Pairs

A **Def-Use Pair** consists of <span style="color:blue;">a definition and a variable where at least one path exists from the definition to the use</span>.  For example, `x = 1` could be a definition, and `y = x + 3` could be the use.  A DU Path could be from the definition of a variable to the use of the same variable, with no other definition of the variable on the path.  Loops can create infinite DU paths.

![](images\du.png)

We want to test all DU pairs, all DU paths, and all definitions.  Sometimes, there are impossible DU paths, so developers make up for the gaps in representation.  Detecting infeasibility can be difficult; in practice, the goal is to get reasonable testing coverage.  Aliasing, infeasible paths, and worst cases can hinder testing, but pragmatism is imperative here.

![](images\infeasible.png)