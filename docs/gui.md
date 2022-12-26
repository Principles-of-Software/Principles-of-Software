# Graphical User Interface (GUI) Programming

We use design patterns and concepts to program GUIs.  The Observer or Composite design pattern is often used when programming graphical user interfaces.  GUI components are often part of the View and Controller.  GUI components are often composites.  GUIs use Event-driven programming and Large APIs.

## Terminology

We must lay out some important definitions before moving forward with GUI programming.  For instance, a **Window** is <span style="color:blue;">a first-class citizen of the graphical desktop, such as a frame</span>.

A **Component** is <span style="color:blue;">a GUI widget that resides in a window, such as a button, text box, or label</span>.  Every property in a component has accessor methods, such as `getFont` or `isVisible`, and modifier methods, like `setFont`.  Some modifiable properties include **Background**, the <span style="color:blue;">color behind component</span>, **Border**, the <span style="color:blue;">line around a component</span>; **Enabled**, an <span style="color:blue;">indicator of intractability</span>; **Focusable**, <span style="color:blue;">whether text can be edited</span>; and **Font**, <span style="color:blue;">used for text in components</span>.

A **Container** is <span style="color:blue;">a component that holds other components</span>.  Windows, such as `JFrame` or `Jdialog`, are **Top-Level Containers**: <span style="color:blue;">they live at the top of UI hierarchy, and are not nested; they can be used by themselves, but usually host other components</span>.  `JPanel`, `JToolBar` are **Mid-Level Containers** -- <span style="color:blue;">they can stand alone, but more often contain other components</span>.  **JPanel** is <span style="color:blue;">a general-purpose component for drawing or hosting other UI elements</span>.  Some examples of **Specialized Containers** are <span style="color:blue;">menus or list boxes; all components are containers, but not all are general purpose</span>.
There are some methods used very often in GUI programming.  **`setSize(int width, int height)`** <span style="color:blue;">gives the frame a fixed size in pixels</span>.  **`pack()`** <span style="color:blue;">resizes the frame to fit components</span>, and **`setVisible(true)`** <span style="color:blue;">shows the window</span>.

## JFrame

A **JFrame** is <span style="color:blue;">a top-level graphical window</span> that typically holds other components.  In implementation, some common methods are:

- `JFrame(String title)`: constructor, title optional
- `setSize(int width, int height)`
- `add(Component c)`: add component to window
- `setVisible(boolean v)`: necessary to initialize on scree.  Do not forget this step!

Even when containers are closed, they may still be serving their purpose.  `setDefaultCloseOperation(int o)` sets a given action for the frame to perform when it closes.  A common value for this is `JFrame.EXIT\_ON\_CLOSE`.  If the closing operation is not set, the program will never exit, even if the frame is closed.  Do not forget this to set closing behavior!  Options for behavior on close are:

- **`DO\_NOTHING\_ON\_CLOSE`**: <span style="color:blue;">Do not do anything - handle the operation in the `windowClosing` method of a registered `WindowListener` object</span>.
- **`HIDE\_ON\_CLOSE`**: <span style="color:blue;">Automatically hide the frame after invoking any registered `WindowListener` objects</span>.
- **`DISPOSE\_ON\_CLOSE`**: <span style="color:blue;">Automatically hide and dispose of the frame after invoking any registered `WindowListener` objects</span>.
- **`EXIT\_ON\_CLOSE`**: <span style="color:blue;">Exit the application using the `System exit` method</span>.  Use this only in applications.

A good example of `JFrame` in action, based on examples 7-1 in Core Java 8th edition, is as follows:

    package gui1;    
    import javax.swing.*;    
    /* Simple graphics window (based on ex. 7-1 in Core Java 8th ed.)   */    
    public class SimpleFrameMain {    
        /** Create a frame and display it. */    
        public static void main(String[] args) {    
    SimpleFrame frame = new SimpleFrame("A Window");     
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);    
    frame.setVisible(true);    
        }    
    }    
    class SimpleFrame extends JFrame {    
        public SimpleFrame(String title) {    
    super(title);   // set the title    
    pack(); // resize the frame to fit components if there are any    
    this.setSize(1200,800);    
        }    
    }

## JPanel

