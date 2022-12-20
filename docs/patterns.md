# Design Patterns
A design pattern is a generic solution to a recurring design problem.   Design patterns seek to solve common programming problems with a few common solutions:

- \textbf{Encapsulation}: hiding implementation components in a layer below what the client can access.
- \textbf{Subclassing} - Making a "wrapper" that implements something else to reduce repetition.
- \textbf{Iteration} - The object does traversals to access all members of a collection.
- \textbf{Exceptions} - Errors in one part of the code should be handled elsewhere, so the language is structured for throwing and catching exceptions.
- \textbf{Generics} - Generic types allow users to use objects of any type in data structures.

SOLID Design Principles:

- \textbf{Single Responsibility Principle} - A class should have only one responsibility.
- \textbf{Open-Closed Principle} - A class's behavior can be extended without modifying it.
- \textbf{Liscov Substitution Principle} - The derived classes must be substitutable for their base classes.
- \textbf{Interface Segregation Principle} - Many client-specific interfaces are better than one general-purpose interface.
- \textbf{Dependency Inversion Principle} - Implementation should depend on abstractions, not concrete implementations.

Design patterns do not solve all design problems, but they can increase code clarity and improve modularity.

There are three different kinds of design patterns: creational patterns, structural patterns, and behavioral patterns.

## Creational Patterns
\subsubsection{Abstract Factory}
The Abstract Factory pattern provides an interface for creating families of related or dependent objects without specifying their concrete classes.\\\\
For example, the \verb+AbstractSoupFactory+ defines the method names and return types to make various kinds of soup.
\\\\
The \verb+BostonConcreteSoupFactory+ and the \verb+HonoluluConcreteSoupFactory+ both extend the \verb+AbstractSoupFactory+.
\\\\
An object can be defined as an \verb+AbstractSoupFactory+ and instantiated as either a \verb+BostonConcreteSoupFactory+ (BCSF) or a \verb+HonoluluConcreteSoupFactory+ (HCSF). Both BCSF or HCSF have the \verb+makeFishChowder+ method, and both return a \verb+FishChowder+ type class. However, the BCSF returns a \verb+FishChowder+ subclass of \verb+BostonFishChowder+, while the HCSF returns a \verb+FishChowder+ subclass of HonoluluFishChowder.  \\\\
Code for all three classes is featured below, starting with the \verb+AbstractSoupFactory+:
\begin{verbatim}
abstract class AbstractSoupFactory {
    String factoryLocation;
    public String getFactoryLocation() {
        return factoryLocation;
    }
    
    public ChickenSoup makeChickenSoup() {
        return new ChickenSoup();
    }
    public ClamChowder makeClamChowder() {
        return new ClamChowder();
    }
    public FishChowder makeFishChowder() {
        return new FishChowder();
    }     
    public Minnestrone makeMinnestrone() {
        return new Minnestrone();
    }
    public PastaFazul makePastaFazul() {
        return new PastaFazul();
    }
    public TofuSoup makeTofuSoup() {
        return new TofuSoup();
    }
    public VegetableSoup makeVegetableSoup() {
        return new VegetableSoup();
    }
}

\end{verbatim}
BCSF and HCSF are next.  Notice how, in the extended classes, there different clam and fish chowders:
\begin{verbatim}

class BostonConcreteSoupFactory extends AbstractSoupFactory {
    public BostonConcreteSoupFactory() {
        factoryLocation = "Boston";
    }
    public ClamChowder makeClamChowder() {
        return new BostonClamChowder();
    }
    public FishChowder makeFishChowder() {
        return new BostonFishChowder();
    }
}

class BostonClamChowder extends ClamChowder {
    public BostonClamChowder() {
        soupName = "QuahogChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Quahogs");
        soupIngredients.add("1 cup corn");    
        soupIngredients.add("1/2 cup heavy cream");
        soupIngredients.add("1/4 cup butter");    
        soupIngredients.add("1/4 cup potato chips");
    }
}

class BostonFishChowder extends FishChowder {
    public BostonFishChowder() {
        soupName = "ScrodFishChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Scrod");
        soupIngredients.add("1 cup corn");    
        soupIngredients.add("1/2 cup heavy cream");
        soupIngredients.add("1/4 cup butter");    
        soupIngredients.add("1/4 cup potato chips");
    }
}

\end{verbatim}
\begin{verbatim}

class HonoluluConcreteSoupFactory extends AbstractSoupFactory {
    public HonoluluConcreteSoupFactory() {
        factoryLocation = "Honolulu";
    }
    public ClamChowder makeClamChowder() {
       return new HonoluluClamChowder();
    }
    public FishChowder makeFishChowder() {
       return new HonoluluFishChowder();
    }
}

