# Specifications

A **Precondition** is a <span style="color:blue;">condition that must be true before method execution</span>, and a **Postcondition** is a <span style="color:blue;">condition that must be true after method execution</span>.  A **Specification** is <span style="color:blue;">a contract between a method and its caller, consisting of a precondition and a postcondition</span>.  Specifications are beneficial because they precisely document method behavior, which makes it easier for programmers to parse the code.  Specifications promote modularity by organizing code into **Modules**, <span style="color:blue;">small chunks called with clear-cut boundaries</span>.  Specifications promote abstraction because the **Client**, <span style="color:blue;">the person or system using the code</span>, can rely on the specification to predict program functionality instead of code.  The client should not need to know the implementation of the code.  

Methods must support their specifications, but their implementation is otherwise free, so the method and client code can be built simultaneously.  Specifications enable reasoning about correctness, which can then confirm correctness through testing and verification.

A specification should be:

- Concise: not too many cases
- Informative and precise
- Specific: strong enough to make guarantees
- General: weak enough to permit efficient implementation

Too weak a spec imposes too many preconditions and gives too few guarantees.  Too strong a spec imposes too few preconditions and gives many guarantees, placing the burden of correctness on the implementation.  For example, an excessively strong precondition might require that an input array be sorted.  In contrast, a weak precondition may not check for ordering and ask the implementation to throw an exception if not.  Extreme specifications hinder efficiency.  Like a class, methods should have one goal; a complex spec is a warning about the design.

## Why not Just Read Code?

Why not just read the code to see what is happening in the system?  Code is complicated; large systems contain more detail than anyone trying to parse the abstractions needs, and understanding code can be a sizeable cognitive burden.  Code is also ambiguous - it is often unclear what is essential and incidental in the code base.  **Incidental Code** is <span style="color:blue;">dead code that comes about as the result of optimization</span>.  Most importantly, the client needs to know what the code does, not how it works!  Even in mathematical and scientific software, the user can only know *some* implementation details.

What about comments?  Those are important, but not sufficient, for proper specification.  They are often informal, ambiguous, or misleading, so they cannot stand in for formal specs.  Comments must also be updated in tandem with the code to avoid problematic misunderstandings, which does not happen often enough in the real world.  Unfortunately, most code lacks specification; programmers guess what it does by skimming through or running it.  Lack of documentation results in bugs and complex code with undefined behavior.  It would be cool to generate code from specifications; this is currently in development and available in some spaces.

## Complexity in Specs

A complex specification is a red flag; it is better to simplify design and code rather than try to describe complex behavior!  Over-complicated specifications indicate that something needs to be fixed or the code needs to be simplified.  Software designers constantly battle complexity, so good specifications help reduce the programmer's cognitive burden.

## Conventions

There are standard specification conventions that make writing readable code easier.  There are many to choose from.

**JavaDoc** specifications are <span style="color:blue;">simple text descriptions of the method's behavior that reside in a method's type signature</span>:

    \*
    * parameters: text description of what gets passed
    * returns: text description of what gets returned
    * throws: list of possible exceptions
    *\
    public String methodName() { ... }

**Principles of Software (PSoft)** specification conventions are also included in the code as comments.  <span style="color:blue;">The precondition is the `requires` clause, and the postcondition is comprised of all other clauses</span>:

    \*
    * requires: clause spells out constraints on client code
    * modifies: lists objects that may be modified by the method.  
    *   Any object not listed under this clause is guaranteed untouched.
    * effects: describes the final state of modified objects
    * throws: lists possible exceptions
    * returns: describes the return value of the method
    *\
    public String methodName() { ... }

A few additional comments describing the function help increase readability for the programmer.

When using PSoft specifications, all tags must be assigned.  Use `none` when fields need to be left blank.  Method signatures are part of the spec but do not need to be written elsewhere.

Sometimes it can be hard to capture all potentially relevant details in the spec.  If required, add more to the specification to make it more specific - just not at the cost of efficiency!

The `requires` clause is critical in PSoft Specifications.  If the client fails to provide preconditions, then the method can do anything it wants -- even throw an exception or return an object of the wrong type.  It is important to double-check the `requires` clause in method implementation.  Checking preconditions makes implementation more robust, provides feedback to the client, and avoids silent errors.  It is not always necessary to check the preconditions of private methods since those are not client-facing and should be compliant with specifications by default.  However, if the method is public, preconditions should be checked unless such a check is computationally expensive.

**Java Modeling Language (JML)** is another important specification convention;  Javadocs and PSoft specifications are not "machine-checkable" languages, whereas JML is.  JML is <span style="color:blue;">a formal specification language built on Hoare logic</span>.  The end goal of JML is automatic verification.  Here is an example of a binary search implementation with JML specs, adapted from the OpenJML Tutorial:

    public class BinarySearch {
        //@ requires sortedArray != null && 0 < sortedArray.length < Integer.MAX_VALUE;
        //@ requires \forall int i; 0 <= i < sortedArray.length; \forall int j; i < j < sortedArray.length; sortedArray[i] <= sortedArray[j];
        //@ old boolean containsValue = (\exists int i; 0 <= i < sortedArray.length; sortedArray[i] == value);
        //@ ensures containsValue <==> 0 <= \result < sortedArray.length;
        //@ ensures !containsValue <==> \result == -1;
        //@ pure
        public static int search(int[] sortedArray, int value) {
            //@ ghost boolean containsValue = (\exists int i; 0 <= i < sortedArray.length; sortedArray[i] == value);
            if (value < sortedArray[0]) return -1;
            if (value > sortedArray[sortedArray.length-1]) return -1;
            int low = 0;
            int high = sortedArray.length-1;
            //@ loop_invariant 0 <= low < sortedArray.length && 0 <= high < sortedArray.length;
            //@ loop_invariant containsValue ==> sortedArray[lo] <= value <= sortedArray[high];
            //@ loop_invariant \forall int i; 0 <= i < low; sortedArray[i] < value;
            //@ loop_invariant \forall int i; high < i < sortedArray.length; value < sortedArray[i];
            //@ loop_decreases high - low;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (sortedArray[mid] == value) {
                    return mid;
                } else if (sortedArray[mid] < value) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
            return -1;
        }
    }

