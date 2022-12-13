\section{Design Patterns}
A design pattern is a generic solution to a recurring design problem.   Design patterns seek to solve common programming problems with a few common solutions:
\begin{itemize}
    \item \textbf{Encapsulation}: hiding implementation components in a layer below what the client can access.
    \item \textbf{Subclassing} - Making a "wrapper" that implements something else to reduce repetition.
    \item \textbf{Iteration} - The object does traversals to access all members of a collection.
    \item \textbf{Exceptions} - Errors in one part of the code should be handled elsewhere, so the language is structured for throwing and catching exceptions.
    \item \textbf{Generics} - Generic types allow users to use objects of any type in data structures.
\end{itemize}
SOLID Design Principles:
\begin{itemize}
    \item \textbf{Single Responsibility Principle} - A class should have only one responsibility.
    \item \textbf{Open-Closed Principle} - A class's behavior can be extended without modifying it.
    \item \textbf{Liscov Substitution Principle} - The derived classes must be substitutable for their base classes.
    \item \textbf{Interface Segregation Principle} - Many client-specific interfaces are better than one general-purpose interface.
    \item \textbf{Dependency Inversion Principle} - Implementation should depend on abstractions, not concrete implementations.
\end{itemize}
Design patterns do not solve all design problems, but they can increase code clarity and improve modularity.
\\
\\
There are three different kinds of design patterns: creational patterns, structural patterns, and behavioral patterns.

\subsection{Creational Patterns}


\subsubsection{Abstract Factory}
Provides an interface for creating families of related or dependent objects without specifying their concrete classes.

\subsubsection{Builder}
Separate the construction of a complex object from its representation so that the same construction process can create different representations.

\subsubsection{Factory Method}
Define an interface for creating an object, but let subclasses decide which class to instantiate.  For example, the factory method lets a class defer instantiation to subclasses.

\subsubsection{Prototype}
Specify the kinds of objects to create using a prototypical instance, and create new objects by copying this prototype.

\subsubsection{Singleton}
Ensure a class only has one instance and provide a global point of access to it.

\subsection{Structural Patterns}
\subsubsection{Adapter}
Convert the interface of a class into another interface clients expect.  For example, an adapter lets classes work together that otherwise could not because of incompatible interfaces.

\subsubsection{Bridge}
Decouple an abstraction from its implementation so that the two can vary independently.

\subsubsection{Composite}
Compose objects into tree structures to represent part-whole hierarchies.  Composite lets clients treat individual objects and compositions of objects uniformly.

\subsubsection{Decorator}
Attach additional responsibilities to an object dynamically.  Decorators provide a flexible alternative to subclassing for extending functionality.

\subsubsection{Facade}
Provide a unified interface to a set of interfaces in a subsystem.  For example, a facade defines a higher-level interface that makes the subsystem easier to use.

\subsubsection{Flyweight}
Use sharing to support large numbers of fine-grained objects efficiently.

\subsubsection{Proxy}
Provide a surrogate or placeholder for another object to control access to it.

\subsection{Behavioral Patterns}

\subsubsection{Chain of Responsibility}
Avoid coupling the sender of a request to its receiver by giving more than one object a chance to handle the request.  Instead, chain the receiving objects together and pass the request along until an object handles it.

\subsubsection{Command Pattern}
Encapsulate a request as an object, letting programmers parameterize clients with different requests, queue or log requests, and support undoable operations.

\subsubsection{Interpreter}
Given a language, define a representation for its grammar in addition to an interpreter that uses the representation to interpret sentences in the language.

\subsubsection{Iterator}
An iterator provides a way to access the elements of an aggregate object sequentially, without exposing its underlying representation.

\subsubsection{Mediator}
A mediator is an object that encapsulates how a set of objects interact.  A mediator promotes loose coupling by keeping objects from explicitly referring to each other, allowing programmers to vary their interaction independently.

\subsubsection{Memento}
A program using the memento pattern captures and externalizes an object's internal state so the object can be restored to this state later, without violating encapsulation.

\subsubsection{Observer}
An observer defines a one-to-many dependency between objects so that when one object changes state, all of its dependencies are notified and updated automatically.

\subsubsection{State}
Programs using the state design pattern empower objects to alter their behavior when their internal states change.  Objects may even appear to change their classes.

