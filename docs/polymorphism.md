# Parametric Polymorphism: Generics

**Explicit Parametric Polymorphism** is the <span style="color:blue;">technical term for generic usage in object-oriented languages</span>.

Generics clarify code.  Without generics, code has pseudo-generic containers.  **Type Erasure** happens when <span style="color:blue;">all type parameters in generic types are within their bounds</span>.  Thus, the produced bytecode contains only ordinary classes, interfaces, and methods.  Type casts can be inserted if necessary to improve type safety.  Type erasure ensures that no new classes are created for parameterized types.  Consequently, generics incur no runtime overhead.

The point of generic methods is that they can be called with arguments of different types.  Based on the types of arguments passed to the generic method, the compiler handles each method call appropriately.

All generic method declarations have a type parameter section delimited by angle brackets `(<` and `>)` that precede the method's return type.  For example:

    class MySet<T> {
        // rep invariant: non-null,
        // contains no duplicates List<T>
        List<T> theRep;
        T lastLookedUp;
    }
    MySet<String> s;
    MySet<Integer> intSet;
    MySet<int> i; // compiler error, doesn't autobox

A **Type Parameter**, or **Type Variable**, is <span style="color:blue;">an identifier that specifies a generic type name</span>.  Each type parameter section contains one or more type parameters separated by commas.  Type parameters can be used to declare a method's return type and act as placeholders for <span style="color:blue;">argument types passed to the generic method</span>, also known as **Actual Type** arguments.