class HonoluluClamChowder extends ClamChowder {
    public HonoluluClamChowder() {
        soupName = "PacificClamChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Pacific Clams");
        soupIngredients.add("1 cup pineapple chunks");
        soupIngredients.add("1/2 cup coconut milk");
        soupIngredients.add("1/4 cup SPAM");
        soupIngredients.add("1/4 cup taro chips");
    }
}

class HonoluluFishChowder extends FishChowder {
    public HonoluluFishChowder() {
        soupName = "OpakapakaFishChowder";
        soupIngredients.clear();
        soupIngredients.add("1 Pound Fresh Opakapaka Fish");
        soupIngredients.add("1 cup pineapple chunks");
        soupIngredients.add("1/2 cup coconut milk");
        soupIngredients.add("1/4 cup SPAM");
        soupIngredients.add("1/4 cup taro chips");
    }
}

\end{verbatim}
The UML diagram for this \verb+AbstractSoupFactory+ system is pictured below:\\\\
\includegraphics[width=\textwidth]{abstractuml.png}
\newpage
\subsubsection{Builder}
The Builder pattern separates the construction of a complex object from its representation so that the same construction process can create different representations.\\\\
In this example, the abstract \verb+SoupBuffetBuilder+ defines the methods necessary to create a \verb+SoupBuffet+.
\\\\
\verb+BostonSoupBuffetBuilder+ and the \verb+HonoluluSoupBuffetBuilder+ both extend the \verb+SoupBuffetBuilder+.
\\\\
An object can be defined as an \verb+SoupBuffetBuilder+, and instantiated as either a \verb+BostonSoupBuffetBuilder+ (BSBB) or a \verb+HonoluluSoupBuffetBuilder+ (HSBB).  Both BSBB or HSBB have a \verb+buildFishChowder+ method, and both return a \verb+FishChowder+ type class. However, the BSBB returns a \verb+FishChowder+ subclass of \verb+BostonFishChowder+, while the HSBB returns a \verb+FishChowder+ subclass of \verb+HonoluluFishChowder+.\\\\
Code for all three classes are featured below, starting with \verb+SoupBuffetBuilder+:
\begin{verbatim}

abstract class SoupBuffetBuilder {
    SoupBuffet soupBuffet;
        
    public SoupBuffet getSoupBuffet() {
        return soupBuffet;
    }
    
    public void buildSoupBuffet() {
        soupBuffet = new SoupBuffet();
    }
    
    public abstract void setSoupBuffetName();
        
    public void buildChickenSoup() {
        soupBuffet.chickenSoup = new ChickenSoup();
    }
    public void buildClamChowder() {
        soupBuffet.clamChowder = new ClamChowder();
    }
    public void buildFishChowder() {
        soupBuffet.fishChowder = new FishChowder();
    }
    public void buildMinnestrone() {
        soupBuffet.minnestrone = new Minnestrone();
    }
    public void buildPastaFazul() {
        soupBuffet.pastaFazul = new PastaFazul();
    }
    public void buildTofuSoup() {
        soupBuffet.tofuSoup = new TofuSoup();
    }
    public void buildVegetableSoup() {
        soupBuffet.vegetableSoup = new VegetableSoup();
    }
}

\end{verbatim}
\begin{verbatim}
class BostonSoupBuffetBuilder extends SoupBuffetBuilder {
    public void buildClamChowder() {
       soupBuffet.clamChowder = new BostonClamChowder();
    }
    public void buildFishChowder() {
       soupBuffet.fishChowder = new BostonFishChowder();
    }    
    
    public void setSoupBuffetName() {
       soupBuffet.soupBuffetName = "Boston Soup Buffet";
    }
}

class BostonClamChowder extends ClamChowder {
    public BostonClamChowder() {
        soupName = "QuahogChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Quahogs");
        soupIngredients.add("1 cup corn");    
        soupIngredients.add("1/2 cup heavy cream");
        soupIngredients.add("1/4 cup butter");    
        soupIngredients.add("1/4 cup potato chips");
    }
}

class BostonFishChowder extends FishChowder {
    public BostonFishChowder() {
        soupName = "ScrodFishChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Scrod");
        soupIngredients.add("1 cup corn");    
        soupIngredients.add("1/2 cup heavy cream");
        soupIngredients.add("1/4 cup butter");    
        soupIngredients.add("1/4 cup potato chips");
    }
}

\end{verbatim}
\begin{verbatim}
class HonoluluSoupBuffetBuilder extends SoupBuffetBuilder {
    public void buildClamChowder() {
        soupBuffet.clamChowder = new HonoluluClamChowder();
    }
    public void buildFishChowder() {
        soupBuffet.fishChowder = new HonoluluFishChowder();
    }
    
    public void setSoupBuffetName() {
        soupBuffet.soupBuffetName = "Honolulu Soup Buffet";
    }
}

class HonoluluClamChowder extends ClamChowder {
    public HonoluluClamChowder() {
        soupName = "PacificClamChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Pacific Clams");
        soupIngredients.add("1 cup pineapple chunks");
        soupIngredients.add("1/2 cup coconut milk");
        soupIngredients.add("1/4 cup SPAM");    
        soupIngredients.add("1/4 cup taro chips");
    }
}