Panels are used to group other containers.  They contain graphics, buttons, labels, and anything else a panel should have.  Panels must be added to a frame or other container via `frame.add(new JPanel(...));`.  `JPanel` has many methods in common with `JFrame` because they serve a similar function, though panels can be nested at any depth.  However, some new methods exist, like `setPreferredSize(Dimension d)`.

## Layout Managers

Layout Managers are in charge of sizing and positioning.  **Absolute Positioning** is a feature of C++, C\#, and many other languages, where <span style="color:blue;">the programmer specifies the exact coordinates of every component</span>.  For example, with absolute positioning, one can say, “Put this button at (`x=15`, `y=75`) and make it` 70x31` pixels in size”.  In contrast, layout managers in Java create objects that decide where to position each component based on general rules or criteria.  For example, “Put these four buttons into a `2x2` grid” or “place these text boxes in a horizontal flow in the southern part of the frame.”

Each container has a layout manager.  **`FlowLayout (left to right, top to bottom)`**, which <span style="color:blue;">is the default layout manager for `JPanel`</span>, and **`BorderLayout (center, north, south, east, west)`**, which <span style="color:blue;">is the default layout manager for JFrame</span>.  `FlowLayout` treats containers as left-to-right, top-to-bottom “paragraphs.”  Components are then given a preferred size and positioned in the added order.  If they are too long, components wrap around to the next line.

`BorderLayout` divides containers into five regions: North and South regions expand to fill components horizontally and use the preferred size convention vertically.  West and East regions expand to fill regions vertically and the preferred size horizontally.  Finally, center regions use all space not occupied by other elements.

## Graphing, Painting, and other things

What if we want to draw something like an image or a path?  Extending JPanel and overriding `paintComponent` enable this.  The method in `JComponent` that draws components is `SimplePaintMain.java`.

There are many methods to draw various lines, shapes, and images.  For images, the source file into an Image object and use `g.drawImage(...)`.  Then, the implementation will look like this:

    package gui3;
    import java.awt.*;
    import javax.swing.*;
    /* Example overriding paintComponent to create a static drawing. */
    public class SimplePaintMain {
        /** Create a labeled panel with a couple of shapes and display it. */
        public static void main(String[] args) {
        JFrame frame = new JFrame("Simple Painting Example");
        JPanel panel = new SimplePainting();
        panel.setPreferredSize(new Dimension(300,200));
        JLabel label = new JLabel("A Work of Art");
        label.setHorizontalAlignment(SwingConstants.CENTER);
        frame.add(panel,BorderLayout.CENTER);
        frame.add(label,BorderLayout.SOUTH);
        frame.pack();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
        }
    }
    class SimplePainting extends JPanel {
        private static final long serialVersionUID = -4725346878809211984L;
        /** Paint some simple shapes whenever the window manager calls this. */
        @Override
        public void paintComponent(Graphics g) {
        // ensure any background belonging to the container is painted
        super.paintComponent(g);
        // Cast g to its actual class to make graphics2d methods available.
        // We do not use them here, but this cast is often necessary.
        Graphics2D g2 = (Graphics2D) g;
        // draw a couple of shapes
        g2.setColor(Color.green);
        g2.fillOval(40,30,120,100);
        g2.setColor(Color.red);
        g2.drawRect(60,50,60,60);
        System.out.println("Finished drawing");
        }
    }

The window manager calls `paintComponent` when the window is first made visible and whenever it is needed afterward.  Never call `paintComponent` manually - that may take its resources away from a more automatic repaint.  Instead, if manually redrawing a window is necessary, call `repaint()`.  That tells the window manager to schedule repainting.  The window manager will then call `paintComponent` when it can, which may not be right away.

Use `paintComponent`'s `Graphics` parameter to do all the drawing, and only the drawing.  Do not meddle with the `Graphics` parameter otherwise; it is quick to anger.  In the same vein, do not create new Graphics or Graphics2D objects.

## Event-Driven Programming

The main body of the program functions like an event loop, though it does not exist inside a loop.  **Event-Driven Programming** is <span style="color:blue;">a style of programming where events dictate the flow of execution</span>.  The program loads, then waits for the user to input **Events**, <span style="color:blue;">objects that represent user interaction with the GUI component</span>.  As events occur, the program runs code to respond.  The flow of what is executed is determined by event order.

In contrast, application or algorithm-driven control expects input in well-defined places.  Algorithm-driven control is typical for large non-GUI applications.

