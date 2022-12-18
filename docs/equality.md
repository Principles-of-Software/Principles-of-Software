# Identity Equality
Equality in Java is a loaded question: what does it MEAN to be equal?  Java uses a reference model for class types.  The `=` operator copies references to objects, not the actual "stuff" the object is made from.  For primitives only, it copies data.  In Java, `==` tests for reference equality, if the objects point to the same address in memory.  `.equals()` tests for value equality, which is more often desirable because it tests if values are the same.

If two objects are equal now, will they always be equal?  For immutable objects, yes; for mutable objects, no!

Two objects are behaviorally equivalent if no sequence of operations can distinguish them.  This is "eternal" equality.  Two objects are observationally equivalent if no sequence of observer operations can distinguish them.  Excluding mutators and ==, objects look similar because they have the same attributes.

## Properties of Equality
Equality is:

- Reflexive: `a.equals(a);`
- Symmetric: `a.equals(b) === b.equals(a)`
- Transitive: `a == b && b == c -> a $==$ c`

In implementation, these all must hold.  Equality is an equivalence relationship that can get complicated in the context of inheritance.  Equal objects must have the same `hashCode()`.

Be very careful with elements of sets.  Ideally, elements should be immutable objects because immutable objects guarantee behavioral equivalence.  Thus, the Java spec for sets warns about using mutable objects as set elements.  

Take heed also with equals and hashCode methods on mutable objects.  From the spec of object.equals, it is consistent.  For any non-null reference values x and y, multiple invocations of `x.equals()` consistently return true or consistently return false, provided no information used in equals comparisons on the objects is modified.

From JavaDoc, great care must be taken if mutable objects are used as set elements.  A set's behavior is unspecified if the value of an object changes in a manner that affects equal comparisons while the object is an element in the set.  A particular case of this prohibition is that a set cannot contain itself as an element.  The moral of the story is: do not put mutable objects in a set!

Objects of different types are usually unequal.  When unsure, use the `==` operator to check if method arguments are references to this.Object.  It is also possible to use the `instanceOf()` operator to check if the argument is of the correct type, and cast the argument to the correct type if not.  Make sure all objects obey the laws of equality, and always override hashCode along with equals.

## Hash Function
A hash function maps an object to a number.  The number is used to index into a fixed-size table called a hash table for data storage.  Hash functions allow data storage and retrieval applications to access data in constant time per retrieval.  Beware, though: the worst case for this can be harmful.

The implementation for hashCode is consistent with `.equals()`; equal objects must have the same hashCode.  `hashCode()` is used for bucketing in Hash implementations - it sticks objects in the same place in memory.  `.contains()`, takes an element's hash code and searches for the bucket where the hash code points.  The value received from `hashCode()` is used to determine the bucket for storing elements of the set or map.

By definition, if two objects are equal, their hash code must also be equal.  Therefore, if the `equals()` method is overridden, the way two objects are equated must also change.

## Implementation
Overriding `Object.equals()`:

    // requires Object arg
    // modifies none
    // effects none
    // throws none
    // returns true if this == arg else false
    // i.e., returns true if arg is the same reference as this
    @Override
    public boolean equals(Object obj) {
        if (obj == null) return false;
        if (obj == this) return true;
        if (!obj.getClass.equals(this.getClass)) return false;
        Class c = (Class) obj;
        // then compare attributes and return true if they work
    }

Overriding `Object.hashCode()`:

    // requires none
    // modifies none
    // effects none
    // throws none
    // returns true if this == arg else false
    // i.e., returns true if arg is the same reference as this
    @Override
    public int hashCode() {
        int h = this.hashCode();
        // use attributes to figure it out
    }

## Overloading vs. Overriding
Method overloading is when two or more methods in the same class have the same name but different parameters.  Overloading happens at compile time, which means that all objects will be seen as the Object type.

Method overriding is when a derived class requires a different definition for an inherited method.  The method can also be redefined in the derived class!  The arguments stay the same in a method override.  This happens at runtime.  With `.equals()` and `.hashCode()`, you want to override.

An exciting thing about method overriding is that Java supports covariant return types for overridden methods.  This means an overridden method may have a \textit{more} specific return type than the rest.  As long as the new return type is assigned to the overridden method's return type, covariance here is allowed. 

The overriding method cannot have a more restrictive access modifier (public, protected, private) than the overridden one, but it can be less restrictive.  The argument list must exactly match that of the overridden method.  If it doesn't, you're overloading.  The return type must be the same as, or a subtype of, the return type declared in the overridden method in the superclass.  If the superclass method does not declare any exception, then the subclass overridden method cannot declare a checked exception, though it can compare unchecked exceptions.

A final or static method cannot be overridden.

Overriding equality seems easy, but there are many ways to get it wrong.  The general contract of maintaining equality must be maintained.  Overriding equality is not always necessary or helpful, either.  For instance, such an override is unnecessary when each instance of the affected object is inherently unique, a superclass (whose implementation is adequate for this class) has already overridden equals, or its equals method is never invoked.  Overriding equality is not practical when the affected class is private or package-private or does not provide a logical equality test.

## Abstract Classes
We subclass abstract classes because they cannot be instantiated.  There is no equality problem if the superclass cannot be instantiated!

With ADTs, we compare abstract values, not representations.  Usually, many valid representations map to the same abstract value.  If two concrete objects map to the same abstract value, they must be equal.  A stronger representation invariant shrinks the domain of the Abstract Function and simplifies `.equals()`.