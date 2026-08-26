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