class HonoluluFishChowder extends FishChowder {
    public HonoluluFishChowder() {
        soupName = "OpakapakaFishChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Opakapaka Fish");
        soupIngredients.add("1 cup pineapple chunks");
        soupIngredients.add("1/2 cup coconut milk");
        soupIngredients.add("1/4 cup SPAM");    
        soupIngredients.add("1/4 cup taro chips");
    }
}

\end{verbatim}
We've also included the \verb+Soup.java+ and \verb+SoupBuffer.java+ helper class to supplement the classes we already have:
\begin{verbatim}
mport java.util.ArrayList;
import java.util.ListIterator;

abstract class Soup 
{
   ArrayList soupIngredients = new ArrayList();    
   String soupName;
   
   public String getSoupName()
   {
       return soupName;
   }
   
   public String toString()
   {
        StringBuffer stringOfIngredients = new StringBuffer(soupName);
        stringOfIngredients.append(" Ingredients: ");
        ListIterator soupIterator = soupIngredients.listIterator();
        while (soupIterator.hasNext())
        {
            stringOfIngredients.append((String)soupIterator.next());
        }
        return stringOfIngredients.toString();
   }
}        

class ChickenSoup extends Soup
{
    public ChickenSoup() 
    {
        soupName = "ChickenSoup";
        soupIngredients.add("1 Pound diced chicken");
        soupIngredients.add("1/2 cup rice");    
        soupIngredients.add("1 cup bullion");      
        soupIngredients.add("1/16 cup butter");    
        soupIngredients.add("1/4 cup diced carrots");          
    }
}   

class ClamChowder extends Soup
{
    public ClamChowder() 
    {
        soupName = "ClamChowder";
        soupIngredients.add("1 Pound Fresh Clams");
        soupIngredients.add("1 cup fruit or vegetables");    
        soupIngredients.add("1/2 cup milk");      
        soupIngredients.add("1/4 cup butter");    
        soupIngredients.add("1/4 cup chips");          
    }
}

class FishChowder extends Soup
{
    public FishChowder() 
    {
        soupName = "FishChowder";
        soupIngredients.add("1 Pound Fresh fish");
        soupIngredients.add("1 cup fruit or vegetables");    
        soupIngredients.add("1/2 cup milk");      
        soupIngredients.add("1/4 cup butter");    
        soupIngredients.add("1/4 cup chips");          
    }
}

class Minnestrone extends Soup
{
    public Minnestrone() 
    {
        soupName = "Minestrone";
        soupIngredients.add("1 Pound tomatos");
        soupIngredients.add("1/2 cup pasta");    
        soupIngredients.add("1 cup tomato juice");             
    }
}

class PastaFazul extends Soup
{
    public PastaFazul() 
    {
        soupName = "Pasta Fazul";
        soupIngredients.add("1 Pound tomatos");
        soupIngredients.add("1/2 cup pasta");    
        soupIngredients.add("1/2 cup diced carrots");          
        soupIngredients.add("1 cup tomato juice");             
    }
}

class TofuSoup extends Soup
{
    public TofuSoup() 
    {
        soupName = "Tofu Soup";
        soupIngredients.add("1 Pound tofu");
        soupIngredients.add("1 cup carrot juice");    
        soupIngredients.add("1/4 cup spirolena");         
    }
}

class VegetableSoup extends Soup
{
    public VegetableSoup() 
    {
        soupName = "Vegetable Soup";
        soupIngredients.add("1 cup bullion");    
        soupIngredients.add("1/4 cup carrots");         
        soupIngredients.add("1/4 cup potatoes");         
    }
}
\end{verbatim}
\begin{verbatim}

class SoupBuffet {
   String soupBuffetName;
   
   ChickenSoup chickenSoup;
   ClamChowder clamChowder;
   FishChowder fishChowder;
   Minnestrone minnestrone;
   PastaFazul pastaFazul;
   TofuSoup tofuSoup;
   VegetableSoup vegetableSoup;

   public String getSoupBuffetName() {
       return soupBuffetName;
   }
   public void setSoupBuffetName(String soupBuffetNameIn) {
      soupBuffetName = soupBuffetNameIn;
   }
   
   public void setChickenSoup(ChickenSoup chickenSoupIn) {
       chickenSoup = chickenSoupIn;
   }
   public void setClamChowder(ClamChowder clamChowderIn) {
       clamChowder = clamChowderIn;
   }
   public void setFishChowder(FishChowder fishChowderIn) {
      fishChowder = fishChowderIn;
   }
   public void setMinnestrone(Minnestrone minnestroneIn) {
      minnestrone = minnestroneIn;
   }
   public void setPastaFazul(PastaFazul pastaFazulIn) {
       pastaFazul = pastaFazulIn;
   }
   public void setTofuSoup(TofuSoup tofuSoupIn) {
       tofuSoup = tofuSoupIn;
   }
   public void setVegetableSoup(VegetableSoup vegetableSoupIn) {
       vegetableSoup = vegetableSoupIn;
   }
   