A **Listener** is <span style="color:blue;">an object that waits for events and handles them</span>.  To handle an event, attach a listener to a component.  The listener will be notified when the event (e.g., button click) occurs.

There are a few different kinds of GUI events:

- **Mouse**: <span style="color:blue;">move, drag, click, button press, and button release</span>
- **Keyboard**: <span style="color:blue;">key press and release, sometimes with modifiers like shift, control, or alt</span>
- **Touchscreen**: <span style="color:blue;">finger tap and drag</span>
- Joystick, drawing tablet, other device inputs
- **Window** <span style="color:blue;">resize, minimize, restore, or close</span>
- Network activity or file I/O (start, done, error)
- Timer interrupt (including animations)

Every event object contains information about events it can handle.  That information includes the triggering GUI component and other information depending on the event, like ActionEvent (text string from a button) or MouseEvent (mouse coordinates).  An **Action Event** is <span style="color:blue;">an action that has occurred on a GUI component</span>.  Action events are the most common event type in Swing.  Some examples are button clicks and check box-checking or unchecking.  These are all represented by the class `ActionEvent`.  They are handled by objects that implement `interface ActionListener`.

The appropriate method specified in the interface is called when an event occurs.  For example, when an action event occurs, `actionPerformed` gets called on the attached or registered Listeners.  An event object is then passed as a parameter to the event listener method - for instance, `actionPerformed(ActionEvent e)`.

`JButton(String text)` creates a new button with the given string as text.  `String getText()` and `void setText(String text)` get and set a button’s text, respectively.  See this in action below:

    package gui4;    
    import java.awt.*; // basic AWT classes    
    import java.awt.event.*; // event classes    
    import javax.swing.*; // Swing classes    
     
    /* Straightforward demo of Swing event handling.     
    * Create a window with a single button that prints a message when clicked.    
    * Version 1 with named inner class to handle button events.    
    */   
    public class ButtonDemo1 {    
        // inner class to handle button events    
        private static class MyButtonListener implements ActionListener {    
    final String id;    
    private int nEvents = 0;    

    /** Create a new MyButtonListener */    
    public MyButtonListener(String id) {    
    this.id = id;    
    }    

    /* Respond to events generated by the button by printing the    
    * command and number of times the event has been triggered.    
    * @param e the event created by the button when it was clicked.    
    */    
    @Override    
    public void actionPerformed(ActionEvent e) {    
    nEvents++;    
    System.out.println(id + " " + e.getActionCommand() + " " + nEvents);    
    }    
        }    
        public static void main(String[] args) {    
    // Create a new window and set it to exit from the application when closed.    
    JFrame frame = new JFrame("Button Demo");    
    frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);    
    // Create a new button with the label "Hit me" and the string "OUCH!" to be    
    // returned as part of each action event.    
    JButton button = new JButton("Hit me");    
    button.setActionCommand("OUCH!");    
    button.addActionListener(new MyButtonListener("Listener1"));    
    // Experiment: add two ButtonListeners    
    // button.addActionListener(new MyButtonListener("Listener2"));    
    // button.addActionListener(new MyButtonListener("Listener3"));    
    // Experiment: add a single ButtonListener twice    
    // MyButtonListener mbl = new MyButtonListener("Listener4");    
    // button.addActionListener(mbl);    
    // button.addActionListener(mbl);    
    // Functional version    
    // button.addActionListener(evt -> System.out.println("Listener5 OUCH!"));    
    // Add a button to the window and make it visible.    
    frame.add(button);    
    frame.pack();    
    frame.setVisible(true);    
        }    
    }

A single button listener can handle several buttons, so how does one tell which is which?  An `ActionEvent` has a `getActionCommand` method that returns an "action command" string, in this case, the button name.  Button names, by default, are "Default," so it is better to set button names to specific strings, which remain the same even if the UI and other button names change.

## Serialization

`HashSet` is a serializable class.  To **Serialize** a class, <span style="color:blue;">convert an object's state to a byte stream that can be reverted to a copy of the original object</span>.  Serializing requires a version number of type `long`.  After a serialized object has been written into a file, it can be read from the file and deserialized.  Java issues a warning if `Serializable` is extended without a version number.  Luckily, Eclipse generates one automatically.  See this example of serialization:

    public class Employee implements java.io.Serializable {
        public String name;
        public String address;
        public transient int SSN;
        public int number;
        public void mailCheck() {
            System.out.println("Mailing a check to " + name + " " + address);
        }
    }

