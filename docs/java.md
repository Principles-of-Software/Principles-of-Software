# Java

Java is a successor to several languages, including Lisp, Simula67, CLU, and SmallTalk.  It is superficially similar to C and C++ because its syntax is borrowed from them.  However, at a deeper level, it is quite different from C and C++.

Like C and C++, Java is an object-oriented language, where most of the data manipulated by programs is contained in objects.  Objects contain both state and operations, where the state is comprised of fields and variables, and operations are called methods or functions.

## Variables

What is a variable?  A variable is a kind of state - a place to store objects.  For example:

    int P = Q;

P and Q are integers in this line of Java code.  P is an **r-value**, a variable on the right of the assignment operator that stores data.  Because Q is on the left, Q is an **l-value**, which refers to <span style="color:blue;">the location of Q's data</span>.  Thus, we have P and Q, but "buckets" containing data.  Because we are setting P equal to Q, we are "pouring out" the data stored in P's location, and "filling P" with the data stored in Q's location.  There are now two buckets filled with Q's data.

For another example:

    int b = 2;
    int c = b;
    int d = b;

We know what value `b` is outright.  Then, we copy the data stored at location `b` to location `c`.  Finally, we combine data at `b` and `c` and copy it to `d`.

## Models for Variables

A variable is a reference to an object with a value; every variable is an l-value that can be dereferenced to get an r-value.  Different languages have different models for how they store variables.  For example, C++ uses the value model, where references are aliases, and the "buckets" it uses as references are called pointers.  Java and Python use a mixed model, where primitive types use the value model, and class types use the reference model.  Objects are created with the keyword new.

To clarify the difference, here is how to create a string with a value model language:

    int x = 7; // value model
    char c = "Ahhh";

Furthermore, here is how to create a string with a reference model language:

    String s = new String("cat");
    // s contains a reference to an object containing "cat."

In Java, local variables live on the runtime stack.  On the stack, memory is allocated for variables when their method is called, and deallocated when their method returns.  Primitive types of variables (int, double, char, boolean) are stored on the stack.  All other types of variables, including strings and arrays, contain references to objects that reside on the heap.

## Differences between Java and C++

In Java, there is no reference arithmetic needed to iterate through pointers.  A reference might be implemented by storing an address, but it is impossible to exchange integers and pointer values as in C++.  References are strongly typed in Java, whereas C/C++ pointers can point to any object using casting.  Java does not have explicit pointers, but C/C++ does.

In Java, there are two ways to denote equality: `==` and `.equals`.  **==** is used when <span style="color:blue;">comparing primitive objects stored on the stack</span>, and **.equals** when <span style="color:blue;">comparing objects stored on the heap</span>.  Java is an interpreted language, while C/C++ is a compiled language.  Polymorphism is also handled differently here.

In Java, access control modifiers are different; protected is slightly different in C++.  Java also has built-in garbage collection, whereas C++ does not.  In C++, the programmer is responsible for memory management, whereas in Java, programmers do not need to explicitly free memory.  Below is a table with access modifiers and what they do to program visibility:

    | ----------------| Class | Package | Subclass | World |
    | public          |   Y   |    Y    |     Y    |   Y   |
    | protected       |   Y   |    Y    |     Y    |   N   |
    | no modifier     |   Y   |    Y    |     N    |   N   |
    | private         |   Y   |    N    |     N    |   N   |

A protected object is visible to its parent class, the other classes in its package, and subclasses, but not to the outside world.

Private objects are only visible to the class containing the object.

There are many differences between C++ and Java.  For example, C++ allows multiple inheritance and can give rise to the dreaded triangle inheritance dilemma.  Java does not allow this; it only allows for single-class inheritance, though it does allow for multiple interface inheritance.  For example:

    class B extends A implements J, K, L, ...
    public interface ShapeInterface {
        public void draw();
        public double getArea();
    }
    public class Square implements ShapeInterface {
    ...
    }


In Java, an Interface cannot contain any implementation, only method signatures.  This restriction creates a contract between the interface class and subclasses; interfaces cannot be instantiated independently.  Abstract classes can contain implementations for some methods, though they cannot be directly instantiated.  Abstract classes can be subclasses, though.

    public abstract class AbstractMapEntry<K,V> implements MapEntry<K,V> {
    public abstract K getKey(); // must be implemented by subclass
    public abstract V getValue();

    public boolean equals( Object o ) {
        if ( o == this ) // etc.
        }
    ...
    }

