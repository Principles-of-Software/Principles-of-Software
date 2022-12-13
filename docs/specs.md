\section{Specifications}
A \textbf{specification} is a contract between a method and its caller, consisting of a precondition and a postcondition.  It serves as an abstract description of the behavior of the method.
\newline
\newline
Specifications are beneficial because they precisely document method behavior, which makes it easier for programmers to parse the code.  Specifications promote modularity by organizing code into small chunks called \textbf{modules} with clear-cut boundaries.  Specifications promote abstraction because the \textbf{client}, the person or system using the code, can rely on the specification to predict program functionality instead of code.  The client should not need to know the implementation of the code.  The method must support the specification, but its implementation is otherwise free, so the method and client code can be built simultaneously.  Specifications enable reasoning about correctness, which can then confirm correctness through testing and verification.
\newline
\newline
A specification should be:
\begin{itemize}
    \item Concise: not too many cases
    \item Informative and precise
    \item Specific (strong) enough to make guarantees
    \item General (weak) enough to permit efficient implementation
\end{itemize}
Too weak a spec imposes too many preconditions and gives too few guarantees.  Too strong a spec imposes too few preconditions and gives many guarantees, placing the burden on the implementation (e.g., is the input array sorted?).  Extreme specifications may hinder efficiency.  Like a class, methods should do one thing.  A complex spec is a warning about the design.

\subsection{Why not Just Read Code?}
Why not just read the code to see what is happening in the system?  Code is complicated; large systems contain more detail than anyone trying to parse the abstractions needs, and understanding code can be a sizeable cognitive burden.  Code is also ambiguous - it is often unclear what is essential and incidental in the code base.  Incidental code is dead code that comes about as the result of optimization.  Most importantly, the client needs to know what the code does, not how it does it!  Even in mathematical and scientific software, the user can only know some implementation details.
\newline
\newline
What about comments?  Those are important, but not sufficient, for proper specification.  They are often informal, ambiguous, or misleading, so they cannot stand for formal specs.  Comments sometimes need to be updated in tandem with the code to avoid problematic misunderstandings.  Unfortunately, most code lacks specification; programmers guess what it does by skimming or running it.  Lack of documentation results in bugs and complex code with undefined behavior.  It would be cool to generate code from specifications; this is currently in development and available in some spaces.

\subsection{Complexity in Specs}
A complex specification is a red flag; it is better to simplify design and code rather than try to describe complex behavior!  Over-complicated specifications indicate that something needs to be fixed or the code needs to be simplified.  Software designers constantly battle complexity, so good specifications help reduce the programmer's cognitive burden.

\subsection{Conventions}
There are standard specification conventions that make writing readable code.  There are many to choose from:
\newline
\newline
JavaDoc specifications reside in a method's type signature, and serve as simple text descriptions of the method's behavior.  For example:
\begin{verbatim}
    \* 
     * parameters: text description of what gets passed
     * returns: text description of what gets returned
     * throws: list of possible exceptions
     *\
     public String methodName() { ... }
\end{verbatim}
Principles of Software (PSoft) specification conventions are also included in the code as comments.  The precondition is the "requires" clause, and the postcondition comprises all other clauses.  For example:
\begin{verbatim}
    \* 
     * requires: clause spells out constraints on client code
     * modifies: lists objects that may be modified by the method.  
     *    Any object not listed under this clause is guaranteed untouched.
     * effects: describes the final state of modified objects
     * throws: lists possible exceptions
     * returns: describes the return value of the method
     *\
     public String methodName() { ... }
