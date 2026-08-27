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

---

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
> Compile, Package using - Maven

> Minimum pom.xml
```bash
$ ls
HelloWorld.java  pom.xml

$ cat pom.xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
<modelVersion>4.0.0</modelVersion>

<groupId>guru.springframework</groupId>
<artifactId>hello-world</artifactId>
<version>0.0.1-SNAPSHOT</version>

<properties>
  <java.version>21</java.version>
</properties>


</project>

```
> maven version
```bash
$ mvn --version
Apache Maven 3.9.16 (2bdd9fddda4b155ebf8000e807eb73fd829a51d5)
Maven home: /opt/apache-maven-3.9.16
Java version: 21.0.12.1, vendor: Red Hat, Inc., runtime: /usr/lib/jvm/java-21-openjdk-21.0.12.1.1-1.2.0.1.el9.x86_64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "6.6.87.2-microsoft-standard-wsl2", arch: "amd64", family: "unix"
```
> maven clean - Cleans the maven environment
```bash
$ mvn clean
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------< guru.springframework:hello-world >------------------
[INFO] Building hello-world 0.0.1-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- clean:3.2.0:clean (default-clean) @ hello-world ---
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.234 s
[INFO] Finished at: 2026-08-27T09:47:53+05:30
[INFO] ------------------------------------------------------------------------
```
> maven package - Builds a jar 
```bash
$ mvn package
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------< guru.springframework:hello-world >------------------
[INFO] Building hello-world 0.0.1-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- resources:3.4.0:resources (default-resources) @ hello-world ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /home/nagaantarvedi/maven/pom/src/main/resources
[INFO]
[INFO] --- compiler:3.15.0:compile (default-compile) @ hello-world ---
[INFO] No sources to compile
[INFO]
[INFO] --- resources:3.4.0:testResources (default-testResources) @ hello-world ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /home/nagaantarvedi/maven/pom/src/test/resources
[INFO]
[INFO] --- compiler:3.15.0:testCompile (default-testCompile) @ hello-world ---
[INFO] No sources to compile
[INFO]
[INFO] --- surefire:3.5.4:test (default-test) @ hello-world ---
[INFO] No tests to run.
[INFO]
[INFO] --- jar:3.5.0:jar (default-jar) @ hello-world ---
[WARNING] JAR will be empty - no content was marked for inclusion!
[INFO] Building jar: /home/nagaantarvedi/maven/pom/target/hello-world-0.0.1-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.815 s
[INFO] Finished at: 2026-08-27T09:51:25+05:30
[INFO] ------------------------------------------------------------------------


$ ls
HelloWorld.java  pom.xml  target
$ cd target
$ ls
hello-world-0.0.1-SNAPSHOT.jar  maven-archiver
$ unzip hello-world-0.0.1-SNAPSHOT.jar
Archive:  hello-world-0.0.1-SNAPSHOT.jar
   creating: META-INF/
  inflating: META-INF/MANIFEST.MF
   creating: META-INF/maven/
   creating: META-INF/maven/guru.springframework/
   creating: META-INF/maven/guru.springframework/hello-world/
  inflating: META-INF/maven/guru.springframework/hello-world/pom.xml
  inflating: META-INF/maven/guru.springframework/hello-world/pom.properties
$ cat META-INF/MANIFEST.MF
Manifest-Version: 1.0
Created-By: Maven JAR Plugin 3.5.0
Build-Jdk-Spec: 21

$ cd ..
$ ls
HelloWorld.java  pom.xml  target

$ mvn clean
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------< guru.springframework:hello-world >------------------
[INFO] Building hello-world 0.0.1-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- clean:3.2.0:clean (default-clean) @ hello-world ---
[INFO] Deleting /home/nagaantarvedi/maven/pom/target
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.220 s
[INFO] Finished at: 2026-08-27T09:57:51+05:30
[INFO] ------------------------------------------------------------------------

$ ls
HelloWorld.java  pom.xml   <-- target directory is deleted

```