   public String getTodaysSoups() {
        StringBuffer stringOfSoups = new StringBuffer();
        stringOfSoups.append(" Today's Soups!  ");
        stringOfSoups.append(" Chicken Soup: ");        
        stringOfSoups.append(this.chickenSoup.getSoupName()); 
        stringOfSoups.append(" Clam Chowder: ");        
        stringOfSoups.append(this.clamChowder.getSoupName()); 
        stringOfSoups.append(" Fish Chowder: ");        
        stringOfSoups.append(this.fishChowder.getSoupName()); 
        stringOfSoups.append(" Minnestrone: ");        
        stringOfSoups.append(this.minnestrone.getSoupName());
        stringOfSoups.append(" Pasta Fazul: ");        
        stringOfSoups.append(this.pastaFazul.getSoupName());
        stringOfSoups.append(" Tofu Soup: ");        
        stringOfSoups.append(this.tofuSoup.getSoupName());
        stringOfSoups.append(" Vegetable Soup: ");        
        stringOfSoups.append(this.vegetableSoup.getSoupName());
        return stringOfSoups.toString();          
   }
}  

\end{verbatim}
The UML diagram for this \verb+SoupBuffetBuilder+ system is pictured below:\\\\
\includegraphics[width=\textwidth]{builderuml.png}
\newpage
\subsubsection{Factory Method}
The Factory pattern defines an interface for creating an object, but lets subclasses decide which class to instantiate.  The factory method lets a class defer instantiation to subclasses.\\\\
For example, the \verb+SoupFactoryMethod+ defines the \verb+makeSoupBuffet+ method which returns a \verb+SoupBuffet+ object. The \verb+SoupFactoryMethod+ also defines the methods needed in creating the \verb+SoupBuffet+.
\\\\
The \verb+BostonSoupFactoryMethodSubclass+ and the \verb+HonoluluSoupFactoryMethodSubclass+ both extend the \verb+SoupFactoryMethod+. An object can be defined as an \verb+SoupFactoryMethod+, and instantiated as either a \verb+BostonSoupFactoryMethodSubclass+ (BSFMS) or a \verb+HonoluluSoupFactoryMethodSubclass+ (HSFMS).
\\\\
Both BSFMS and HSFMS override \verb+SoupFactoryMethod+'s \verb+makeFishChowder+ method. The BSFMS returns a \verb+SoupBuffet+ with a \verb+FishChowder+ subclass of \verb+BostonFishChowder+, while the HSFMS returns a \verb+SoupBuffet+ with a \verb+FishChowder+ subclass of \verb+HonoluluFishChowder+. \\\\
Example code for all the classes in the soup factory system is featured below:
\begin{verbatim}

lass SoupFactoryMethod {
    public SoupFactoryMethod() {}
        
    public SoupBuffet makeSoupBuffet() {
        return new SoupBuffet();
    }

    public ChickenSoup makeChickenSoup() {
        return new ChickenSoup();
    }
    public ClamChowder makeClamChowder() {
        return new ClamChowder();
    }
    public FishChowder makeFishChowder() {
        return new FishChowder();
    }
    public Minnestrone makeMinnestrone() {
        return new Minnestrone();
    }
    public PastaFazul makePastaFazul() {
        return new PastaFazul();
    }
    public TofuSoup makeTofuSoup() {
        return new TofuSoup();
    }
    public VegetableSoup makeVegetableSoup() {
        return new VegetableSoup();
    }

    public String makeBuffetName() {
        return "Soup Buffet";
    }
}

\end{verbatim}
\begin{verbatim}
class BostonSoupFactoryMethodSubclass extends SoupFactoryMethod {
    public String makeBuffetName() {
        return "Boston Soup Buffet";
    }
    public ClamChowder makeClamChowder() {
        return new BostonClamChowder();
    }
    public FishChowder makeFishChowder() {
        return new BostonFishChowder();
    }
}

class BostonClamChowder extends ClamChowder {
    public BostonClamChowder() {
        soupName = "QuahogChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Quahogs");
        soupIngredients.add("1 cup corn");    
        soupIngredients.add("1/2 cup heavy cream");
        soupIngredients.add("1/4 cup butter");    
        soupIngredients.add("1/4 cup potato chips");
    }
}

class BostonFishChowder extends FishChowder {
    public BostonFishChowder() {
        soupName = "ScrodFishChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Scrod");
        soupIngredients.add("1 cup corn");
        soupIngredients.add("1/2 cup heavy cream");
        soupIngredients.add("1/4 cup butter");
        soupIngredients.add("1/4 cup potato chips");
    }
}

