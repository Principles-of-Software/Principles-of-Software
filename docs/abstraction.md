# Abstraction
\textbf{abstraction} is the hiding of unnecessary low-level details.  Thus, abstractions that include unimportant information are useless.  They are also unhelpful when they fail to include necessary information, which defeats their purpose.  The point of having abstractions instead of reading code is to minimize the burden of remembering all that code.  \textbf{cognitive load} is the amount of knowledge a programmer must have to work on the code base.  Abstractions are meant to make life easier.  \textbf{Information Hiding} is a design principle that segregates and hides the parts of a computer program likely to change.  An \textbf{Abstract Data Type (ADT)}, then, is an encapsulation of an object and its operations.

## Abstract Data Types (ADT's)
In addition to encapsulating an object and its operations, ADTs can be a specification mechanism, a way of thinking about programs, and a useful design tool.  Organizing and manipulating data is pervasive in code, though inventing and describing algorithms is not.  \\\\
Thus, we should consider data representation when designing large software systems.  Before implementation, consider the data model; what is the data representing?  Will the necessary operations operating on it be efficient without compromising understandability?  ADTs solve this problem by shielding users from implementation; clients do not directly depend on the program's internals.

## Control Abstraction (Procedural Abstraction)
Control abstraction is the procedure for implementing code according to specifications.  \textbf{Control Abstraction}, or \textbf{Procedural Abstraction}, is where method names, method signatures, and specifications are exposed to the client, but implementation is hidden.  One part of this is a \textbf{method signature}, sometimes referred to simply as a signature, which provides the name, parameter types, and return type of a method.  ADTs supply the abstraction barrier between implementation and representation.

## Data Abstraction
\textbf{Data Abstraction} is where the data representation of a class is hidden from the client.  For example: how are strings implemented in Java?  Are they fixed arrays of characters?  Linked lists?  Data abstraction abstracts the use of information away from its representation.  A string is an abstraction for an array of characters.

## ADT Methods
We can group the methods of an ADT into creators, observers, producers, and mutators, which all relate to an object $O$ of type $T$.  \textbf{Creators} create a brand new object of type $T$; constructors are creators.  \textbf{Observers} return information about $O$; getter methods are observers.  \textbf{Producers} return a new object of type $T$ by performing operations on the given object $O$.  \textbf{Mutators} change the object $O$; setter methods are mutators.\\\\
ADTs can be "immutable" or "mutable" - \textbf{immutable} objects cannot be changed, while \textbf{mutable} objects can be changed.  No mutators exist in an immutable object's ADT, and producers are rare when specifying the ADT for a mutable object.

## ADT Java Language Features
In Java, ADT operations are \textbf{public}, or accessible to users, and other operations are \textbf{private}, or inaccessible to users.  Clients can only access ADT operations.  Because ADTs rarely have producers and are most often immutable, new ADTs must be created to change older ones.  ADT is a specification, a set of operations.
\includegraphics[width=\textwidth]{jadt.png}

## Domain
The mathematical concepts of domain and range also apply to ADTs.  In a data type, the \textbf{domain} is all implementations that satisfy the representation invariant.  The representation invariant simplifies the abstract function by restricting its domain.  The \textbf{range} of an ADT is the restriction of its possible stored values.  The range can be tough to denote relative to the domain; it is easy for mathematical concepts like sets but hard to define for real-world ADTs.

## Representation Invariants
The \textbf{Representation Invariant} states constraints imposed by specific data structures and algorithms.  For example, a binary tree's representation invariant should verify that it has no cycles.
\newline
\newline
Representation Invariants also describe whether or not ADTs are well formed.  They must be true before and after every method is executed; they are like loop invariants - they do not need to hold during execution.  The correctness of operation implementation depends on well-formed data.  Luckily, the representation invariant excludes values that do not correspond to abstract values.  If the data does not matter, the representation invariant does not care.
\newline
\newline
\textbf{Representation Exposure}, when a necessary aspect of the ADT is left out of the representation invariant, is a large problem.  We can avoid making representation exposures by practicing \textbf{defensive programming}, where we write code assuming that the client will make mistakes: checking the representation invariant, preconditions, and postconditions against the implementation.  The role of the representation invariant is to simplify the abstraction function by limiting valid concrete values, which limits the domain of the abstraction function.

## Reasoning About ADTs NOTE: ADD INDUCTION DEFINITION
The best way to start coding is to design and plan carefully by writing specifications, representation invariants, and abstraction functions.  However, more is needed.  After designing and implementing according to spec, the code must be verified using reasoning.  Verification aims to prove that its implementation satisfies the specifications.  Verification can be difficult, depending on the program.  Luckily, it is also possible to use proofs to verify that the representation invariant holds.

In Java, we can add a \textbf{checkRep()} method that checks implementation against the representation invariant by verifying the representation invariant after each method.  If the ADT is immutable, the representation invariant does not require checking beforehand, but it is always good practice to make sure.  Unfortunately, it is often impossible to exhaustively test for representation exposures, so we have to choose well what goes into the checkRep() method.

Through reasoning, we can prove that all objects satisfy the representation invariant.  Know how to use reasoning appropriately; thorough testing can be easier than representation invariants.  When it is not, we can prove all objects satisfy the representation invariant through induction and considering all ways to make a new object with creators and producers.

Reasoning about ADT's uses induction.  When reasoning about representation invariants, the inductive step must consider all possible changes to the representation, including representation exposure.  If the proof does not account for representation exposure, this is invalid.  

## Review
The Representation Invariant defines the set of valid objects in implementation.

The Abstraction function defines, for each valid object, which abstract value it represents.

Together, they modularize the abstract data type's implementation, making it possible to reason about operations in isolation.  Neither is part of the ADT abstraction.