> Java Source Files
```bash
$ ls
HelloWorld.java  pom.xml
$ mkdir -v -p src/main/java
mkdir: created directory 'src'
mkdir: created directory 'src/main'
mkdir: created directory 'src/main/java'
$ ls
HelloWorld.java  pom.xml  src

$ mv HelloWorld.java src/main/java/
$ ls
pom.xml  src

$ cd src/main/java/
$ ls
HelloWorld.java

$ cd ../../..
$ ls
pom.xml  src

$ mvn clean package
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------< guru.springframework:hello-world >------------------
[INFO] Building hello-world 0.0.1-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- clean:3.2.0:clean (default-clean) @ hello-world ---
[INFO]
[INFO] --- resources:3.4.0:resources (default-resources) @ hello-world ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /home/nagaantarvedi/maven/pom/src/main/resources
[INFO]
[INFO] --- compiler:3.15.0:compile (default-compile) @ hello-world ---
[INFO] Recompiling the module because of changed source code.
[WARNING] File encoding has not been set, using platform encoding UTF-8, i.e. build is platform dependent!
[INFO] Compiling 1 source file with javac [debug target 1.8] to target/classes
[WARNING] bootstrap class path not set in conjunction with -source 8
[WARNING] source value 8 is obsolete and will be removed in a future release
[WARNING] target value 8 is obsolete and will be removed in a future release
[WARNING] To suppress warnings about obsolete options, use -Xlint:-options.
[INFO]
[INFO] --- resources:3.4.0:testResources (default-testResources) @ hello-world ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /home/nagaantarvedi/maven/pom/src/test/resources
[INFO]
[INFO] --- compiler:3.15.0:testCompile (default-testCompile) @ hello-world ---
[INFO] No sources to compile
[INFO]
[INFO] --- surefire:3.5.4:test (default-test) @ hello-world ---
[INFO] No tests to run.
[INFO]
[INFO] --- jar:3.5.0:jar (default-jar) @ hello-world ---
[INFO] Building jar: /home/nagaantarvedi/maven/pom/target/hello-world-0.0.1-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.469 s
[INFO] Finished at: 2026-08-27T10:06:41+05:30
[INFO] ------------------------------------------------------------------------

]$ ls
pom.xml  src  target

$ cd target
$ ls
classes  generated-sources  hello-world-0.0.1-SNAPSHOT.jar  maven-archiver  maven-status
$ ls classes/
HelloWorld.class
$ unzip hello-world-0.0.1-SNAPSHOT.jar
Archive:  hello-world-0.0.1-SNAPSHOT.jar
   creating: META-INF/
  inflating: META-INF/MANIFEST.MF
   creating: META-INF/maven/
   creating: META-INF/maven/guru.springframework/
   creating: META-INF/maven/guru.springframework/hello-world/
  inflating: HelloWorld.class
  inflating: META-INF/maven/guru.springframework/hello-world/pom.xml
  inflating: META-INF/maven/guru.springframework/hello-world/pom.properties
$ cat META-INF/MANIFEST.MF
Manifest-Version: 1.0
Created-By: Maven JAR Plugin 3.5.0
Build-Jdk-Spec: 21

$ cd ../
]$ ls
pom.xml  src  target
]$ mvn clean
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------< guru.springframework:hello-world >------------------
[INFO] Building hello-world 0.0.1-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- clean:3.2.0:clean (default-clean) @ hello-world ---
[INFO] Deleting /home/nagaantarvedi/maven/pom/target
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.210 s
[INFO] Finished at: 2026-08-27T10:16:27+05:30
[INFO] ------------------------------------------------------------------------

$ ls
pom.xml  src

$ tree .
.
├── pom.xml
└── src
    └── main
        └── java
            └── HelloWorld.java

3 directories, 2 files
```