\end{verbatim}
Featured below is the code for some additional subclasses:
\begin{verbatim}

class HonoluluSoupFactoryMethodSubclass extends SoupFactoryMethod {
    public String makeBuffetName() {
        return "Honolulu Soup Buffet";
    }
    public ClamChowder makeClamChowder() {
        return new HonoluluClamChowder();
    }
    public FishChowder makeFishChowder() {
        return new HonoluluFishChowder();
    }
}

class HonoluluClamChowder extends ClamChowder {
    public HonoluluClamChowder() {
        soupName = "PacificClamChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Pacific Clams");
        soupIngredients.add("1 cup pineapple chunks");    
        soupIngredients.add("1/2 cup coconut milk");      
        soupIngredients.add("1/4 cup SPAM");    
        soupIngredients.add("1/4 cup taro chips");          
    }
}

class HonoluluFishChowder extends FishChowder {
    public HonoluluFishChowder() {
        soupName = "OpakapakaFishChowder";
        soupIngredients.clear();        
        soupIngredients.add("1 Pound Fresh Opakapaka Fish");
        soupIngredients.add("1 cup pineapple chunks");    
        soupIngredients.add("1/2 cup coconut milk");      
        soupIngredients.add("1/4 cup SPAM");    
        soupIngredients.add("1/4 cup taro chips");          
    }
}

\end{verbatim}
This example of the factory method also uses the \verb+Soup.java+ subclass.  Pictured below is the UML diagram for the factory system:\\\\
\includegraphics[width=\textwidth]{factoryuml.png}
\newpage
\subsubsection{Prototype}
With the Prototype pattern, developers can specify the kinds of objects to create using a prototypical instance, and create new objects by copying this prototype.  In other words, new objects can be created by cloning prototypical objects.\\\\
For example, there are several protoype objects (\verb+AbstractSpoon.java+, \verb+AbstractFork.java+) and a factory object that make up this system:
\begin{verbatim}

public class PrototypeFactory {  
    AbstractSpoon prototypeSpoon;
    AbstractFork prototypeFork;
    
    public PrototypeFactory(AbstractSpoon spoon, AbstractFork fork) {
       prototypeSpoon = spoon;
       prototypeFork = fork;
   }
    
   public AbstractSpoon makeSpoon() {
       return (AbstractSpoon)prototypeSpoon.clone();
   }
   public AbstractFork makeFork() {
       return (AbstractFork)prototypeFork.clone();
   }
}

\end{verbatim}
Concrete prototype objects (\verb+SoupSpoon.java+, \verb+SaladSpoon.java+, \verb+SaladFork.java+) that extend the abstract prototypes are featured below:
\begin{verbatim}

public class SoupSpoon extends AbstractSpoon {  
   public SoupSpoon() {
       setSpoonName("Soup Spoon");
   }
}

public class SaladSpoon extends AbstractSpoon {  
   public SaladSpoon() {
       setSpoonName("Salad Spoon");     
   }
}

public class SaladFork extends AbstractFork {  
   public SaladFork() {
       setForkName("Salad Fork");
   }
}

\end{verbatim}
Notice how these classes are all very small compared to the abstract classes they extend.  This is a symptom of modularity and inheritance, and keeps code readable and organized.  The UML for this prototype example follows:\\\\
\includegraphics[width=9cm]{protouml.png}
\newpage
\subsubsection{Singleton}
The Singleton design pattern ensures that a class only has one instance, and provide a global point of access to it.\\\\
For example, the \verb+SingleSpoon+ class holds one instance of \verb+SingleSpoon in private static SingleSpoon theSpoon;+. The \verb+SingleSpoon+ class determines the spoons availability using \verb+private static boolean theSpoonIsAvailable = true;+. The first time \verb+SingleSpoon.getTheSpoon()+ is called, it creates an instance of a \verb+SingleSpoon+. The \verb+SingleSpoon+ cannot be distributed again until it is returned with \verb+SingleSpoon.returnTheSpoon()+.
\\\\
If a developer were to create a spoon "pool", they would have the same basic logic as shown.  However, multiple spoons would be distributed.  The variable \verb+theSpoon+ would hold an array or collection of spoons.  The variable \verb+theSpoonIsAvaialable+ would become a counter of the number of available spoons.
\\\\
Please also note that this example \textit{is not thread safe}.  To make it thread safe, the \verb+getTheSpoon()+ method should be synchronized.\\\\
Example code is shown below:
\begin{verbatim}

public class SingleSpoon 
{  
   private Soup soupLastUsedWith;
   
   private static SingleSpoon theSpoon;
   private static boolean theSpoonIsAvailable = true;
   
   private SingleSpoon() {}
     
   public static SingleSpoon getTheSpoon() {
       if (theSpoonIsAvailable) {
           if (theSpoon == null) {
               theSpoon = new SingleSpoon();
           }
           theSpoonIsAvailable = false;
           return theSpoon;
       } else {
           return null;
           //spoon not available, 
           //  could throw error or return null (as shown)
       }
   }
    
