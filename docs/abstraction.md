## Data Abstraction

**Data Abstraction** is <span style="color:blue;">where the data representation of a class is hidden from the client</span>.  For example: how are strings implemented in Java?  Are they fixed arrays of characters?  Linked lists?  Data abstraction abstracts the use of information away from its representation.  For example, a string is an abstraction for an array of characters.

## ADT Methods

We can group the methods of an ADT into creators, observers, producers, and mutators, which all relate to an object `O` of type `T`.  **Creators** <span style="color:blue;">create a new object of type `T`</span>; constructors are creators.  **Observers** <span style="color:blue;">return information about `O`</span>; getter methods are observers.  **Producers** <span style="color:blue;">return a new object of type `T` by performing operations on the given object `O`</span>.  **Mutators** <span style="color:blue;">change the object `O`</span>; setter methods are mutators.

ADTs can be immutable or mutable.  **Immutable Objects** <span style="color:blue;">cannot be changed</span>, while **Mutable Objects** <span style="color:blue;">can be changed</span>.  No mutators exist in an immutable object's ADT, and producers are rare when specifying the ADT for a mutable object.

## ADT Java Language Features

In Java, ADT operations are usually **public**, or <span style="color:blue;">accessible to users</span>, and other operations are **private**, or <span style="color:blue;">inaccessible to users</span>.  We will talk more about this in the context of access control modifiers in the Java section of this text.  
Clients can only access ADT *operations*; because ADTs rarely have producers and are most often immutable, new ADTs must be created to change older ones.  This way, an ADT can act as a specification or set of operations.

![](images\jadt.png)

## Domain

The mathematical concepts of domain and range also apply to ADTs.  In a data type, the **Domain** <span style="color:blue;">consists of all implementations that satisfy the representation invariant</span>.  The representation invariant simplifies the abstract function by restricting its domain.  The **Range** of an ADT is <span style="color:blue;">the restriction of its possible stored values</span>.  The range can be tough to denote relative to the domain; it is easy for mathematical concepts like sets, but hard to define for real-world ADTs.  For instance, in a set, the range might be restricted to the type of value it can contain.  In other data types, the same range could be applied, but may also contain artifacts from the specifications of the ADT, such as a value range or a maximum length to a list.

## Representation Invariants

The **Representation Invariant** <span style="color:blue;">states the constraints that data structures and algorithms impose on implementation</span>.  For example, a binary tree's representation invariant should verify that it has no cycles.  An immutable object's representation invariant is that it can never be changed; representation invariants can be as simple as that.

Representation Invariants also describe whether or not ADTs are well formed.  They must be true before and after every method is executed.  In that way, they are like loop invariants - they do not need to hold during execution.  The correctness of operation implementation depends on well-formed data.  Luckily, the representation invariant ensures correctness by excluding values that do not correspond to abstract values.

**Representation Exposure**, <span style="color:blue;">when a necessary aspect of the ADT is left out of the representation invariant</span>, is a significant problem.  We can avoid making representation exposures by practicing **Defensive Programming**, where we <span style="color:blue;">write code assuming that the client will make mistakes: checking the representation invariant, preconditions, and postconditions against the implementation</span>.  The role of the representation invariant is to simplify the abstraction function by limiting valid concrete values, which then limits the domain of the abstraction function.

## Reasoning About ADTs

The best way to start coding is to design and plan carefully by writing specifications, representation invariants, and abstraction functions.  However, more is needed.  After designing and implementing according to spec, the code must be verified using reasoning.  Verification aims to prove that its implementation satisfies the specifications.  Verification can be difficult, depending on the program.  Luckily, it is also possible to use proofs to verify that the representation invariant holds.

In Java, we can add a **checkRep() Method** that <span style="color:blue;">checks implementation by verifying the representation invariant after each method</span>.  Of course, if the ADT is immutable, the representation invariant does not require checking beforehand, but it is always good practice to make sure.  Unfortunately, exhaustively testing for representation exposures is often impossible, so we have to choose well what goes into the `checkRep()` method.

Through reasoning, we can prove that all objects satisfy the representation invariant.  Know how to use reasoning appropriately; thorough testing can be easier than representation invariants to implement.  When it is not, we can prove that all objects satisfy the representation invariant through induction and considering all ways to make a new object with creators and producers.

# Review

The Representation Invariant defines the set of valid objects in implementation.

The Abstraction function defines, for each valid object, which abstract value it represents.

Together, they modularize the abstract data type's implementation, making it possible to reason about operations in isolation.  Neither is part of the ADT abstraction.
