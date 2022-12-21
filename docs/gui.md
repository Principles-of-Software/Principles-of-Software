# Graphical User Interface (GUI) Programming
We use design patterns and concepts to program GUIs.  Often, the Model View Controller (i.e., Observer) or Composite design pattern is used when programming graphical user interfaces.  GUI components are often part of the View and Controller.  GUI components are often composites.  GUIs use Event-driven programming and Large APIs.

## Serialization
HashSet is a serializable class.  Convert its state to a byte stream so that the byte stream can be reverted back into a copy of the object.  This requires a version number of type long.  After a serialized object has been written into a file, it can be read from the file and deserialized.  If you extend Serializable and don’t have a version number, Java issues a warning.  Eclipse will generate one for you.  For example:
\begin{verbatim}
public class Employee implements java.io.Serializable { 
    public String name;
    public String address;
    public transient int SSN;
    public int number;
    public void mailCheck() {
        System.out.println("Mailing a check to " + name + " " + address); 
    }
}
\end{verbatim}
Fields not meant to be serialized are marked as transient.
\\
\\
In general, the structure of a GUI Application goes: 1) Place components in a container (JPanel) then add container to frame (JFrame).  The Container stores components and governs their positions, sizes and resizing behavior.  Once components are added to their container, pack() figures the sizes of all components and calls the layout manager to set locations in the container.  If your window doesn’t look right, you may be forgetting pack().  Use SimpleLayoutMain.java.

\subsection{Java GUI Libraries}
Swing is the main Java GUI library.  It paints GUI components itself, pixel-by-pixel.  It does not delegate to the OS window system, though it emulates the look and feel of several platforms.  It's also platform-independent.  We like Swing because of its expanded set of widgets and features, cross-platform compatibility, and Object Oriented Design.  Swing component objects all have a certain size they would like to be: just large enough to fit their contents (text, icons, etc.).  This is called the preferred size of the component.  Some types of layout managers (e.g., FlowLayout) choose to size the components inside them to the preferred size.  Others (e.g., BorderLayout, GridLayout) disregard (some dimension of) the preferred size and use some other scheme to size the components.
\\
\\
Abstract Windowing Toolkit (AWT) is Sun’s initial GUI library.  It maps Java code to each OS’s windowing system.  Unfortunately, you've got a limited set of widgets, and it's clunky to use.
\\
\\
JavaFX is the most recent GUI library.  It was intended to eventually replace Swing, and is declarative in nature.

\subsection{Terminology}
window: A first-class citizen of the graphical desktop.  E.g., frame.
\\
\\
component: A GUI widget that resides in a window.  E.g., button, text box or label.  Every property in a component has a get (or is) accessor and a set modifier. E.g., getFont, setFont, isVisible.  Properties include: background – color behind component; border - border line around component; enabled – whether it can be interacted with; focusable – whether text can be typed on it; font – font used for text in component, etc.
\\
\\
container: A component that holds other components.  Windows, such as JFrame or Jdialog are top-level containers.  They live at the top of UI hierarchy, and are not nested.  They can be used by themselves, but usually as a host for other components.  Mid-level containers are JPanel, JToolBar.  Sometimes, these can contain other components, sometimes not.  JPanel is a general-purpose component for drawing or hosting other UI elements.  Specialized containers are menus, list boxes; all components are containers, but not all are general purpose.

\subsection{JFrame - Top-Level Window}
It's a graphical window on the screen.  Typically holds other components.  Some common methods are:
\begin{itemize}
    \item JFrame(String title): constructor, title optional
    \item setSize(int width, int height)
    \item add(Component c): add component to window
    \item setVisible(boolean v) – don’t forget this!
\end{itemize}

setDefaultCloseOperation(int o) makes the frame perform the given action when it closes.  A common value is JFrame.EXIT\_ON\_CLOSE.  If not set, the program will never exit even if the frame is closed.  Don’t forget this!  Your options for behavior on close are:

\begin{itemize}
    \item DO\_NOTHING\_ON\_CLOSE (defined in WindowConstants): Don't do anything; require the program to handle the operation in the windowClosing method of a registered WindowListener object.
    \item HIDE\_ON\_CLOSE (defined in WindowConstants): Automatically hide the frame after invoking any registered WindowListener objects.
    \item DISPOSE\_ON\_CLOSE (defined in WindowConstants): Automatically hide and dispose the frame after invoking any registered WindowListener objects.
    \item EXIT\_ON\_CLOSE (defined in JFrame): Exit the application using the System exit method.  Use this only in applications.