   public String toString() {
       return "Behold the glorious single spoon!";
   }
    
   public static void returnTheSpoon() {
       theSpoon.cleanSpoon();
       theSpoonIsAvailable = true;
   }     
   
   public Soup getSoupLastUsedWith() {
       return this.soupLastUsedWith;
   }
   public void setSoupLastUsedWith(Soup soup) {
       this.soupLastUsedWith = soup;
   }

   public void cleanSpoon() {
       this.setSoupLastUsedWith(null);
   }   
}

\end{verbatim}
The UML diagram for this example is featured below:\\\\
\includegraphics[width=\textwidth]{singleuml.png}
\newpage
\subsection{Structural Patterns}
\subsubsection{Adapter}
With the Adapter design pattern, developers convert the interface of a class into another interface clients expect.  An adapter lets classes work together that otherwise could not because of incompatible interfaces.\\\\
For example, the \verb+TeaBall+ class takes in an instance of \verb+LooseLeafTea+. The \verb+TeaBall+ class uses the \verb+steepTea+ method from \verb+LooseLeafTea+ and adapts it to provide the \verb+steepTeaInCup+ method which the \verb+TeaCup+ class requires. See \verb+TeaBag.java+ below:
\begin{verbatim}

public class TeaBag {  
   boolean teaBagIsSteeped; 
    
   public TeaBag() {
       teaBagIsSteeped = false;
   }
   
   public void steepTeaInCup() {
       teaBagIsSteeped = true;
       System.out.println("tea bag is steeping in cup");
   }
}

\end{verbatim}
Next, we have the adapter object, that creates an interface for the adaptee to use.  See \verb+TeaBall.java+ below:
\begin{verbatim}

public class TeaBall extends TeaBag {  
   LooseLeafTea looseLeafTea;
   
   public TeaBall(LooseLeafTea looseLeafTeaIn) {
       looseLeafTea = looseLeafTeaIn;
       teaBagIsSteeped = looseLeafTea.teaIsSteeped;
   }
    
   public void steepTeaInCup() {
       looseLeafTea.steepTea();
       teaBagIsSteeped = true;
   }
}

\end{verbatim}
Code for the adaptee object, \verb+LooseLeafTea.java+, is below:
\begin{verbatim}

public class LooseLeafTea {  
   boolean teaIsSteeped; 
    
   public LooseLeafTea() {
       teaIsSteeped = false;
   }
   
   public void steepTea() {
       teaIsSteeped = true;
       System.out.println("tea is steeping");
   }
}

\end{verbatim}
Finally, the \verb+TeaCup.java+ class accepts the adapter and adaptee to allow users to steep tea bags, as well as tea balls, is featured below:
\begin{verbatim}

public class TeaCup {  
   public void steepTeaBag(TeaBag teaBag) {
       teaBag.steepTeaInCup();
   }
}
\end{verbatim}
Notice again how the root class is uncomplicated, and has exactly as many extensions as the functionality requires.  The Singleton pattern thusly shows the root of why we use design patterns: they make life easier.  The UML diagram for this example is shown below:
\includegraphics[width=9cm]{adapteruml.png}
\newpage
\subsubsection{Bridge}
The Bridge Pattern decouples an abstraction from its implementation, so that the two can vary independently.  The UML diagram below illustrates the Bridge structure well:\\\\
\includegraphics[width=\textwidth]{bridgeuml.png}\\\\
Notice how the abstract soda class and the actual soda implementation are distinctly separated.  The code abstract \verb+Soda.java+ class, along with its abstract extending classes \verb+MediumSoda.java+ and \verb+SuperSizeSoda.java+, is featured below:
\begin{verbatim}

public abstract class Soda {  
   SodaImp sodaImp; 
   
   public void setSodaImp() {
       this.sodaImp = SodaImpSingleton.getTheSodaImp();
   }
   public SodaImp getSodaImp() {
       return this.sodaImp;
   }
   
   public abstract void pourSoda();
}

public class MediumSoda extends Soda {  
   public MediumSoda() {
       setSodaImp();
   }
   
   public void pourSoda() {
       SodaImp sodaImp = this.getSodaImp();
       for (int i = 0; i < 2; i++) {
           System.out.print("...glug...");
           sodaImp.pourSodaImp();
       }
       System.out.println(" ");
   }
}

public class SuperSizeSoda extends Soda {  
   public SuperSizeSoda() {
       setSodaImp();
   }
   
   public void pourSoda() {
       SodaImp sodaImp = this.getSodaImp();
       for (int i = 0; i < 5; i++) {
           System.out.print("...glug...");
           sodaImp.pourSodaImp();
       }
       System.out.println(" ");       
   }
}
\end{verbatim}
The very small \verb+SodaImp.java+ class connects these abstract classes to a concrete object, and \verb+CherrySodaImp.java+, \verb+GrapeSodaImp.java+, \verb+OrangeSodaImp.java+ all extend the concrete "bridge" so there are several different, fleshed out, compatible objects to work with.  There is also an additional Singleton class \verb+SodaImpSingleton.java+ to keep all instances clear:
\begin{verbatim}

