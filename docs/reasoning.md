# Reasoning
Reasoning about code allows us to understand the exact behavior of our code before we run it, deeming it necessary for efficient development.  Reasoning uses specifications to verify correctness, find errors, and understand those errors in code.

There are two types of reasoning: 

1. \textbf{Forward Reasoning:} given a precondition, does the postcondition hold?  This approach is suitable for discovering previously unknown edge cases in a program's output.
2. \textbf{Backward Reasoning:} given a postcondition, what is the proper precondition?  This approach is useful for finding out which inputs are causing errors.

Backward reasoning is usually preferable to forward reasoning.  Given a specific goal, backward reasoning shows what must be true before execution to achieve desired results.  Given an error, it gives input that exposes the error.

## Forward Reasoning

**NOTE: ADD FORWARD REASONING EXAMPLE**

## Backward Reasoning
Unlike forward reasoning, there is some specific syntax for backward reasoning.  To denote our thought processes, we write wp("expression," {Q}) = {Q}, where wp stands for weakest precondition.  We want the weakest precondition, so when we carry our work up to the top, the weakest precondition for the whole function remains.

**NOTE: ADD BACKWARD REASONING EXAMPLE**

## Reasoning about Loops
Computing the weakest possible precondition for loops is a complex problem to solve.  However, a tool is available to developers for such a task: the loop invariant.  We can find loop invariants using computational induction, a systematic formula for proving that recursive functions behave as expected.

### Loop Invariant
A \textbf{loop invariant} is a logical assertion representing a loop's abstract specification.  For a loop invariant to be helpful, it must hold true before the loop's first iteration and after each subsequent iteration.  It does not have to be true inside the loop.  Loop invariants are cool because if we have a loop invariant that implies the postcondition at the exit, we can be confident that the loop computes the correct result.

We must prove two things to determine if the loop behaves as expected.  The first is \textbf{Partial Correctness}: define a decrementing function D that incorporates the necessary variables of the loop and the decrementing variable, and try to prove that D holds after every loop iteration by induction.  Partial correctness establishes and proves the loop invariant using computational induction.  Like regular induction, this takes a little while to learn, though the next step in our proof will make this process more intuitive.

The second step to proving loop behavior is \textbf{Loop Termination}, where the minimum value of D implies the loop's exit condition.  The loop invariant and exit condition must imply the postcondition - "If the loop terminates, then the postcondition holds."  \bftext{Total Correctness} is the successful combination of partial correctness and loop termination and adequately proves that your loop behaves as expected.

Reasoning about loops can be tricky because a loop represents an unknown number of paths.  Recursion presents the same problem - it might not be possible to enumerate all paths.  The key to both is to choose a loop invariant, then prove by induction that the loop's specifications hold for each iteration.
\newline
\newline
A \textbf{loop invariant} is a condition that is true immediately before and immediately after each iteration of a loop.  The execution of the loop body should preserve it.  However, it does not say anything about the state of specifications part of the way through; this is because variables often change during loop execution in ways that temporarily violate the spec.  We can reason about loop invariants using induction.
\newline
\newline
In \textbf{forward reasoning with a loop}, a loop invariant must be true before entering the loop, after each iteration within, and after the loop exits.  It must also be relevant.  A good loop invariant should involve the changing loop variable and the postcondition.  \textbf{The decrementing function and the loop invariant must imply the postcondition}

\includegraphics[width=\textwidth]{freasoning_loop.png}

### Mathematical Induction
Reasoning about ADTs uses induction.  When reasoning about representation invariants, the inductive step must consider all possible changes to the representation, including representation exposure.  If the proof does not account for representation exposure, this is invalid.

The steps to successful mathematical induction are as follows:

1. **Initial Step**: <span style="color:blue;">Prove the proposition is true for n = 0</span>.
2. **Inductive Step**: <span style="color:blue;">Prove that if the proposition is true for n = k, then it must also be true for n = k + 1</span>.  This step is complex, and breaking it up into several stages helps.
    - **Inductive Hypothesis**: <span style="color:blue;">Assume what the proposition asserts for the case n = k</span>.
    - **Step 2**: <span style="color:blue;">Write down what the proposition asserts for the case n = k + 1.  This is what the induction proves</span>.
    - **Step 3**: <span style="color:blue;">Prove the statement in Stage 2 using the assumption in Stage 1</span>.  The technique varies from problem to problem, depending on the mathematical content.  Use ingenuity, common sense, and knowledge of mathematics here.  Additionally, RPI's Foundations of Computer Science class and associated text have suitable methods for solving proofs with induction.

In this class, we use computational induction, an iteration of induction which is futher explored in Loops.

### Computational Induction
Computational induction is a recursive algorithm for proving loop functionality.  To illustrate this concept, see the below example:

    int x = 10;
    int z = 0;

    \\ precondition: x >= 0 && i == x
    \\ postcondition: z = x
    
    for (int i = x; i > 0; i--) {
        z += 1;
    }

1. \textbf{Base Case}: In this loop, the decrementing variable is \verb+i+, and the variables of interest are \verb+x+ and \verb+z+.  Thus, our loop invariant (LI) must incorporate these variables.  The precondition values simplify to $i == x$; coupled with $z == 0$, we get $i + z = x$ as our LI.  We know it holds before the loop code executes by substituting the variables in for their values: $(10) + (0) = (10)$.
2. \textbf{Inductive Step}: Assuming $i + z == x$ holds after iteration $k$, we show that $i + z == x$ holds after iteration $k + 1$.  Here, we assume that $(i - k) + (z + k) = x$.  If that is indeed true, then $(i - k - 1) + (z + k + 1) = x$ must also be true, because: $$(i - k - 1) + (z + k + 1) = (i - k) + (z + k) - 1 + 1 = (i - k) + (z + k) = x$$
3. If the loop terminates, we know $i <= 0$.  We have $z == x$, which is the postcondition.
4. We know if the loop terminates because the precondition $x >= 0$ guarantees that $i >= 0$ before the loop.  At every iteration, $i$ decreases by $1$.  Thus, it eventually reaches $0$.

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