# Refactoring

Refactoring is necessary when we have complex, ugly code that works.  There is a tendency to leave that awful code alone as long as it works: "if it isn't broken, don't fix it."   The trouble there is that it often will break; it is only a matter of when.  **Refactoring** is <span style="color:blue;">a preemptive, disciplined rewrite of code likely to break in the future</span>, consisting of small-step behavior-preserving transformations, followed by the execution of test cases.  Of course, this depends on having a good suite of tests.  Continuous refactoring combined with testing is an essential software development practice.

Programming is just refactoring a blank screen to make it act according to spec.  There are several possible refactoring methods:

- *Extract*
- *Move*
- *Replace Temp with Query*
- *Replace Type Code with State or Strategy*
- *Replace Conditional with Polymorphism*
- *Form Template*
- *Replace Magic Number with Symbolic Constant*

These have relatively well-defined mechanics and can be automated; Eclipse can automate some of these.

**Technical Debt** <span style="color:blue;">reflects the extra development work that arises when code that is easy to implement in the short run is used instead of applying the best overall solution</span>.  The accumulation of technical debt often stems from the following causes.  Notice how each of these comes from ignorance of the code base or programming itself:

- Business pressures
- Lack of understanding
- Tightly coupled modules
- Not enough or improper testing
- Lack of documentation
- Lack of collaboration

To avoid these, make small, disciplined changes, and test after each change.

## Code Smells

Refactorings attack code smells.  Code Smells can be:

- Any characteristic in the source code of a program that indicates a deeper problem
- Big methods
- A **God Class**, <span style="color:blue;">an oversized class that controls everything</span>
- Similar methods, classes, or subclasses
- Little or no use of subtype polymorphism
- High coupling between objects
- **Feature Envy**, where <span style="color:blue;">a class that uses methods of another class excessively</span>
- **Inappropriate Intimacy**, when <span style="color:blue;">a class that depends on implementation details of another class</span>
- **Refused Bequest** <span style="color:blue;">a class that overrides a base class method such that the contract of the base class is broken</span>
- **Lazy Class/Freeloader**: <span style="color:blue;">a class that does too little</span>
- Excessive use of literals
- **Cyclomatic Complexity** has <span style="color:blue;">too many branches or loops</span>
- **Downcasting** happens when <span style="color:blue;">a type cast breaks the abstraction model</span>
- **Orphan Variable** or **Constant Class** is <span style="color:blue;">a class that typically has a collection of constants that belong elsewhere</span>
- **Data Clump** <span style="color:blue;">occurs when a group of variables is passed around in various parts of the program; it would be more appropriate to formally group the different variables into a single object</span>

Smells are certain structures in the code that indicate a violation of fundamental design principles and negatively impact design quality.  They are not necessarily bugs and are not technically incorrect, though they indicate possible weaknesses in code.  They are also a reliable indicator of technical debt similar to antipatterns.

To fix code smells, make long methods shorter, remove duplicate code, introduce design patterns, and remove the use of hard-coded constants.  The goal is to achieve short, tight, clear code without duplication.

## Extract Method

The method `Customer.statement()` is too big, so it is difficult to understand and maintain.  The solution to this problem is to find a logical, frequently used chunk of code to be extracted out of `statement()` and perform an extract method refactoring.

With the *Extract Method*, create a new method, copy duplicate code in the new method, and scan this (the extracted code) for references to local variables.  If local variables are used only in extracted code, declare them in the new method.  See if the extracted code modifies any other variables; this can be tricky.  Pass unmodified local variables only used by extracted code into the method as variables.  Replace the extracted code with a method call, compile, and test.

## Move Method

There is unnecessary coupling from `Customer` to `Rental` through `getDaysRented()` and `Movie`.  Additionally, the customer does not have the information to compute their rental amount.  To fix this, move `amountFor(Rental)` to the logical information expert class.

With the *Move Method*, examine all features used by the source method defined on the source class.  Consider if they should also be moved.  Next, check the sub- and superclasses for other declarations of the method and declare it in the target class.  Then, appropriately copy the code from source to target.  Finally, reference the correct target object from the source and turn it into a delegating method.  After all this, compile and test to ensure the move worked.

In this particular case, initially, replace the old method with delegation:

    class Customer {
        private double amountFor(Rental aRental) {
            return aRental.getCharge();
        }
    }

Compile and test to see if it works.  Next, find each reference to `amountFor` and replace it with a call to the new method; `thisAmount = amountFor(each);` becomes `thisAmount = each.getCharge();`.  Again, compile, test, and hope the move method worked!

## Replacing Conditional Logic

A switch statement can be challenging to work with, hard to understand, and hard to change.  The first step towards a solution is to move `getCharge` and `getFrequentRenterPoints` from `Rental` to `Movie`.

For example:

    class Rental { // replace with delegation
        double getCharge() {
        ...
        return _movie.getCharge(_daysRented);
        }
    }

Replace abstract class `Price` with concrete subclasses `Regular`, `Children's`, and `NewRelease`.  This way, each Price subclass defines its unique `getPriceCode()` and `getCharge()` method.

## Replace Temp with Query Refactoring

The problem is that the temporary variable `thisAmount` is meaningless and hinders readability.  To fix this, replace `thisAmount` with the query method `each.getCharge()`.  A **Query Method** is more informative than a temporary variable, even though it <span style="color:blue;">does not modify anything</span>.

With the *Replace Temp with Query Method*, look for a temporary variable that is assigned only once.  Declare the temp as final, compile, and extract the right-hand side of the assignment into a query method.  Then, replace all occurrences of the temporary variable with the query.  The query method computing the temporary value should be free of side effects, which improves implementation.

## Replacing Type Code with State or Strategy

Can an algorithm vary independently from the object that uses it?  Let us use movie pricing as an example.  The class `Movie` represents a movie; there are several pricing algorithms and strategies for movies, and we need to add new ones quickly.  However, placing the pricing algorithms and strategies in `Movie` will make the class too big and complex, so developers add a switch statement code smell that temporarily solves the problem.

Here, adding a State pattern solves the problem of making behavior depend on state.  For this, define a context class to present a single interface to the outside world.  In the example, `Chain` is the context.  Then, define a `State` abstract base class.  Represent the different states of the state machine as derived classes of the `State` base class.  Define state-specific behavior in the appropriate classes.  Maintain the current state in the context class by composition.  To change the state of the state machine, change the current state reference.

## Replace Conditional with Polymorphism Refactoring

With this design `Regular` defines its `getCharge`:

    double getCharge(int daysRented) {
        double result = 2;
        if (daysRented > 2)
            result += (daysRented - 2)*1.5;
        return result;
    }

`Children's` and `NewRelease` define their `getCharge(int)`, so `getCharge(int)` in `Price` becomes abstract.  The last two refactorings go together and break the transformation into small steps, the goal being to replace the switch statement with polymorphism.  To implement the *Replace Conditional with Polymorphism* refactoring, refactor the type code according to the State design pattern.  Second, place each case branch into a subclass, and add a virtual call, in this case, `price.getCharge(daysRented)`.

## Template Method Design Pattern and Form Template Method Refactoring

Several methods implement the same algorithm but differ at some steps, such as `TextStatement.value` and `HtmlStatement.value`.  To solve this problem, define the skeleton of the algorithm in a superclass and defer differing steps to subclasses.  Take the example of `TextStatement` and `HtmlStatement`.  First, record a header substring, `customer info` in this case, and iterate over all the rentals, recording each rental substring.  Finally, record the footer substring: `total charge`.  Recorded substrings differ from text to Html.