public abstract class SodaImp {  
   public abstract void pourSodaImp();
}

public class CherrySodaImp extends SodaImp {
   CherrySodaImp() {}
    
   public void pourSodaImp() {
       System.out.println("Yummy Cherry Soda!");
   }
}

public class GrapeSodaImp extends SodaImp {
   GrapeSodaImp() {}
    
   public void pourSodaImp() {
       System.out.println("Delicious Grape Soda!");
   }
}

public class OrangeSodaImp extends SodaImp {  
   OrangeSodaImp() {}
    
   public void pourSodaImp() {
       System.out.println("Citrusy Orange Soda!");
   }
}

public class SodaImpSingleton {  
    private static SodaImp sodaImp;
   
    public SodaImpSingleton(SodaImp sodaImpIn) {
        this.sodaImp = sodaImpIn;
    }
    
    public static SodaImp getTheSodaImp() {
        return sodaImp;
    }
}
\end{verbatim}
\newpage
\subsubsection{Composite}
The Composite design pattern allows developers to compose objects into tree structures to represent part-whole hierarchies.  Composite lets clients treat individual objects and compositions of objects uniformly by assembling groups of objects with the same signature.  Consider the \verb+TeaBags.java+ example once again, with the composite of all tea bags being \verb+TinOfTeaBags.java+:
\begin{verbatim}

import java.util.LinkedList;
import java.util.ListIterator;

public abstract class TeaBags {  
   LinkedList teaBagList; 
   TeaBags parent;
   String name;
    
   public abstract int countTeaBags();
   
   public abstract boolean add(TeaBags teaBagsToAdd);
   public abstract boolean remove(TeaBags teaBagsToRemove);
   public abstract ListIterator createListIterator();
   
   public void setParent(TeaBags parentIn) {
       parent = parentIn;
   }
   public TeaBags getParent() {
      return parent;
   }
   
   public void setName(String nameIn) {
       name = nameIn;
   }
   public String getName() {
       return name;
   }
}

public class OneTeaBag extends TeaBags { 
    public OneTeaBag(String nameIn) {
        this.setName(nameIn);
    }
    
    public int countTeaBags() {
        return 1;
    }
   
    public boolean add(TeaBags teaBagsToAdd) {
        return false;
    }
    public boolean remove(TeaBags teaBagsToRemove) {
        return false;
    }
    public ListIterator createListIterator() {
        return null;
    }
}

public class TinOfTeaBags extends TeaBags {  
   public TinOfTeaBags(String nameIn) {
       teaBagList = new LinkedList();
       this.setName(nameIn);
   }
   
   public int countTeaBags() {
       int totalTeaBags = 0;
       ListIterator listIterator = this.createListIterator();
       TeaBags tempTeaBags;
       while (listIterator.hasNext()) {
           tempTeaBags = (TeaBags)listIterator.next();
           totalTeaBags += tempTeaBags.countTeaBags();
       }
       return totalTeaBags;
   }
   
   public boolean add(TeaBags teaBagsToAdd) {
       teaBagsToAdd.setParent(this);
       return teaBagList.add(teaBagsToAdd);
   }
   
   public boolean remove(TeaBags teaBagsToRemove) {
       ListIterator listIterator = 
           this.createListIterator();
       TeaBags tempTeaBags;
       while (listIterator.hasNext()) {
           tempTeaBags = (TeaBags)listIterator.next();
           if (tempTeaBags == teaBagsToRemove) {
               listIterator.remove();
               return true;
           }
       }
       return false;
   }
   
   public ListIterator createListIterator() {
       ListIterator listIterator = teaBagList.listIterator();
       return listIterator;
   }
}

