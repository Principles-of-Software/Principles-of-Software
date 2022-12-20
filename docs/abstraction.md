# Abstraction
**Abstraction** is <span style="color:blue;">the hiding of unnecessary low-level details</span>.  Thus, abstractions that include unimportant information are useless.  They are also unhelpful when they fail to include necessary information, which defeats their purpose.  The point of having abstractions instead of reading code is to minimize the burden of remembering all that code.  **Cognitive Load** is <span style="color:blue;">the amount of knowledge a programmer must have to work on the code base</span>.  Abstractions are meant to make life easier.  **Information Hiding** is <span style="color:blue;">a design principle that hides the parts of a program likely to change from the client</span>.  An **Abstract Data Type (ADT)**, then, is <span style="color:blue;">an encapsulation of an object and its operations</span>.

## Abstract Data Types (ADTs)
In addition to encapsulating an object and its operations, ADTs can be a specification mechanism, a way of thinking about programs, and a useful design tool.  Organizing and manipulating data is pervasive in code, though inventing and describing algorithms is not.

Thus, we should consider data representation when designing large software systems.  Before implementation, consider the data model; what is the data representing?  Will the necessary operations operating on it be efficient without compromising understandability?  ADTs solve this problem by shielding users from implementation; clients do not directly depend on the program's internals.

## Control Abstraction (Procedural Abstraction)
**Control Abstraction**, or **Procedural Abstraction**, is <span style="color:blue;">the procedure for implementing code according to specifications, where method names, method signatures, and specifications are exposed to the client, but implementation is hidden</span>.  One part of this is a **Method Signature**, sometimes referred to simply as a **Signature**, which <span style="color:blue;">provides a method's name, parameter types, and return type</span>.  With these pieces, ADTs supply the abstraction barrier between implementation and representation.

## Data Abstraction
**Data Abstraction** is where <span style="color:blue;">the data representation of a class is hidden from the client</span>.  For example: how are strings implemented in Java?  Are they fixed arrays of characters?  Linked lists?  Data abstraction abstracts the use of information away from its representation.  A string is an abstraction for an array of characters.

## ADT Methods
We can group the methods of an ADT into creators, observers, producers, and mutators, which all relate to an object `O` of type `T`.  **Creators** <span style="color:blue;">create a new object of type `T`</span>; constructors are creators.  **Observers** <span style="color:blue;">return information about `O`</span>; getter methods are observers.  **Producers** <span style="color:blue;">return a new object of type `T` by performing operations on the given object `O`</span>.  **Mutators** <span style="color:blue;">change the object `O`</span>; setter methods are mutators.

ADTs can be immutable or mutable.  **Immutable Objects** <span style="color:blue;">cannot be changed</span>, while **Mutable Objects** <span style="color:blue;">can be changed</span>.  No mutators exist in an immutable object's ADT, and producers are rare when specifying the ADT for a mutable object.

## ADT Java Language Features
In Java, ADT operations are usually **public**, or <span style="color:blue;">accessible to users</span>, and other operations are **private**, or <span style="color:blue;">inaccessible to users</span>.  We will talk more about this in the context of access control modifiers in the Java section of this text.  Clients can only access ADT operations.  Because ADTs rarely have producers and are most often immutable, new ADTs must be created to change older ones.  An ADT is a specification, or a set of operations.

![](images/jadt.png)

## Domain
The mathematical concepts of domain and range also apply to ADTs.  In a data type, the **Domain** <span style="color:blue;">consists of all implementations that satisfy the representation invariant</span>.  The representation invariant simplifies the abstract function by restricting its domain.  The **range** of an ADT is <span style="color:blue;">the restriction of its possible stored values</span>.  The range can be tough to denote relative to the domain; it is easy for mathematical concepts like sets, but hard to define for real-world ADTs.  For instance, in a set, the range might be restricted to the type of value it can contain.  In other data types, the same range could be applied, but may also contain artifacts from the specifications of the ADT, such as a value range or a maximum length to a list.

## Representation Invariants
The **Representation Invariant** <span style="color:blue;">states the constraints specific data structures and algorithms impose</span>.  For example, a binary tree's representation invariant should verify that it has no cycles.

Representation Invariants also describe whether or not ADTs are well formed.  They must be true before and after every method is executed.  In that way, they are like loop invariants - they do not need to hold during execution.  The correctness of operation implementation depends on well-formed data.  Luckily, the representation invariant ensures correctness by excluding values that do not correspond to abstract values.  If the data does not matter, then the representation invariant does not care.

**Representation Exposure**, <span style="color:blue;">when a necessary aspect of the ADT is left out of the representation invariant</span>, is a significant problem.  We can avoid making representation exposures by practicing **Defensive Programming**, where we <span style="color:blue;">write code assuming that the client will make mistakes</span>: checking the representation invariant, preconditions, and postconditions against the implementation.  The role of the representation invariant is to simplify the abstraction function by limiting valid concrete values, which then limits the domain of the abstraction function.

## Reasoning About ADTs
The best way to start coding is to design and plan carefully by writing specifications, representation invariants, and abstraction functions.  However, more is needed.  After designing and implementing according to spec, the code must be verified using reasoning.  Verification aims to prove that its implementation satisfies the specifications.  Verification can be difficult, depending on the program.  Luckily, it is also possible to use proofs to verify that the representation invariant holds.

In Java, we can add a **`checkRep()` method** that <span style="color:blue;">checks implementation by verifying the representation invariant after each method</span>.  Of course, if the ADT is immutable, the representation invariant does not require checking beforehand, but it is always good practice to make sure.  Unfortunately, exhaustively testing for representation exposures is often impossible, so we have to choose well what goes into the `checkRep()` method.

Through reasoning, we can prove that all objects satisfy the representation invariant.  Know how to use reasoning appropriately; thorough testing can be easier than representation invariants to implement.  When it is not, we can prove that all objects satisfy the representation invariant through induction and considering all ways to make a new object with creators and producers.

## Induction
Reasoning about ADTs uses induction.  When reasoning about representation invariants, the inductive step must consider all possible changes to the representation, including representation exposure.  If the proof does not account for representation exposure, this is invalid.

The steps to successful induction are as follows:

1. **Initial Step**: <span style="color:blue;">Prove the proposition is true for n = 0</span>.
2. **Inductive Step**: <span style="color:blue;">Prove that if the proposition is true for n = k, then it must also be true for n = k + 1</span>.  This step is complex, and breaking it up into several stages helps.
	- **Inductive Hypothesis**: <span style="color:blue;">Assume what the proposition asserts for the case n = k</span>.
	- **Step 2**: <span style="color:blue;">Write down what the proposition asserts for the case n = k + 1.  This is what the induction proves</span>.
	- **Step 3**: <span style="color:blue;">Prove the statement in Stage 2 using the assumption in Stage 1</span>.  The technique varies from problem to problem, depending on the mathematical content.  Use ingenuity, common sense, and knowledge of mathematics here.  Additionally, RPI's Foundations of Computer Science class and associated text have suitable methods for solving proofs with induction.

## Review
The Representation Invariant defines the set of valid objects in implementation.

The Abstraction function defines, for each valid object, which abstract value it represents.

Together, they modularize the abstract data type's implementation, making it possible to reason about operations in isolation.  Neither is part of the ADT abstraction.