In C++, we use the terms base class and derived class to refer to the equivalent Java superclass and subclass.  In C++, we have member variables and member functions, whereas in Java, we have instance or static fields and methods.  Java also has interfaces, which are just collections of method signatures.

## Types and Type Checking

Types create abstraction and safety within a program.  By disallowing operations on unsupported objects, types and type checking prevent the program from going wrong.

Java is a strongly typed language.  It checks the code to ensure that each assignment and method call is typed correctly.  Every variable declaration gives the variable a type; the header of every method defines its type signature.  Legal programs are guaranteed to be type-safe - they will not run otherwise.  Java provides automatic storage management for all objects and checks all array accesses to ensure they are within the proper bounds.  Objects out of bounds throw ArrayIndexOutOfBounds Exception.

Type safety is where no operation is ever applied on an object of the wrong type; C/C++ is type unsafe.  Java and C/C++ are statically typed, which means they require type annotations.  Most type-checking occurs before runtime.  In Java and C++, expressions have static (compile-time) types, and objects have dynamic (runtime) types.  The alternative to strong typing is dynamic typing, where substantial type-checking occurs during runtime.  Java ensures type safety with both compile-time and runtime type checking.  As a result, the compiler rejects plenty of programs.

Some checks are left for runtime.  For example, where `B b = (B) x`, Java will not check b's type during compile-time because it looks correct.  Instead, Java will save that check for runtime, when it checks that `x` refers to a `B` object.  If not, it throws an exception.

## Equality

There are two kinds of equality - reference equality and value equality.  We went over this earlier.

## Inheritance from Object Class

In Java, `Java.lang.Object` is the top-level class.  Every other class is a subclass of object; every class implements its methods.  `Object.equals()` uses `==` when checking for equality.  `Object.equals()` tests for identity; does not test for equality of contents.

Java deals in subtyping, and PSoft deals in subtype polymorphism.  Subtype polymorphism ensures that a subclass superclass can be used where a superclass is expected.  Subtype polymorphism relies on the open-closed principle to work.

In C++, static binding is the default; dynamic binding is specified with the keyword virtual.  In Java, dynamic binding is the default; private, final, or static methods in a class use static binding.  Static binding happens at compile time; at binding, the compiler knows the class of all objects.  On the other hand, dynamic binding happens at runtime, where methods can be overridden, and the compiler does not know what type the object will be at runtime.

**Overloading** is <span style="color:blue;">the ability to use the same method name with different arguments</span>.  In contrast, **Overriding** is where <span style="color:blue;">a subclass uses the same method signature as a superclass in inheritance</span>.  Overloaded methods are bound using static binding during compile time, and overridden methods are bound using dynamic binding at runtime.  

Subtype Polymorphism is useful because it enables extensibility and reuse.  It also enables (and depends on) the open/closed principle.

Dispatching - what is dispatching?  It is where the compiler knows the apparent type of an object, while at runtime, the object has an actual type.  **Dispatching** <span style="color:blue;">calls code in its actual type at runtime</span>.

## Exceptions

Java throws lots of exceptions.  Here are some examples:

`ArrayIndexOutOfBounds at x[i]=0;` is thrown if i is out of bounds for array x

`ClassCastException at B q = (B) x;` is thrown if the runtime type of x is not a B

`NullPointerException at x.f = 0;` if x is null

Exceptions are helpful - they tell us what went wrong and prevent applications from messing themselves up too much.

## Compilation vs Interpretation

In compilation, a high-level program is translated directly into executable machine code.  C++ uses compilation.

![](images\comp.png)

In pure interpretation, a program is translated and executed one statement at a time using an interpreter.

![](images\interpretation.png)

In hybrid interpretation, which Java uses, a program is compiled into intermediate code, and then intermediate code is interpreted.  Java uses both a compiler and an interpreter to run.

![](images\hybrid.png)

Compilation begets faster execution, though it depends on many different factors.  Interpretation provides greater flexibility through dynamic (type) checks; other dynamic features are much more manageable.  Interpreters are also easier to write than compilers.

## Specification Fields in Java

Describe abstract values.  Abstract values are used in the overview (before `@requires`) in your JavaDoc spec of the abstract data type.  The abstract value is an object with fields.

Often, abstract values are not clean mathematical objects.  The concepts of customer, meeting, and item can all be defined loosely and in spec fields.  In general, spec fields are different from representation fields.