\subsubsection{Strategy}
Define a family of algorithms, encapsulate each, and make them interchangeable.  Strategy lets the algorithm vary independently from clients that use it.

\subsubsection{Template Method}
Define the skeleton of an algorithm in an operation, deferring some steps to subclasses.  The template method lets subclasses redefine specific steps of an algorithm without changing the algorithm's structure.

\subsubsection{Visitor}
A visitor represents an operation to be performed on the elements of an object structure.  A visitor lets programmers define new operations without changing the classes and elements of their dependencies.

\subsection{Interning Pattern}
The interning pattern is not a Gang of Four design pattern.  With the interning pattern, existing objects with the same value are copied, instead of creating new, identical objects.  Unlike the singleton pattern, multiple instances of the same object exist, but objects with the same value are reused where needed.  Additionally, interned objects can be compared with == instead of equals because they are the same object.  Interning may improve program speed!
\\
\includegraphics[width=\textwidth]{interning.png}
\\
Interning applies to immutable objects only.  Thus, Java strings can be interned.  Here is an example of the Interning Pattern:
\begin{verbatim}
    HashMap<String,String> names;
    
    String canonicalName(String n) {
        if (names.containsKey(n)) 
            return names.get(n);
        else { 
            names.put(n,n); 
            return n;
        }
    }
\end{verbatim}
Here is the JavaDoc for String.intern(): 
\begin{quote}
public String intern()
\\
\\
Returns a canonical representation for the string object.
\\
\\
A pool of strings, initially empty, is maintained privately by the class String.
\\
\\
When the intern method is invoked, if the pool already contains a string equal to this String object as determined by the equals(Object) method, then the string from the pool is returned.  Otherwise, this String object is added to the pool, and a reference to this String object is returned.
\\
\\
It follows that for any two strings s and t, s.intern() == t.intern() is true if and only if s.equals(t) is true.
\\
\\
All literal strings and string-valued constant expressions are interned.  String literals are defined in section 3.10.5 of The Java Language Specification.
\\
\\
Returns:
\\
a string that has the same contents as this string, but is guaranteed to be
from a pool of unique strings.
\end{quote}

\subsection{Unified Modeling Language (UML)}
UML class diagrams show classes and their relationships, including inheritance and composition, attributes, and operations.  Additionally, UML sequence diagrams can show the dynamics of a system.  UML is the standard "language" of object-oriented modeling and design.
Here is some UML notation:
\begin{itemize}
    \item Boxes are classes
    \item $\bigtriangleup$ on arrows denote inheritance with subclasses pointing to superclasses
    \item \textit{italics} denote abstract types
    \item dotted lines between classes denote interface inheritance
\end{itemize}
\\
\includegraphics[width=\textwidth]{uml1.png}
\\
\includegraphics[width=\textwidth]{uml2.png}
\\
UML associations often represent a composition relationship; objects of one class enclose objects of another.  Thus, UML is often used to model abstract concepts and their relationships.  Attributes and associations correspond to ADT operations.  UML can express designs - there is a close correspondence to implementation.  Attributes and associates correspond to representation fields.
\\
\includegraphics[width=\textwidth]{graphuml.png}
\\
\subsection{Wrappers}
A wrapper is a thin layer over an encapsulated class that uses composition/delegation to modify its interface - as we did with the GraphWrapper.  Then, the wrapper extends the behavior of the encapsulated class and restricts access to the encapsulated object.  The encapsulated object (delegate) does most work.  The wrapper is not a GoF pattern, but is similar to Adapter and Façade GoF patterns.



\subsection{Strategy / Policy Pattern}
This pattern defines multiple algorithms and lets client applications pass the algorithm to be used as a parameter.  The strategy pattern reduces coupling by allowing users to program to an interface, rather than an implementation.  Collections.sort is an example.  It takes the Comparator parameter.  Based on the different implementations of Comparator interfaces, the Objects are getting sorted in different ways.  Strategy pattern is very similar to State and Command Patterns.  The strategy pattern is useful when we have multiple algorithms for a specific task.  We want our application to be flexible in choosing any algorithms at runtime for a specific task.
\\
\includegraphics[width=\textwidth]{strategy.png}
\\

\newpage