\end{itemize}

setSize(int width, int height) gives the frame a fixed size in pixels.  pack() resizes the frame to fit components, and setVisible(true) shows the window.

\subsection{JPanel - a General Purpose Container}
panels are used to group other containers - a place for graphics, or to hold buttons, labels, etc.  They must be added to a frame or other container via frame.add(new JPanel(...));.  panels can be nested at any depth.  JPanel has many methods in common with JFrame because they serve a similar function.  There are some new methods though, like setPreferredSize(Dimension d).

\subsection{Layout Managers}
Layout Managers are in charge of sizing and positioning.  Absolute positioning is in (C++, C\#, other), where the programmer specifies the exact coordinates of every component.  E.g., “Put this button at (x=15, y=75) and make it 70x31 pixel in size”.  Layout managers in Java create objects that decide where to position each component based on some general rules or criteria.  For example, “Put these four buttons into a 2x2 “grid” and put these text boxes in a “horizontal flow” in the “south” part of the frame”.
\\
\\
Each container has a layout manager.  You've got FlowLayout (left to right, top to bottom), which is the default for JPanel, and BorderLayout (“center”, “north”, “south”, “east”, “west”), which is the default for JFrame.
\\
\\
FlowLayout treats container as a left-to-right, top-to-bottom “paragraph”.  Components are given a preferred size, horizontally and vertically.  Components are positioned in the order added.  If they're too long, components wrap around to the next line.
\\
\\
BorderLayout divides the container into five regions.  NORTH and SOUTH regions expand to fill component horizontally and use the
component’s preferred size vertically.  WEST and EAST regions expand to fill region vertically and use the component’s preferred size horizontally.  CENTER uses all space not occupied by others.

\subsection{Graphing, Painting, etc.}
What if we want to draw something?  An image, a path?  You should extend JPanel and override method paintComponent.  The Method in JComponent that draws the component is SimplePaintMain.java.
\\
\\
There are many methods to draw various lines, shapes.  You can also draw images (pictures, etc.).  Load the image file into an Image object and use g.drawImage(...).  In the program (maybe not in paintComponent): Image image = ImageIO.read(file).  Then, in paintComponent, g.drawImage(image, ... ).  There is built-in support for GIF, PNG, JPEG, BMP, and WBMP.
\\
\\
Graphics is part of the original Java AWT • e.g.,g.drawRect(...).  Swing introduced Graphics2D, which added an Object Oriented interface, so you could create instances of Shape, e.g., Line2D, Rectangle2D, etc.  Then call draw with respective arg: draw(Shape s).  Argument passed to paintComponent is a Graphics object.  You can always cast it to Graphics2D, which supports both sets of graphics methods.  Use whichever you like.
\\
\\
The window manager calls paintComponent whenever it wants!!!  When the window is first made visible and whenever after that it is needed.  Never call paintComponent yourself!  Thus, paintComponent must always be ready to repaint.  You must be able to access all information needed.  If you must redraw a window, call repaint().  This tells the window manager to schedule repainting.  The window manager will call paintComponent when it decides to redraw (soon, but not right away).
\\
\\
You must always override paintComponent(Graphics) if you want to draw a component.  Always call super.paintComponent(g) first from your paintComponent(...). Why?  NEVER call paintComponent yourself.  Always paint the entire picture from scratch.
\\
\\
Use paintComponents’ Graphics parameter to do all the drawing.  ONLY use it for that.  Don’t copy it, try to replace it, permanently side-effect it, etc.  It is quick to anger.  Don't create new Graphics or Graphics2D objects.

\subsection{Event-Driven Programming}
The main body of the program functions like an event loop.  You don't actually program like this.  Event-Driven Programming is a style of programming where the flow of execution is dictated by events.  The program loads, then waits for the user to input events.  As the event occurs, the program runs code to respond.  The flow of what code is executed is determined by the series of events that occur.
\\
\\
In contrast, application or algorithm-driven control expects input in well-defined places.  This is typical for large non-GUI applications.
\\
\\
An event is an object that represents the user’s interaction with a GUI component; event can be “handled”.
\\
\\
A listener is an object that waits for events and handles them.  To handle an event, you must attach a listener to a component.  The listener will be notified when the event (e.g., button click) occurs.
\\
\\
There are a few different kinds of GUI events:
\begin{itemize}
    \item Mouse: move/drag/click, mouse button press / release
    \item Keyboard: key press/release, sometimes with modifiers like shift/control/alt
    \item Touchscreen: finger tap/drag
    \item Joystick, drawing tablet, other device inputs
    \item Window resize/minimize/restore/close
    \item Network activity or file I/O (start, done, error)
    \item Timer interrupt (including animations)
\end{itemize}
Every event object contains information about the event.  You get the GUI component that triggered the event, and other information depending on the event, like ActionEvent (text string from a button) or MouseEvent (mouse coordinates).  An action event is an action that has occurred on a GUI component.  This is the most common Event type in Swing.  Some examples are button or menu clicks, or check box checking/unchecking, etc.  These are all represented by the class ActionEvent.  They are handled by objects that implement interface ActionListener.
\\
\\
When an event occurs, the appropriate method specified in the interface is called.  When an action event (e.g., a button click) occurs, actionPerformed gets called on the attached (i.e., registered) Listeners.  An event object is passed as a parameter to the event listener method - for instance, actionPerformed(ActionEvent e).
\\
\\
JButton(String text) creates a new button with the given string as text.  String getText() and void setText(String text) get and set button’s text, respectively.  Create a JButton and add it to the window, create an object that implements Action Listener, add it to the button’s listeners with ButtonDemo1.java.
\\
\\
A single button listener can handle several buttons.  How to tell which is which?  An ActionEvent has a getActionCommand method that returns (for a button) the “action command” string.  Default is the button name.  It is better to set it to a specific string, which will remain the same even if UI (and button name) changes.

\subsection{Nested Classes}
A nested class is a class defined in another class.  static nested class or non-static nested class (known as inner classes) are hidden from other classes.  Inner objects can access the fields and methods of their outer object.  Event listeners are often defined as inner classes inside a GUI.  The syntax is as follows:
\begin{verbatim}
public class OuterClass { 
    ...
    // Instance nested class (inner class)
    // A different class for each instance of Outer private class InnerClass { ... } 
    // Static nested class
    // One class, shared by all instances of Outer
    static private class NestedClass { ... } 
}
\end{verbatim}
If private, only the outer class can see the nested class or create objects of it.  Each inner object is associated with the outer object that created it, so it can access or modify that outer object’s methods or fields.  The inner class can refer to the outer object as OuterClass.this.
\\
\\
An Anonymous Inner class is a use-once class, defined directly in the new expression.  Specify your base class to be extended or interface to be implemented, and override or implement needed methods.  If the class starts to be complicated, use an ordinary class!  The syntax is as follows:
\begin{verbatim}
    button.addActionListner(new ActionListner() { 
        public void actionPerformed(ActionEvent e) {
            doSomething() 
            \\ implementation of method for anonymous class
        }
    }
)
\end{verbatim}
the new expression is to create the class instance, and ActionListener is the base class or interface to be extended.

\subsection{Program Thread and UI Thread}
Your program and the UI run in concurrent threads.  All UI actions happen in the UI thread, including callbacks like paintComponent and actionPerformed.  After event handling, you may call repaint if paintComponent needs to run, but do not try to draw anything from inside the event handler!  The series of actions is as follows:
\begin{verbatim}
    - Repaint() returns immediately
    - Painting occurs when window manager is ready
    - paintComponent() is called
\end{verbatim}
\begin{center}
\includegraphics[width=5cm]{programwindow.png}
\end{center}
In the UI Thread, event handlers should not do a lot of work.  If the event handler does a lot of work, the interface will appear to freeze up.  If there is a lot to do, the event handler should set a bit that the program thread will notice, then do the heavy work back in the program thread.

\subsection{Components, Events, Listeners, and the Observer Pattern}
Model View Controller (another name for the Observer Pattern) comes up a lot.  One possible design for a GUI could be:
\begin{itemize}
    \item A model class (e.g., Sale) is the observable
    \item When Sale changes, it notifies its observers
    \item A Component, (e.g., a class that extends JFrame) is the observer (this is achieved by also implementing some Listener interface)
\end{itemize}

\includegraphics[width=\textwidth]{cfd.png}
\includegraphics[width=\textwidth]{cfd2.png}
\newpage