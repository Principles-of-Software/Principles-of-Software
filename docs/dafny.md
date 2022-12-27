# Dafny

**Dafny** is a <span style="color:blue;">language designed to support the static verification of programs</span>.  It uses annotations to reason about code and generates a proof to show that the given code matches the annotations.

    forall k: int :: 0 <= k < a.Length ==> 0 < a[k]

The example above shows that all elements of array k are greater than 0.  Dafny can also prove that there are no runtime errors, null references, or anything else that Java would ordinarily time out or throw an exception over.  Dafny is an interesting language.

In Dafny, the **method** is <span style="color:blue;">the smallest available unit for verification</span>.  Dafny methods are similar to the functions of other languages, except that they are imperative rather than functional.

Dafny's syntax is not based on any other language; it is truly unique!  `:=` is the assignment operator, preconditions are denoted by the `requires` keyword, and postconditions employ the `ensures` keyword.  Similarly to Java, Dafny uses assertions to verify program results.

Let us start with a simple HelloWorld program:

    method Main() {
      print "Hello, World!\n";
      assert 10 < 2;   // this assertion fails
    }

So far, Dafny looks like Java: methods enclosed in curly braces, clear function names spelled out in lower case, and semicolons at the end of lines.  Notice, however, the lack of parenthesis and the immediate use of an assertion.  Dafny relies heavily on assertions to prove the program's correctness.

Here is a more complex problem, a calculation of the nth number in the Fibonacci series:

    function Fibonacci(n: int): int
      decreases n
    {
      if n < 2 then n else Fibonacci(n-2) + Fibonacci(n-1)
    }

The `if, then, else` statement, as well as the recursion in `Fibonacci(n-2)` and `Fibonacci(n-1)`, are familiar concepts.  The `decreases` statement here is new; it is the representation invariant.  In Dafny, representation invariants are compiled and run with the program so they can be verified together.   A proper understanding of reasoning is therefore knowledge of Dafny and its syntax.

Here is another example of specifications at work within a Dafny program:

    method  Abs(x: int) returns (x’: int)
      ensures x’ >= 0
      ensures (x < 0 && x’ == -1 * x) || (x’ == x)
    {
      x’ := x;
      if (x’ < 0) { x’ := x’ *  -1; }
    }

    method Main()
    {
       var v := Abs(3);
       assert v == 3;
       assert 0 < v;
       assert 0 <= v;
       v := Abs(0);
       assert v == 0;
    }

The `Abs` method calculates the absolute value of a given integer `x` and returns it in the variable `x'`.  The `Main()` method, featuring several assertions and variable assignments, tests the absolute value function.  The only thing we have not seen in Dafny here is the `ensures` keyword, which defines the method's postcondition.  If the method runs and those conditions are not met, Dafny will throw an error.

Finally, it might be useful to verify a binary search method implemented in Java:

    predicate sorted(a: array?<int>)
       requires a != null
       reads a
    {
       forall j, k :: 0 <= j < k < a.Length ==> a[j] <= a[k]
    }
    method BinarySearch(a: array?<int>, value: int) returns (index: int)
       requires a != null && 0 <= a.Length && sorted(a)
       ensures 0 <= index ==> index < a.Length && a[index] == value
       ensures index < 0 ==> forall k :: 0 <= k < a.Length ==> a[k] != value
    {
       var low, high := 0, a.Length;
       while low < high
        invariant 0 <= low <= high <= a.Length
        invariant forall i ::
            0 <= i < a.Length && !(low <= i < high) ==> a[i] != value
       {
        var mid := (low + high) / 2;
        if a[mid] < value {
            low := mid + 1;
        }
        else if value < a[mid] {
            high := mid;
        }
        else {
            return mid;
        }
       }
       return -1;
    }

What syntax is reminiscent of Java?  What is new?  What logical assumptions and assertions does Dafny make here?