\end{verbatim}
The UML diagram for this
\newpage
\subsubsection{Decorator}
Attach additional responsibilities to an object dynamically.  Decorators provide a flexible alternative to subclassing for extending functionality.
\newpage
\subsubsection{Facade}
Provide a unified interface to a set of interfaces in a subsystem.  For example, a facade defines a higher-level interface that makes the subsystem easier to use.
\newpage
\subsubsection{Flyweight}
Use sharing to support large numbers of fine-grained objects efficiently.
\newpage
\subsubsection{Proxy}
Provide a surrogate or placeholder for another object to control access to it.
\newpage
\subsection{Behavioral Patterns}
\subsubsection{Chain of Responsibility}
Avoid coupling the sender of a request to its receiver by giving more than one object a chance to handle the request.  Instead, chain the receiving objects together and pass the request along until an object handles it.
\newpage
\subsubsection{Command Pattern}
Encapsulate a request as an object, letting programmers parameterize clients with different requests, queue or log requests, and support undoable operations.
\newpage
\subsubsection{Interpreter}
Given a language, define a representation for its grammar in addition to an interpreter that uses the representation to interpret sentences in the language.
\newpage
\subsubsection{Iterator}
An iterator provides a way to access the elements of an aggregate object sequentially, without exposing its underlying representation.
\newpage
\subsubsection{Mediator}
A mediator is an object that encapsulates how a set of objects interact.  A mediator promotes loose coupling by keeping objects from explicitly referring to each other, allowing programmers to vary their interaction independently.
\newpage
\subsubsection{Memento}
A program using the memento pattern captures and externalizes an object's internal state so the object can be restored to this state later, without violating encapsulation.
\newpage
\subsubsection{Observer}
An observer defines a one-to-many dependency between objects so that when one object changes state, all of its dependencies are notified and updated automatically.
\newpage
\subsubsection{State}
Programs using the state design pattern empower objects to alter their behavior when their internal states change.  Objects may even appear to change their classes.
\newpage
\subsubsection{Strategy}
Define a family of algorithms, encapsulate each, and make them interchangeable.  Strategy lets the algorithm vary independently from clients that use it.
\newpage
\subsubsection{Template Method}
Define the skeleton of an algorithm in an operation, deferring some steps to subclasses.  The template method lets subclasses redefine specific steps of an algorithm without changing the algorithm's structure.
\newpage
\subsubsection{Visitor}
A visitor represents an operation to be performed on the elements of an object structure.  A visitor lets programmers define new operations without changing the classes and elements of their dependencies.

## Interning Pattern
The interning pattern is not a Gang of Four design pattern.  With the interning pattern, existing objects with the same value are copied, instead of creating new, identical objects.  Unlike the singleton pattern, multiple instances of the same object exist, but objects with the same value are reused where needed.  Additionally, interned objects can be compared with == instead of equals because they are the same object.  Interning may improve program speed!

\includegraphics[width=\textwidth]{interning.png}

Interning applies to immutable objects only.  Thus, Java strings can be interned.  Here is an example of the Interning Pattern:

    HashMap<String,String> names;
    
    String canonicalName(String n) {
        if (names.containsKey(n)) 
            return names.get(n);
        else { 
            names.put(n,n); 
            return n;
        }
    }

Here is the JavaDoc for String.intern(): 

    public String intern()

    Returns a canonical representation for the string object.

    A pool of strings, initially empty, is maintained privately by the class String.

    When the intern method is invoked, if the pool already contains a string equal to this String object as determined by the equals(Object) method, then the string from the pool is returned.  Otherwise, this String object is added to the pool, and a reference to this String object is returned.

    It follows that for any two strings s and t, s.intern() == t.intern() is true if and only if s.equals(t) is true.

    All literal strings and string-valued constant expressions are interned.  String literals are defined in section 3.10.5 of The Java Language Specification.

    Returns:

    a string that has the same contents as this string, but is guaranteed to be
    from a pool of unique strings.

## Unified Modeling Language (UML)
UML class diagrams show classes and their relationships, including inheritance and composition, attributes, and operations.  Additionally, UML sequence diagrams can show the dynamics of a system.  UML is the standard "language" of object-oriented modeling and design.
Here is some UML notation:

- Boxes are classes
- $\bigtriangleup$ on arrows denote inheritance with subclasses pointing to superclasses
- \textit{italics} denote abstract types
- dotted lines between classes denote interface inheritance

\includegraphics[width=\textwidth]{uml1.png}

\includegraphics[width=\textwidth]{uml2.png}

UML associations often represent a composition relationship; objects of one class enclose objects of another.  Thus, UML is often used to model abstract concepts and their relationships.  Attributes and associations correspond to ADT operations.  UML can express designs - there is a close correspondence to implementation.  Attributes and associates correspond to representation fields.

\includegraphics[width=\textwidth]{graphuml.png}

## Wrappers
A wrapper is a thin layer over an encapsulated class that uses composition/delegation to modify its interface - as we did with the GraphWrapper.  Then, the wrapper extends the behavior of the encapsulated class and restricts access to the encapsulated object.  The encapsulated object (delegate) does most work.  The wrapper is not a GoF pattern, but is similar to Adapter and Façade GoF patterns.

## Strategy / Policy Pattern
This pattern defines multiple algorithms and lets client applications pass the algorithm to be used as a parameter.  The strategy pattern reduces coupling by allowing users to program to an interface, rather than an implementation.  Collections.sort is an example.  It takes the Comparator parameter.  Based on the different implementations of Comparator interfaces, the Objects are getting sorted in different ways.  Strategy pattern is very similar to State and Command Patterns.  The strategy pattern is useful when we have multiple algorithms for a specific task.  We want our application to be flexible in choosing any algorithms at runtime for a specific task.

\includegraphics[width=\textwidth]{strategy.png}