## ADTs in Java

Java Classes:

    - Make operations of the abstract data type public methods
    - Make other operations private
    - Clients can only access the ADT operations

Java Interfaces:

    - Clients only see the abstract data type operations, nothing else
    - There can be multiple implementations with no code in common
    - Cannot include creators or fields

Both classes and interfaces rely upon careful specifications.  However, we prefer interface types over specific classes because they force programmers to decouple implementation from abstract data types.

When defensive programming, programmers must check what they are doing.  Specifically, they must check:

    - Precondition
    - Postcondition
    - Representation Invariant
    - Loop Invariants

Defensive programming should be done statically - before execution.  It works in more straightforward cases but can be difficult in general.  Thus, adequate defensive programming motivates us to simplify and decompose our code!

It is also essential to check representation invariants dynamically via assertions.  These are tests checked at runtime.  Write these similarly to code - and they are not to be confused with JUnit methods such as `assertEquals`.

By default, Java runs with assertions disabled.  Java-ea runs with assertions enabled.  Always enable assertions during development, and disable them in production.  Do not use assertions when the behavior of a code block is apparent, or when there could be unintended consequences for doing so.

Assertions can fail from:

    - Precondition violations
    - Errors in code from representation exposures, exceptions, bugs, etc.
    - Unpredictable external problems such as running out of memory, missing files, memory corruption, connection failure, etc.

Good Java developers want to fail friendly and early to prevent harm in their programs.  Their first goal is to add clarity to and prevent harm in the code base.

It is better to use preconditions instead of exceptions when verifying code.  Java maintains a call stack of methods that are currently executing.  When an exception is thrown, the control transfers to the nearest method with a matching catch block.  If no catch block is found, use the top-level handler.  Exceptions allow non-local error handling.

Return codes can cause problems when ignored.  Exceptions are also typed, as are special values, but a method can throw multiple exceptions.  Methods can only return one type.  `Java.lang.Math` returns NaN for many standard math functions.  NaNs are sticky, like `SomeType o = add(a, div(b, c));` it may be challenging to know where a NaN arose.

Generally, throw an exception when something should not happen.  Return a special value when something unusual but expected can happen, and the client code can react to it.  There are two distinct uses of exceptions:

    - External Failures (device failures) are unexpected and usually unrecoverable.  If a condition is unchecked, the exception propagates up the call stack.
    - Special results are expected and can always be checked and handled locally.  Therefore, take special action and continue computing.

Checked exceptions and unchecked exceptions should both be caught.  Calls throwing checked exceptions are enclosed in a `try{}` block in a level above in the caller of the method.  In that case, the current method must declare that it throws the exceptions so that the callers can make appropriate arrangements to handle the exception.

Checked exceptions are checked at compile time; the compiler checks that the exception is being handled there.  Unchecked exceptions are not checked at compile time.  Checked exceptions are tested at compile time; the method must either handle the exception, or specify that the exception will be thrown using the throws keyword.  In Java Exceptions, checked and unchecked exceptions are helpful.  Exceptions under error and RuntimeException classes are unchecked exceptions, and every other throwable is a checked exception.  In C++, all exceptions are throwable.

Checked exceptions are for edge cases, and unchecked exceptions are for failures.  In the library, there is no need to declare exceptions; in the client, there is no need to catch exceptions.  Do not ignore exceptions!  Empty exception brackets indicate lazy programming and bad design.

## Review

In practice, always write a representation invariant.  Write an abstraction when needed.  A description is essential; make it precise, concise, and informal.

Use an exception when checking if the condition is feasible.  It is used in a broad or unpredictable context.  Using a precondition when checking would be prohibitive; for example, requiring that a list is sorted before operating on it would unnecessarily bloat the method.  Use in a narrow context when calls can be checked.

Avoid preconditions when the caller may violate a precondition.  The program can fail in an uninformative or dangerous way.  We want the program to fail as early as possible.  Use checked exceptions most of the time.  Handle exceptions sooner rather than later.

Unchecked exceptions are better if the client writes code that avoids the exception.  The exception reflects completely unanticipated failures.  Otherwise, use a checked exception.  It must be caught and handled, which prevents program defects.  They used checked exceptions, which should be locally caught and handled.  Checked exceptions that propagate over long distances indicate lousy design.  If they are not caught, those exceptions generate program terminations.