A generic method's body is declared like that of any other method.  Type parameters can represent only reference types, not primitive types (like int, double, and char).  For example:

    public class GenericMethodDemo {
    // generic method printArray
        public static <E> void printArray( E[] inputArray ) {
            // Display array elements
            for(E element : inputArray) {
                System.out.print(element + " ");
            }
            System.out.println();
    }

    public static void main(String args[]) {
    // Create arrays of Integer, Double, and Character
        Integer[] intArray = { 1, 2, 3, 4, 5 };
        Double[] doubleArray = { 1.1, 2.2, 3.3, 4.4 };
        Character[] charArray = {'H', 'E', 'L', 'L', 'O'};
        
        System.out.println("Array integerArray contains:");
        printArray(intArray); // pass an Integer array
        
        System.out.println("\nArray doubleArray contains:");
        printArray(doubleArray); // pass a Double array

        System.out.println("\nArray characterArray contains:");
        printArray(charArray); // pass a Character array

The compiler ensures type compatibility when using generics, so all code components work well together.  Additionally, Java generics are explicitly polymorphic, so developers cannot assign illegal types to objects, like adding a cat object to an array list full of dog objects.

## How does a method call execute?

For example, `x.foo(5)`;

The compiler determines the **Compile Time Class**, <span style="color:blue;">what class to look in at compile time</span>.   Then, it determines the **Method Family**, or **Method Signature**: <span style="color:blue;">all methods in the class with the correct name, including inherited methods</span>.
Then, the compiler looks for method overrides and return types that may be subtypes of the desired outcome.  The types of the actual arguments must be the same, or be subtypes of the corresponding formal parameter type.  For example, `5` has type `int` above.

The compiler keeps only methods that are accessible.  A private method is not accessible to calls from outside the class.  The compiler keeps track of the method's signature for runtime.

At run time, the compiler determines the runtime type of the receiver - `x` in this case.  Then, it looks at the object in the heap to determine its runtime type.  Next, it locates the method to invoke; starting with the runtime type, look for a method with the correct name and argument types found statically in the method family.  The types of the actual arguments may be the same, or subtypes of the corresponding formal parameter type.  If the method is found in the runtime type, then invoke it.  Otherwise, continue the search in the superclass of the runtime type.  The compiler looks only at method-family members.  Therefore, this procedure will always find a method to invoke, due to the checks done during static type checking.

## Parametric Polymorphism

Overloading is typically referred to as "ad-hoc" polymorphism.  In contrast, in **Parametric Polymorphism**, <span style="color:blue;">methods take type as a parameter</span>.  In python, there are no explicit type parameters; the code is polymorphic because it works with many different types by default.

**Subtype Polymorphism** is <span style="color:blue;">the ability to use a subclass where a superclass is expected</span>.  In **Implicit Parametric Polymorphism**, <span style="color:blue;">there are no explicit type parameters, yet the code works on many different types</span>.  How does implicit parametric polymorphism differ from subtype polymorphism?  Subtype polymorphism is static, and implicit parametric polymorphism is dynamic.  Subtype polymorphism requires declared types for iterable types, whereas implicit polymorphism does not.  Subtype polymorphism guarantees that every subclass of the declared type will be iterable, while implicit polymorphism does not.  For example, Java subtyping guarantees that when `intersect` is called, the runtime iterable types will implement `iteration`.  With subtype polymorphism, the compiler prevents calling `intersect(2,2)`, as an example.

Python, Perl, Scheme, and other dynamic languages use implicit parametric polymorphism with no explicit type parameters.  As a result, the code works with many different types.  Usually, there is a single copy of the code, and all type checking is delayed until runtime.  The code works if the arguments are of a type expected by the code.  If not, the code issues a type error at runtime.

C++, Java, and C\# use **Explicit Parametric Polymorphism**, which <span style="color:blue;">has explicit type parameters for variables and methods</span>.  Explicit Parametric Polymorphism is also known as **Genericity**.  As an example, C++ has templates.  Usually, templates are implemented by creating multiple copies of the generic code, one for each concrete type argument, and then compiling.  Problems arise if the "wrong" type argument is instantiated.  In that case, the C++ compiler returns long, cryptic error messages referring to the generic (templated) code in the Standard Template Library (STL).

Luckily, Java generics work differently from C++ templates -- there is more type-checking on generic code.  Object Oriented languages usually have both subtype and explicit parametric polymorphism, referred to as either generics or templates.

## Using Generics

Defining a Generic Class looks something like below:

    class MySet<T> {
        // rep invariant: non-null,
        // contains no duplicates
        List<T> theRep;
        T lastLookedUp;
    }
    
    MySet<String> s;
    MySet<Integer> intSet;
    MySet<int> i; // compiler error, doesn't autobox

The convention is to use a one-letter name, such as `T`, for type.  The client supplies type arguments to instantiate generic classes.

## Bounded Types

**Bounded Types** are <span style="color:blue;">generic types that extend preexisting classes</span>.  An **Upper Bound Type Argument** can be <span style="color:blue;">any of its bounded subtypes</span>.  The upper bound on a type parameter has three effects:

1. **Restricted Instantiation**: <span style="color:blue;">The upper bound restricts the set of types that can be used for instantiation of the generic type</span>.  `<T extends Number>` means `T` can be instantiated as a `Number` or an `Integer`.
2. **Access to Non-Static Members**: <span style="color:blue;">The upper bound gives access to all upper-bound public non-static methods and fields</span>.  In the class `Box<T extends Number?>`, we can invoke all public non-static methods defined in class `Number`, such as `intValue()`.
3. **Type Erasure**: <span style="color:blue;">The leftmost upper bound is used for type erasure and replaces the type parameter in bytecode</span>.  For example, in class `Box<T extends Number>`, all occurrences of `T` would be replaced by the upper bound `Number`.

Why doesn't Java allow Lower Bounded Type Parameters?  Two reasons:

- **Access to Non-Static Members**: <span style="color:blue;">A lower-type parameter bound does not give access to any particular methods beyond those inherited from class Objects}.  For example, in `Box<T super Number>`, the supertypes of `Number` have nothing in common, except that they are reference types and, therefore, subtypes of `Object`.
- **Type Erasure**: <span style="color:blue;">Replaces all occurrences of the type variable `T` by type `Object` and not by its lower bound}.  The lower bound would have the same effect as a "no bound."

The bottom line is that `<T super Type>` does not get anyone anywhere and leads to confusion.

## Java Wildcards