\end{verbatim}
A few additional comments describing the function help increase readability for the programmer.
\newline
\newline
When using PSoft specifications, all tags must be assigned.  Use "none" when fields need to be left blank.  Method signatures are part of the spec but do not need to be written elsewhere.
\newline
\newline
Sometimes it can be hard to capture all potentially relevant details in the spec.  If required, add more to the specification to make it more specific - just not at the cost of efficiency!
\newline
\newline
The requires clause is critical in PSoft Specifications.  If the client fails to provide preconditions, then the method can do anything it wants -- even throw an exception or return an object of the wrong type.  It is important to double-check the requires clause in method implementation.  Checking preconditions makes implementation more robust, provides feedback to the client, and avoids silent errors.  It is not always necessary to check the preconditions of private methods since those are not client-facing and should be compliant with specifications by default.  However, if the method is public, preconditions should be checked unless such a check is computationally expensive.
\newline
\newline
\textbf{JML (Java Modeling Language)} is another important specification convention;  Javadocs and PSoft specifications are not "machine-checkable" languages, whereas JML (Java is a formal specification language built on Hoare logic.  The end goal of JML is automatic verification.\\\\
Here is an example of a binary search implementation with JML specs, adapted from the OpenJML Tutorial:\\\\
\begin{verbatim}
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
\end{verbatim}

\subsection{Autoboxing and Unboxing}
A \textbf{primitive} data type in Java is an object whose value is "inherent" -- it is not treated like an object and does not have the properties of an object.  However, \texbf{Boxing}, the practice of wrapping primitive values in Java objects, can impart object properties onto primitives.  Boxing is useful when comparing Java objects to primitives.  Java has a feature called \textbf{Autoboxing}, automatically Boxing primitives where needed.  \textbf{Unboxing} automatically converts Java objects (boxed types) to primitive types when required.  Here is an example of Boxing / Autoboxing and Unboxing:\\\\
\begin{verbatim}
    int a = 3;      // regular primitive data type
    Integer b = 3;  // AutoBoxing: 3 is automatically converted to Integer,
                    //  int's Java object "wrapper" class
    int c = b;      // Unboxing: Integer 3 to int 3

\end{verbatim}

\subsection{Specifications and Dynamic Languages}
A type signature is a form of specification in statically typed languages like C/C++ and Java.  In dynamically typed languages, there is no type signature!  So how do we write specs for them?  A method is called for its side effects (effects clause) or its return value (return clause); it is usually bad style to have both effects and return blocks.  There are exceptions, though: the main point of a specification is to be helpful.  Being overly formal does not help, and being too informal does not help either.  

\subsection{Comparing Specifications}
Sometimes, we need to compare specifications; "A is stronger than B" means that, for every implementation B, B satisfies A $\rightarrow$ B satisfies A.  If the implementation satisfies the stronger spec (A), it satisfies the weaker (B); the opposite is not necessarily true.  In general, we want substantial specifications.  A larger world of implementations satisfies the weaker spec B than the stronger spec A.  Consequently, it is easier to implement a weaker spec!
\newline
\newline
Specifications can be strengthened by weakening their preconditions and by strengthening their postconditions.  For example, supertypes can replace argument types, thereby weakening the precondition.  \textbf{Contravariance}.  Similarly, the method's output type can be replaced by a subtype.  \textbf{Covariance}.  Then it does not violate the client's expectations.  Just do not throw any new exceptions.  A stronger specification is easier to use - the client has fewer preconditions to meet, and the client gets more guarantees in postconditions.  Stronger specifications are also harder to implement.  On the other hand, a weaker specification is easier to implement because it has a larger set of preconditions, relieves implementation from the burden of catching errors, and is easier to guarantee less to the client in the postcondition.  With all of this simplification, weaker specs are often harder to use due to their lack of rigor.
\newline
\newline
Specification A consists of precondition $P_A$ and postcondition $Q_A$.  Specification B consists of precondition $P_B$ and postcondition $Q_B$.  A is stronger than B if $P_A \rightarrow P_B$; $P_A$ is weaker than $P_B$, so it is a stronger spec.  $Q_A$ is stronger than $Q_B$ if $Q_A \rightarrow Q_B$; $Q_A$ is stronger than $Q_B$, so it's a stronger spec.  $P_B \rightarrow P_A \&\& Q_A \rightarrow Q_B$ is a sufficient condition, but not necessary.
\newline
\newline
$P_B \rightarrow P_A \&\& Q_A == Q_B$ is valid. \newline
$Q_A \rightarrow Q_B \&\& P_A == P_B$ is valid. \newline
$P_B \rightarrow P_A \&\& Q_B \rightarrow Q_A$, you can't say which is stronger.
\newline
\newline
Sometimes we use a method where another is expected.  Where?  With subclasses!  We must obey the Liskov Principle of Substitutability: An object with a stronger specification can be substituted for an object with a weaker one without altering desirable properties like correctness or tasks performed.
\newline
\newline
Which spec is stronger?  A procedure satisfying a stronger spec can be used anywhere a weaker spec is required.  We ask if the implementation satisfies the specification here.  Specifications can be compared in two ways:
\begin{enumerate}
    \item by hand, examining each clause
    \item with logical formulas representing the spec
\end{enumerate}
Use whichever is most convenient; comparing specs enables reasoning about substitutability.  OR'ed things only sometimes indicate specification strength; consider the precondition beforehand.

\subsection{Satisfaction of Specifications}
P is an implementation, and Q is a specification.  P satisfies Q if every P behavior is permitted by Q, and no P behavior violates Q.  The statement "P is correct" is meaningless but often used.  If P does not satisfy Q, either or both could be wrong, P does something that Q does not specify, or Q shows a result that P does not produce.  When P does not satisfy Q, it is usually better to change the program rather than the spec.  If the spec is too complex, modify the spec.

\subsection{Converting PSoft Specs into Logical Formulas}
\begin{verbatim}
requires: R
modifies: M
effects: E

==

R => (E and (nothing but M is modified))
\end{verbatim}
throws and returns are absorbed into effects E.

\subsection{Review}
It is difficult to compare specifications; comparison by hand can be easier but is sometimes imprecise.  It may be difficult to see which of the two conditions is stronger.  Comparison by logical formulas is accurate.  Sometimes, expressing behaviors with precise, logical formulas is difficult!
\newline
\newline
Comparing by hand will use the requires clause:
\begin{verbatim}
    Requires: stronger spec has fewer conditions requires; 
        they require less
    Modifies / Effects: stronger spec modifies fewer objects.  
        The stronger spec guarantees more objects stay unmodified!
    Returns and Throws Clauses: the stronger spec guarantees more in 
        returns and throws clauses.  They are harder to implement 
        but easy to use by the client.
\end{verbatim}