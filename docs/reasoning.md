# Reasoning
Reasoning about code allows us to understand the exact behavior of our code before we run it, deeming it necessary for efficient development.  Reasoning uses specifications to verify correctness, find errors, and understand those errors in code.

There are two types of reasoning: 

1. \textbf{Forward Reasoning:} given a precondition, does the postcondition hold?  This approach is suitable for discovering previously unknown edge cases in a program's output.
2. \textbf{Backward Reasoning:} given a postcondition, what is the proper precondition?  This approach is useful for finding out which inputs are causing errors.

Backward reasoning is usually preferable to forward reasoning.  Given a specific goal, backward reasoning shows what must be true before execution to achieve desired results.  Given an error, it gives input that exposes the error.

## Specifications
What does it mean for code to be correct?  Code \textbf{correctness} refers to its ability to conform to its specification.  A \textbf{specification} is a contract between a function and its callers, usually consisting of a precondition and a postcondition.  Methods usually have their specifications displayed in the comments preceding their signature.  The \textbf{precondition} must be true before the code executes, and the code must hold after execution if the precondition did indeed pass.  The \textbf{postcondition} describes the expected range of outputs that a program will return.
\newline
\newline
Since specifications are a contract between functions and their callers, they have obligations to one another:
\begin{itemize}
    \item The caller must pass arguments that obey the precondition.  If not, the function can break!
    \item The function guarantees the postcondition if the precondition holds.
\end{itemize}
Type signature is a specification form - the caller provides a particular type of object to the function, and the function then supplies the caller with a result of the correct type.  The type checker (among other things) verifies that the parties meet the type contract.  If the language is type-safe (ex., Java), we can trust the type checker.  Java catches argument-type violations at compile time.  However, if the language is type unsafe, it would be possible for a caller to pass an argument of the wrong type!

## Loop Invariant
Reasoning about loops can be tricky because a loop represents an unknown number of paths.  Recursion presents the same problem - it might not be possible to enumerate all paths.  The key to both is to choose a loop invariant, then prove by induction that the loop's specifications hold for each iteration.
\newline
\newline
A \textbf{loop invariant} is a condition that is true immediately before and immediately after each iteration of a loop.  The execution of the loop body should preserve it.  However, it does not say anything about the state of specifications part of the way through; this is because variables often change during loop execution in ways that temporarily violate the spec.  We can reason about loop invariants using induction.
\newline
\newline
In \textbf{forward reasoning with a loop}, a loop invariant must be true before entering the loop, after each iteration within, and after the loop exits.  It must also be relevant.  A good loop invariant should involve the changing loop variable and the postcondition.  \textbf{The decrementing function and the loop invariant must imply the postcondition}

\includegraphics[width=\textwidth]{freasoning_loop.png}

## Hoare Logic
Hoare Logic is a formal framework for reasoning about code; its proper use can mechanize the process of reasoning about code.  Sir Anthony Hoare created (or discovered, depending on your beliefs) Hoare Logic, the quicksort algorithm, and a bunch of programming languages.  He won the Turing award in 1980.

A \textbf{Hoare Triple} is written as \{P\}code\{Q\}, where P and Q are logical statements about program values, and "code" is a given program's code.  If a program satisfies condition P before execution terminates, it will terminate in a state satisfying condition Q.  In other words, \textbf{If P \&\& code, then Q}.

Why care about Hoare triples?  Because they can help us guarantee postconditions using preconditions and code.

In a Hoare triple, we want the \textbf{weakest possible precondition}: the most lenient condition possible, which still ensures that the output will be correct.  Similarly, we want the \textbf{strongest possible postcondition}: the most restrictive postcondition possible, which still allows the precondition to hold.

We can always substitute a stronger precondition, and the original Hoare triple can still be true.  We can always substitute a weaker postcondition, and the Hoare triple can still be true.  In an if-then-else block, we take the if and else statements and stick them in the Hoare triple like this, "or-ed" together:

    // precondition: ??
    if (b) S1 
    else S2 
    // postcondition: Q
    
    wp(“if (b)S1 else S2”, Q) = { ( b && wp(“S1”,Q) ) || ( not(b) && wp(“S2”,Q) ) }

## Backward Reasoning
Unlike forward reasoning, there is some specific syntax for backward reasoning.  To denote our thought processes, we write wp("expression," {Q}) = {Q}, where wp stands for weakest precondition.  We want the weakest precondition, so when we carry our work up to the top, the weakest precondition for the whole function remains.

## Weaker and Stronger Conditions
\includegraphics[width=\textwidth]{stronger.png}
Knowing how to weigh conditions is important to ensure our preconditions are weak and postconditions are strong.  \textbf{P is stronger than Q if P $\rightarrow$ (implies) Q}.  If P is stronger than Q, P is more likely to be false than Q.  It also means that P's set of true values is a subset of Q's.  \textbf{The strongest possible statement is always false}, and \textbf{the weakest possible statement is always true}.  Hoare triples are cool because, for each Q, exactly one assertion wp(code, Q) holds.