<span style="color:blue;">Fields not meant to be serialized</span> are marked as **Transient**.

In general, the structure of a GUI Application can be summarized in two steps:

1. Place components in a **JPanel**, a <span style="color:blue;">Java container that stores groups of components</span>
2. Add the new container to a **JFrame**, the <span style="color:blue;">main window in Java</span>.

The container stores components and governs their positions, sizes, and resizing behavior.  Once components are added to their container, `pack()` calculates all component sizes and calls the layout manager to set component locations.  Remember `pack()`; omitting it can lead to (for lack of a better term) funky layouts.  Use `SimpleLayoutMain.java` when in doubt.

## Java GUI Libraries

**Swing** is <span style="color:blue;">the leading Java GUI library</span>.  There are many advantages to using Swing:

- It paints GUI components itself, pixel-by-pixel
- It does not delegate to the OS window system, though it emulates the look and feel of several platforms
- Swing is platform-independent - cross-platform compatibility is  key to covering all operating system and browser options available
- It has an expanded set of widgets and features made possible by object-oriented design

Swing component objects all have a **Preferred Size** that they would like to be: <span style="color:blue;">just large enough to fit their contents</span>.  Some other layout managers, such as `FlowLayout`, also choose to size the components inside them to the preferred size.  Others, such as `BorderLayout` or `GridLayout`, disregard the preferred size convention and use some other scheme to size components.

**Abstract Windowing Toolkit (AWT)** is Sun’s initial GUI library.  It <span style="color:blue;">maps Java code to each OS’s windowing system</span>.  Despite this feature, AWT is otherwise clunky to use and offers a limited set of widgets.

**JavaFX** is the most recent GUI library.  It was <span style="color:blue;">built to replace Swing eventually and uses a declarative framework</span>.

## Nested Classes

A **Nested Class** is <span style="color:blue;">a class defined in another class</span>.  **Inner Objects**, or <span style="color:blue;">objects within nested classes</span>, can access the fields and methods of their outer method.  Event listeners are often defined as inner classes inside a GUI.  The syntax is as follows:

    public class OuterClass {
        ...
        // Instance nested class (inner class)
        // A different class for each instance of Outer private class InnerClass { ... }
        // Static nested class
        // One class, shared by all instances of Outer
        static private class NestedClass { ... }
    }

If a nested class is private, only the outer class can see it and create objects of the nested type.  In that case, each inner object is associated with the outer object that created it so that the inner object can access or modify the outer object.  The inner class can then refer to the outer object as `OuterClass.this`.

An **Anonymous Inner Class** is a <span style="color:blue;">use-once class defined directly in the new expression</span>.  In an anonymous inner class, specify the base class to be extended or interface to be implemented, and override or implement needed methods.  If the class gets complicated, the anonymous clause can be dropped.  The syntax is as follows:

        button.addActionListner(new ActionListner() {
            public void actionPerformed(ActionEvent e) {
                doSomething()
                implementation of the method for anonymous class
            }
        }
    )

## Program Thread and UI Thread

Programs and their UI run in concurrent threads.  All UI actions happen in the UI thread, including callbacks like `paintComponent` and `actionPerformed`.  After event handling, `repaint` can be called if `paintComponent` needs to run, but do not try to draw anything from inside the event handler.  The series of actions is as follows:

- `Repaint()` returns immediately
- `Painting` occurs when the window manager is ready
- `paintComponent()` is called

![](images\programwindow.png)

In the UI Thread, event handlers should only do a little work; if the event handler gets busy, the interface will appear to freeze up.  On the other hand, if there is a lot to do, the event handler should handle some events that the program thread will notice, and then do the heavy work behind the scenes.

## Components, Events, Listeners, and the Observer Pattern

The **Model View Controller (MVC)** design pattern, <span style="color:blue;">another name for the observer design pattern</span> comes up a lot.  One possible design for a GUI using MVC could be:

- A **Model** or <span style="color:blue;">observable class</span>, such as `Sale`
    - When `Sale` changes, it notifies its observers
    - The **Component**, is <span style="color:blue;">an observer class that extends JFrame</span>.  A component can also be initialized by implementing some Listener interface.

![](images\cfd.png)
![](images\cfd2.png)