## Autoboxing and Unboxing

A **Primitive Data Type** in Java is <span style="color:blue;">an object whose value is intrinsic and does not have the properties of an object</span>.  However, **Boxing**, <span style="color:blue;">the practice of wrapping primitive values in Java objects</span>, can impart object properties onto primitives.  Boxing is useful when comparing Java objects to primitives.  Java has a feature called **Autoboxing**, <span style="color:blue;">automatically Boxing primitives where needed</span>.  **Unboxing** <span style="color:blue;">automatically converts Java objects (boxed types) to primitive types when required</span>.

Here is an example of Boxing, Autoboxing, and Unboxing:

    int a = 3;      // regular primitive data type
    Integer b = 3;  // AutoBoxing: 3 is automatically converted to Integer,
                    //  int's Java object "wrapper" class
    int c = b;      // Unboxing: Integer 3 to int 3

## Specifications and Dynamic Languages

A type signature is a form of specification in statically typed languages like C/C++ and Java.  In dynamically typed languages, there is no type signature!  So how do we write specs for them?  A method is called for its side effects (`effects` clause) or its return value (`return` clause); it is bad style to have both effects and return blocks.  There are exceptions, though; the main point of a specification is to be helpful.  Overly formal specifications are not helpful, while being too informal does not help either.  

## Comparing Specifications

Sometimes, we need to compare specifications.  Specifications can be compared in two ways:

- by hand, examining each clause
- with logical formulas representing the spec

Use whichever is most convenient; comparing specs enables reasoning about substitutability.  For instance, "`P` is stronger than `Q`" means that, for every implementation `Q`, `Q` satisfies `P -> Q` satisfies `P`.  If the implementation satisfies the stronger spec (`P`), it also satisfies the weaker (`Q`).  However, the opposite is not necessarily true.  In general, we want substantial specifications.  A larger world of implementations satisfies the weaker spec `Q`, then the stronger spec `P`.  Consequently, a weaker spec can save time and energy while still being apt for its application.

Specifications can be strengthened by weakening their preconditions and strengthening their postconditions.  For example, with **Contravariance**, <span style="color:blue;">supertypes can replace argument types, weakening the precondition</span>.  Similarly, with **Covariance**, <span style="color:blue;">a subtype can replace a method's output type</span>.  Either way, types can be adjusted so specifications do not violate the client's expectations.  Just do not throw any new exceptions.

A stronger specification is easier to use - the client has fewer preconditions to meet, and the client gets more guarantees in postconditions.  However, they are also harder to implement.  On the other hand, a weaker specification is easier to implement because it has a more extensive set of preconditions, relieves implementation from the burden of catching errors, and is easier to guarantee less to the client in the postcondition.  Unfortunately, with all of this simplification, weaker specs are often more challenging to use due to their lack of rigor.

Specification `B` consists of precondition `P_B` and postcondition `Q_B`.  Specification `C` consists of precondition `P_C` and postcondition `Q_C`.  B is stronger than C if `P_B -> P_C`; `P_C` is weaker than `P_B`, so `P_B -> P_C` is a stronger spec.  Similarly, `Q_B` is stronger than `Q_C` if `Q_B -> Q_C`, so `Q_B -> Q_C` is a stronger spec.  `P_C -> P_B \&\& Q_B -> Q_C` is a sufficient condition, but not necessary.

`P_C -> P_B && Q_B == Q_C` is valid.
`Q_B -> Q_C && P_B == P_C` is valid.
`P_C -> P_B && Q_C -> Q_B`, you can't say which is stronger.

Sometimes, we use a method where another is expected with subclasses.  We must obey the **Liskov Principle of Substitutability**: <span style="color:blue;">An object with a stronger specification can be substituted for an object with a weaker one without altering desirable properties like correctness or tasks performed</span>.

## Satisfaction of Specifications

`P` is an implementation, and `Q` is a specification.  `P` satisfies `Q` if every `P` behavior is permitted by `Q`.  The statement "`P` is correct" is meaningless but often used; if `P` does not satisfy `Q`, either or both could be wrong.  When `P` does not satisfy `Q`, it is usually better to change the program rather than the spec.  If the spec is too complex, modify the spec.

## Converting PSoft Specs into Logical Formulas

    requires: R
    modifies: M
    effects: E

    ==

    R => (E and (nothing but M is modified))

throws and returns are absorbed into effects E.

## Review

It is difficult to compare specifications; comparison by hand can be easier, but could be more precise.  It may be difficult to see which conditions are stronger.  Comparison by logical formulas is accurate, though sometimes expressing behaviors with precise, logical formulas is difficult.

Comparing by hand uses the `requires` clause:

    Requires: stronger spec has fewer conditions requires;
        they require less
    Modifies / Effects: stronger spec modifies fewer objects.  
        The stronger spec guarantees more objects stay unmodified!
    Returns and Throws Clauses: the stronger spec guarantees more in
        returns and throws clauses.  They are harder to implement
        but easy to use by the client.
