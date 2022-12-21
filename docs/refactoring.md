# Refactoring
Programming is just refactoring a blank screen to make it do what you want it to do.  There are a bunch of different kinds of refactorings you could do: you can extract method, move method, replace temp with query, replace type code with State/Strategy, replace conditional with polymorphism, form Template Method, or replace magic number with symbolic constant.
\\
\\
The premise for refactoring is that we have written complex, possibly ugly, code, but it works!  Can we simplify this code?  There are two opposite tendencies: “Don’t fix it if it’s not broken.”  When it breaks, it can be a real mess.  Refactoring is a disciplined rewrite of code.  Refactoring consists of small-step behavior-preserving transformations, followed by execution of test cases.  This depends on having a good suite of tests.  Continuous refactoring combined with testing is an essential software development practice.
\\
\\
Technical debt reflects the extra development work that arises when code that is easy to implement in the short run is used instead of applying the best overall solution.  Refactoring helps prevent accumulation of technical debt, which can be caused by:
\begin{itemize}
    \item Business pressures
    \item Lack of understanding
    \item Tightly coupled modules
    \item Not enough or improper testing 
    \item Lack of documentation
    \item Lack of collaboration
\end{itemize}
AntiPatterns are a source of technical debt; Code smells and AntiPatterns are bad coding practices leading to technical debt.
\\
\\
Rule: Make small disciplined changes • Test after each change.
\\
\\
A refactoring is a named, documented algorithm that attacks a specific bad coding practice - Extract method, Move method, Replace constructor call with Factory method.  These have relatively well-defined mechanics and can be automated.  Eclipse can automate some of these.

\subsection{Code Smells}
Refactorings attack code smells.  Code Smells can be:
\begin{itemize}
    \item Any characteristic in the source code of a program that possibly indicates a deeper problem.
    \item big methods
    \item An oversized “God” class
    \item Similar methods, classes or subclasses
    \item Little or no use of subtype polymorphism
    \item High coupling between objects
    \item Feature envy: a class that uses methods of another class excessively
    \item Inappropriate intimacy: a class that has dependencies on implementation details of another class.
    \item Refused bequest: a class that overrides a method of a base class in such a way that the contract of the base class is not honored by the derived class
    \item Lazy class / freeloader: a class that does too little
    \item Excessive use of literals
    \item Cyclomatic complexity: too many branches or loops
    \item Downcasting: a type cast which breaks the abstraction model
    \item Orphan variable or constant class: a class that typically has a collection of constants which belong elsewhere
    \item Data clump: Occurs when a group of variables are passed around together in various parts of the program.  This suggests that it would be more appropriate to formally group the different variables together into a single object.
\end{itemize}
Smells are certain structures in the code that indicate a violation of fundamental design principles and negatively impact design quality.  Code smells are not necessarily bugs; they're not necessarily technically incorrect, though they indicate possible weakness in code.  They are also a reliable indicator of possible technical debt, similar to, but not always, antipatterns.  A good example could be duplicated code, contrived complexity, the forced usage of over-complicated design patterns, or shotgun surgery, a single change needs to be applied to multiple classes at the same time.
\\
\\
To fix code smells, you can make long methods shorter, remove duplicate code, introduce design patterns, remove the use of hard-coded constants, etc.  The goal is to achieve code that is short, tight, clear, and without duplication.

\subsection{Method Statement}

\subsection{Extract Method}
Problem: Method Customer.statement() is too big, so it's difficult to understand and maintain.  Solution: find a logical chunk of code to be extracted out of statement(), and perform the Extract Method refactoring.  A key point is safety – refactoring preserves behavior.  Test after every refactoring!
\\
\\
With Extract Method, create a new method and name it appropriately.  Copy the extracted code in the new method, and scan the extracted code for references to local variables.  If local variables are used only in extracted code, declare them in the new method.  See if any local variables are modified by the extracted code; this can be the tricky part.  Are they used in the previous method?  Pass as parameters local variables that are not modified, but are only used by the extracted code.  Compile it, replace the extracted code with a method call, compile, and test!

\subsection{Move Method}
Problem: Unnecessary coupling from Customer to Rental through getDaysRented().  There's unnecessary coupling to Movie too.  Additionally, the customer does not have the “information” to compute the rental amount.  Solution: Move amountFor(Rental) to the class that is the logical “information expert”, the key point being safety.  Test after refactoring!
\\
\\
Examine all features used by the source method that are defined on the source class.  Consider if they should be moved also.  Check the sub- and superclasses for other declarations of the method.  Declare the method in the target class.  Appropriately copy the code from source to target.  Compile the target class.  Reference the correct target object from the source.  Turn the source method into a delegating method.  Compile and test.
\\
\\
In this particular case, initially, you want to replace the body of your old method with delegation:
\begin{verbatim}
class Customer {
    private double amountFor(Rental aRental) { 
        return aRental.getCharge();
    } 
}
\end{verbatim}
Compile and test to see if it works.  Next, find each reference to amountFor and replace with call to the new method: thisAmount = amountFor(each); becomes thisAmount = each.getCharge();.  Compile and test!