A **Wildcard** is <span style="color:blue;">an anonymous type variable</span>.  Use `?` when using a type variable exactly once.  `?` appears at the instantiation site of the generic - the use site, as opposed to the declaration site.  Thus, `<?  extends E>`, but not `<E extends ?>`, is valid.  The purpose of the wildcard is to make a library more flexible and easier to use by allowing limited subtyping.  Wildcards limit the kind of operations that instances of a class can perform.

Wildcards appear at the instantiations of generic objects.  There is also `<?  super E>`.  Intuitively, `<?  extends E>` makes sense here: the syntax `<?  extends E>` means "type E or a subtype of E."

`?  extends` introduces covariant subtyping.  For example, `Apple` is a subtype of `Fruit`, `Strawberry` is a subtype of `Fruit`, and `List<Apple>` is a subtype of `List<?  extends Fruit>`:  

    List<Apple> apples = new ArrayList<Apple>();
    List<?  extends Fruit> fruits = apples;
    fruits.add(new Strawberry());

The above code, as is, will not compile.  `fruits.add(new Fruit());` won’t compile either.

The type declaration `List<?  extends Integer>` means that every `List< type>` such that type extends `Integer`, is a subtype of `List<?  extends Integer>`, and so can be used where `List<? extends Integer>` is expected.  Covariant subtyping must be restricted to immutable lists.  

Use `<? extends T>` when getting values from a producer, and use `<? super T>` when adding values into a consumer.  For example, `<T> void copy(List<? super T> DST, List<? extends T> src)`.   Use PECS: Producer Extends Consumer Super.  Use the `?  extends` wildcard to retrieve objects from data structures.  Use the `?  super` wildcard to put objects in a data structure.  Wildcards are not needed when both reading and writing.

All type arguments become Objects or type bounds when compiled.  This is due to backward compatibility with outdated bytecode.  At runtime, all generic instantiations have the same type, so developers cannot use instanceOf to find type arguments at that point.  What happens, then, to `equals()` on elements of generic type?

Early versions of Java did not include generics.  If arrays were not covariant, something like boolean `equalArrays(Object[] a1, Object [] a2);` would only work with Objects.  There would have to be a different method for every type combination.  When generics were introduced, they were purposefully not made covariant to prevent strange subtype phenomena from happening.  When writing a generic class, start by writing a concrete class.  Make sure it is correct using reasoning and testing.  Then, think about writing a second, more concrete class, with different types.  How would the original class need to be modified to accommodate generics?  With practice, it gets easier to start with generics.

## Contravariance

A programming language can have features that may support the following subtyping rules:

- Covariant: A feature that allows a subtype to replace a supertype, like the Java covariant return type
- Contravariant: A feature that allows a supertype to replace a subtype, such as contravariant argument types; these apply to Overloads in Java rather than overrides
- Bivariant: A feature that is both covariant and contravariant.
- Invariant: A feature that does not allow any of the above substitutions.

## Review

Do not use raw types because Eclipse complains.  Do not use private final Collection, and do not use raw iterators.  Raw types lose type safety.  Eliminate warnings as much as possible, and add comments.  Use lists instead of arrays because lists are more type-safe than arrays.

Use generic types rather than fixed types.  This makes code more flexible, and making classes generic without affecting client code is straightforward.  Generic methods are helpful in the same way.

Use bounded wildcards to enhance flexibility.

## Exercises

Evaluate the following exercises given this piece of code:
```
Object o;
Number n;
Integer i;
PositiveInteger P; // extends Integer

List<? extends Integer> lei;
```

### 1

What of the following operations are legal?
```
lei = new ArrayList<Object>();
lei = new ArrayList<Number>();
lei = new ArrayList<Integer>();
lei = new ArrayList<PositiveInteger>();
lei = new ArrayList<NegativeInteger>();
```

### 2

What of the following operations are legal?
```
lei.add(o);
lei.add(n);
lei.add(i);
lei.add(p);
lei.add(null);
o = lei.get(0);
n = lei.get(0);
i = lei.get(0);
p = lei.get(0);
```
