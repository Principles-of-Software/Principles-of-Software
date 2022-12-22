# Identity Equality

The question of equality in Java is a loaded one: what does it *mean* to be equal?  Java uses a reference model for class types.  This means that the **Assignment Operator (`=`)** <span style="color:blue;">copies addresses to objects, not their values</span>.  Primitives are the exception; because they are often so small, the assignment operator copies their data.  In Java, `==` tests for **Reference Equality** - <span style="color:blue;">whether or not two objects have the same address</span>.  `.equals()` tests for **Value Equality**, <span style="color:blue;">which tests if values are the same</span>.  Value equality is used more often; is it clear why?

If two objects are equal now, will they always be equal?  For immutable objects, yes; for mutable objects, no.

Two objects are **Behaviorally Equivalent** <span style="color:blue;">if no sequence of operations can distinguish them</span>.  Behavioral equivalence is also called **Eternal Equality**.  Two objects are **Observationally Equivalent** <span style="color:blue;">if no sequence of observer operations can distinguish them</span>.  Excluding mutators and `==`, with observational equivalence, objects look the same because they have the same attributes.

## Properties of Equality

Equality is:

- **Reflexive**: <span style="color:blue;">`a.equals(a);`</span>
- **Symmetric**: <span style="color:blue;">`a.equals(b) -> b.equals(a)`</span>
- **Transitive**: <span style="color:blue;">`a == b && b == c -> a == c`</span>

In implementation, these all must hold.  Equality is an equivalence relationship that can get complicated in the context of inheritance.  For example, equal objects must have the same `hashCode()`.

Be very careful with elements of sets.  Ideally, elements should be immutable, because immutable objects guarantee behavioral equivalence.  That guarantee is a valuable feature; the Java specification for sets warns about using mutable objects as set elements.

## Hash Function

A **Hash Function** <span style="color:blue;">maps an object to a number</span>.  The number is used as an index in a fixed-size table called a hash table for data storage.  Hashing allows data storage and retrieval applications to access data quickly and nearly constantly per retrieval.  However, developers beware: the worst case for hashing time can be extensive.

The implementation for `.hashCode` is consistent with `.equals()`; equal objects must have the same `hashCode`.  `hashCode()` is used for bucketing in Hash implementations - it places objects in the same place in memory.  `.contains()` takes the element's hash code, then looks for the address where the hash code points.  The value received from **hashCode()** is used to determine the address for, as an example, storing elements of a set or map.

By definition, if two objects are equal, their hash code must also be equal; if `equals()` is overridden, the way two objects are equated must also change.

## Overloading vs. Overriding

Method **Overloading** is when <span style="color:blue;">two or more methods in the same class have the same name but different parameters</span>.  Overloading happens at compile time, meaning all objects will be seen as the Object type until the overload.

Method **Overriding** is when <span style="color:blue;">a derived class requires a different definition for an inherited method</span>.  Arguments stay the same in a method override.  Overriding happens at runtime.  When altering object equality, `.equals()` and `.hashCode()` need to be overridden.

An exciting thing about method overriding is that Java supports covariant return types for overridden methods.  This means an overridden method may have a *more* specific return type than its original form.  As long as the new return type is assignable to the overridden method's return type, covariance is allowed.

The overriding method cannot have a less restrictive access modifier than the overridden method.  In addition, the return type must be the same as, or a subtype of, the return type declared in the superclass' overridden method.  If the superclass method does not declare any exceptions, then the subclass' overridden method cannot declare a checked exception, though it can compare unchecked exceptions.

A final or static method cannot be overridden.

## Implementation

Overriding Object.equals():

    // requires Object arg
    // modifies none
    // effects none
    // throws none
    // returns true if this == arg else false
    // i.e., returns true if arg is the same ref as this
    @Override
    public boolean equals(Object obj) {
        if (obj == null) return false;
        if (obj == this) return true;
        if (!obj.getClass.equals(this.getClass)) return false;
        Class c = (Class) obj;
        // then compare attributes and return true if they work
    }

Overriding Object.hashCode():

    // requires none
    // modifies none
    // effects none
    // throws none
    // returns true if this == arg else false
    // i.e., returns true if arg is the same ref as this
    @Override
    public int hashCode() {
        int h = this.hashCode();
        // use attributes to figure it out
    }

## Abstract Classes

We subclass abstract classes because they cannot be instantiated.  Therefore, there is no equality problem if the superclass cannot be instantiated.

With ADTs, we compare abstract values, not representations.  Usually, many valid representations map to the same abstract value.  If two concrete objects map to the same abstract value, they must be equal.  In that way, a stronger representation invariant shrinks the domain of the Abstract Function and simplifies `.equals()`.