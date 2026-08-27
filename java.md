> Java Compile
```
Convert java source code into java object code.
javac - java compiler binary
```
> Java Packaging
```
jar - Java ARchive            - Zip file containing 1 or more Java Class files. 
war - Web Application aRchive - Zip file containing web application
                              - includes 1 or more jar files, Java class files,
                                and web resources
ear - Enterprise aRchive      - Zip file containing 1 or more WAR files. 
Fat JAR(aka Ubser JAR)        - Executable jar containing all dependencies
                                (Used by spring boot)
Docker Container              - Docker image containing runtime env, JVM, and
                                Java package. 
```

> Java Class

> 1. Create Jave Code - HelloWorld.java 
```bash
$ cat HelloWorld.java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World !");

    }
}
```
> 2. Compile Java Code
```bash
$ javac HelloWorld.java
$
$ ls
HelloWorld.class HelloWorld.java
$
$ file HelloWorld.class HelloWorld.java
HelloWorld.class: compiled Java class data, version 65.0
HelloWorld.java:  C source, ASCII text
```
> 3. Run Java program
```bash
$ java HelloWorld
Hello World !
```

> Jar

> 1. Create a jar
```bash
$ jar cf ./myjar.jar HelloWorld.class
$
$ ls
HelloWorld.class  HelloWorld.java  myjar.jar
```
> 2. Run a jar
```bash
$ java -classpath ./myjar.jar HelloWorld
Hello World !
```

> 3. Contents of a jar
```bash
$ mkdir temp
$ cp ./myjar.jar temp/
$ cd temp
$ ls
myjar.jar
$ unzip myjar.jar
Archive:  myjar.jar
   creating: META-INF/
  inflating: META-INF/MANIFEST.MF
  inflating: HelloWorld.class
$ ls
HelloWorld.class  META-INF  myjar.jar
$ ls META-INF/
MANIFEST.MF
$  cat META-INF/MANIFEST.MF
Manifest-Version: 1.0
Created-By: 21.0.12.1 (Red Hat, Inc.)
```

> Java 3rd Party Library Inclusion
```
How to build a Java SourceCode with a 3rd party library Included
```

> 1. Modify Java SourceCode to include 3rd party lib
```bash
$ cat HelloWorld.java
import org.apache.commons.lang3.StringUtils;

public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World !");
        System.out.println(StringUtils.capitalize("hello world"));
    }
}
```
> 2. Compile the Java SourceCode
```bash
$ javac -classpath ./commons-lang3-3.20.0/commons-lang3-3.20.0.jar HelloWorld.java
$ 
```

> 3. Throws Errors, if lib location missed
```bash
$ javac HelloWorld.java
HelloWorld.java:1: error: package org.apache.commons.lang3 does not exist
import org.apache.commons.lang3.StringUtils;
                               ^
HelloWorld.java:6: error: cannot find symbol
        System.out.println(StringUtils.capitalize("hello world"));
                           ^
  symbol:   variable StringUtils
  location: class HelloWorld
2 errors
```

> 4. Run the Java Code (Lib in classpath)
```bash
$ java -classpath commons-lang3-3.20.0/commons-lang3-3.20.0.jar:./ HelloWorld
Hello World !
Hello world
```

> 5. Run the Java Code (Lib not in classpath)
```bash
$ java HelloWorld
Hello World !
Exception in thread "main" java.lang.NoClassDefFoundError: org/apache/commons/lang3/StringUtils
        at HelloWorld.main(HelloWorld.java:6)
Caused by: java.lang.ClassNotFoundException: org.apache.commons.lang3.StringUtils
        at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:641)
        at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:188)
        at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:526)
        ... 1 more
```

---