\subsection{Replacing Conditional Logic}
Problem: A switch statement can be bad, and hard to understand and hard to change.  The first step towards a solution is to move getCharge and getFrequentRenterPoints from Rental to Movie.  For example:
\begin{verbatim}
    class Rental { // replace with delegation 
        double getCharge() {
        ...
        return _movie.getCharge(_daysRented);
    }
}
\end{verbatim}
Problem: a switch statement can be a bad idea; it is difficult to maintain and error-prone.  Switch statements in are not inherently bad, but be careful using them.  solution: replace switch with subtype polymorphism!  Abstract class Price with concrete subclasses Regular, Children's, NewRelease.  Each Price subclass defines its own getPriceCode() and getCharge().

\subsection{Replace Temp with Query Refactoring}
The problem is that the temporary variable thisAmount is meaningless and hinders readability.  Solution: Replace thisAmount with “query method” each.getCharge().  Claim: A “query method” is more informative.  Aside: “query methods” must modify nothing, the key point being safety.  Test after refactoring!
\\
\\
Here, you want to look for a temporary variable that is assigned to only once.  Why?  Declare the temp as final, compile (makes sure temp is assigned once!), and extract the right-hand side of the assignment into a “query”.  Replace all occurrences of temp with query.  The method computing the value of temp should be a “query” method, i.e., it should be free of side effects!  Why?  Compile and test

\subsection{State Design Pattern and Replacing Type Code with State/Strategy}
Question: Can we have an algorithm vary independently from the object that uses it?  For example, Movie pricing.  The class Movie represents a movie.  There are several pricing algorithms/strategies, and we need to add new algorithms/strategies easily.  Placing the pricing algorithms and strategies in Movie will make Movie too big and too complex, so we add a switch statement code smell.
\\
\\
Question: How can an object alter its behavior when its internal state changes?  A good example is in a TCP connection class representing a network connection.  TCP connection can be in one of three states: Established, Listening or Closed.  When a TCP connection object receives requests (e.g., open, close) from the client, it responds differently depending on its current state.  For example, a pull chain on a ceiling fan.
\\
\\
The State pattern is a solution to the problem of how to make behavior depend on state.  Define a "context" class to present a single interface to the outside world.  In the example, Chain is the context.  Define a State abstract base class.  Represent the different "states" of the state machine as derived classes of the State base class.  Define state-specific behavior in the appropriate State derived classes.  Maintain the current "state" in the "context" class by composition.  To change the state of the state machine, change the current "state" reference.
\\
\\
Add the new concrete Price classes.  In Movie: int \_priceCode becomes Price \_price; then change Movie’s accessors to use \_price.
\begin{verbatim}
int getPriceCode() { return _price.getPriceCode(); }

void setPriceCode(int arg) {
    switch (arg) {
        case REGULAR: _price = new Regular();
    }
}
\end{verbatim}

\subsection{Replace Conditional with Polymorphism Refactoring}
Regular defines its getCharge:
\begin{verbatim}
double getCharge(int daysRented) { 
    double result = 2;
    if (daysRented > 2)
        result += (daysRented - 2)*1.5;
    return result;
}
\end{verbatim}
Children's and NewRelease define their getCharge(int), so getCharge(int) in Price becomes abstract.  This is where the last two refactorings go together, and breaks transformation into small steps.  The goal is to replace switch with polymorphism.  First, replace the type code with State/Strategy  Second, place each case branch into a subclass, add virtual call (e.g., \_price.getCharge(daysRented)).

\subsection{Template Method Design Pattern and Form Template Method Refactoring}
Problem: We have several methods that implement the same algorithm, but differ at some steps, e.g. TextStatement.value and HtmlStatement.value.  Solution: Define the skeleton of the algorithm in a superclass, defer differing steps to subclasses.  For example: TextStatement and HtmlStatement.  You've got the same algorithm for TextStatement.value and HtmlStatement.value.  First, record header substring: customer info, iterate over all the rentals, recording each rental substring.  Finally, record footer substring: total charge.  Recorded substrings differ from Text to Html.
\\
\\
Before refactoring, TextStatement.value and HtmlStatement.value are very similar, which creates the “duplicate code” smell.  Refactor to form a template method, which eliminates the “duplicate code” smell.  In this refactoring, you want to decompose the methods using Extract Method so that all extracted methods are either identical among the different subclasses, or completely different.  Use Pull Up Method (another refactoring!) to pull the identical methods, from one subclass, into the superclass.  For the different methods, use Rename Method.  Make sure that each one has the same signature, and declare them as abstract in the superclass.  Compile and test after the signature changes.  Remove the other identical methods, compile and test after each removal.
\newpage