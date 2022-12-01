# Dafny

**Dafny** is a <span style="color:blue;">language designed to support the static verification of programs</span>.  It uses annotations to reason about code, and generates a proof to show that the given code matches the annotations.

    forall k: int :: 0 <= k < a.Length ==> 0 < a[k]

The example above shows that all elements of array k are greater than 0.  Dafny can also prove that there are no runtime errors, null references, or anything else that Java would ordinarily time out, or throw an exception over.  Dafny is an interesting language.

In Dafny, the **method** is <span style="color:blue;">the smallest available unit for verification</span>.  Dafny methods are similar to the functions of other languages, except in that they are imperative rather than functional. 

Dafny's syntax is not based off of any other language; it is truly unique!  `:=` is the assignment operator, preconditions are denoted by the `requires` keyword, and postconditions employ the `ensures` keyword.  Similarly to Java, Dafny uses assertions to verify program results.

**NOTE: ADD EXAMPLES, ASSERTION SYNTAX, AND PERHAPS A DAFNY CHEAT SHEET**