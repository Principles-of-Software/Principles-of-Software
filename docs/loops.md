# Loops
Computing the weakest possible precondition for loops is a complex problem to solve.  However, a tool is available to developers for such a task: the loop invariant.  We can find loop invariants using computational induction, a systematic formula for proving that recursive functions behave as expected.

## Induction
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

## Loop Invariant
A \textbf{loop invariant} is a logical assertion representing a loop's abstract specification.  For a loop invariant to be helpful, it must hold true before the loop's first iteration and after each subsequent iteration.  It does not have to be true inside the loop.  Loop invariants are cool because if we have a loop invariant that implies the postcondition at the exit, we can be confident that the loop computes the correct result.

We must prove two things to determine if the loop behaves as expected.  The first is \textbf{Partial Correctness}: define a decrementing function D that incorporates the necessary variables of the loop and the decrementing variable, and try to prove that D holds after every loop iteration by induction.  Partial correctness establishes and proves the loop invariant using computational induction.  Like regular induction, this takes a little while to learn, though the next step in our proof will make this process more intuitive.

The second step to proving loop behavior is \textbf{Loop Termination}, where the minimum value of D implies the loop's exit condition.  The loop invariant and exit condition must imply the postcondition - "If the loop terminates, then the postcondition holds."  \bftext{Total Correctness} is the successful combination of partial correctness and loop termination and adequately proves that your loop behaves as expected.