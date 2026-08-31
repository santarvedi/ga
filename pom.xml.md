> pom.xml
```xml
 <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.6.7</version>
        <relativePath/> <!-- lookup parent from repository -->
 </parent>
```

>relativePath
```
relativePath in a Maven pom.xml tells Maven where to find the parent project's
pom.xml file on your computer's hard drive.
```
#### How It Works

```
Default Value:
 If you do not write a <relativePath> tag, Maven automatically looks one folder up at ../pom.xml.

Search Order: Maven searches the given relative path first. If it fails to find it there,
 it checks your local .m2 repository, and finally looks in remote repositories.

Custom Path: You can point to a different folder if your project files are laid out differently,
 like <relativePath>subfolder/pom.xml</relativePath>
```

##### Common Uses

```
Custom Location: Point to an exact file path when your parent POM is in a non-standard folder.

Disable Local Search (<relativePath/>): An empty tag tells Maven to skip the local file system
 check completely and grab the parent POM straight from your local or remote repository. This is
 helpful when your parent and child projects are not stored together in the same folder structure
```

##### Examples
> Root project
```xml
<parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.6.7</version>
        <relativePath/> <!-- lookup parent from repository -->
</parent>
```
> Child project
```xml
<parent>
        <groupId>com.fortna.esb</groupId>
        <artifactId>thermofisher-esb-parent</artifactId>
        <version>${revision}</version>
</parent>
```

```
Root project  - parent pom - fetch from repositories
Child project - parent pom - looks one folder up at ../pom.xml 
```

---

#### Maven coordinates

```
Maven coordinates are a unique set of identifiers known as GAV that pinpoint
 a specific project, plugin, or dependency in a repository. They consist of
 three core elements: groupId, artifactId, and version, often supplemented by
 optional packaging and classifier attributes
```

##### Core Components (GAV)

```
- groupId: 
Uniquely identifies the project group or organization, usually following
 reverse domain name notation (e.g., org.apache.maven)

- artifactId:
The unique name of the specific project or library module (e.g., maven-core).

- version
version: The exact release or snapshot version of the artifact (e.g., 3.9.9)
```

##### Optional Components

```
- packaging: 
The file type or format, such as jar, war, or pom (defaults to jar).

- classifier:
 Distinguishes secondary builds of the same artifact, such as -sources or -javadoc
```

###### Example
```xml
<dependency>
    <groupId>org.apache.maven</groupId>
    <artifactId>maven-artifact</artifactId>
    <version>3.9.13</version>
</dendency>
```

---

#### packaging

```
The <packaging> element in a Maven pom.xml file defines the type of artifact
 that Maven will generate when you build the project

If you do not explicitly declare a <packaging> element, Maven defaults to jar
```

##### Core Packaging Types

```
Maven provides several built-in packaging types:

- jar (Java Archive): The standard default format for compiling Java libraries,
  console programs, or standard desktop applications into a .jar file

- pom: Indicates that the project does not produce an executable binary file.
  Instead, it is used for parent POMs, multi-module aggregators, or
  to create Bill of Materials (BOM) files to manage dependencies

- war (Web Application Archive): Packages your project into a .war file

- ear (Enterprise Archive): Bundles multiple modules (like JARs and WARs)
  together into a single .ear archive

- maven-plugin: Used specifically when you are developing your own custom Maven plugin

- ejb: Generates a package optimized for Enterprise JavaBeans modules
```

###### Example

```
To specify how your application should build, declare the element right below
 your project coordinates (Group, Artifact, Version):
```
```xml
<project xmlns="http://apache.org" ...>
    <groupId>com.example</groupId>
    <artifactId>my-web-app</artifactId>
    <version>1.0.0</version>
    
    <!-- Packages this project as a web archive -->
    <packaging>war</packaging> 
</project>
```
---

#### Modules

```
Modules in a Maven POM are used to define a multi-module project (also known as an aggregator project).
 This configuration allows you to split a large codebase into smaller, reusable, and manageable
 sub-projects (child modules) that can be built together using a single command
```

##### The <modules> Element Syntax
```
In the parent or aggregator pom.xml, the <modules> block lists the relative paths to the subdirectories
 containing the child modules:
```
```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>my-parent-project</artifactId>
    <version>1.0.0</version>
    
    <!-- 1. The parent must use 'pom' packaging -->
    <packaging>pom</packaging>

    <!-- 2. List the relative directory paths of child modules -->
    <modules>
        <module>my-core-module</module>
        <module>my-web-module</module>
        <module>my-util-module</module>
    </modules>
</project>

```

##### Key Requirements

```
- Parent Packaging: The aggregator pom.xml must have its <packaging> set to pom.
                    It does not contain source code itself; it only orchestrates the build.

-   Relative Paths: The value inside the <module> tag is the name of the folder containing
                    the sub-project, relative to the parent directory.

- Child References: Each child module's pom.xml should include a <parent> block pointing back
                    to the parent coordinates (groupId, artifactId, version) to inherit
                    configurations and dependencies          
```

##### Why Use Maven Modules?
```
 - Centralized Dependency Management: Define third-party library versions in the parent POM
   using <dependencyManagement> so all sub-modules automatically inherit the same versions

 - Code Reusability: Separate your project into logical layers (e.g., core, api, ui). For instance,
   the ui module can simply declare the core module as a dependency.

 - Single Command Execution: Running mvn clean install on the parent directory automatically triggers
   the lifecycle for all nested child modules
```
---

#### Dependency

```
In a Maven project, a dependency is an external Java library or framework (like Spring, JUnit,
 or Apache Commons) that your project needs to compile, test, or run. You declare these inside
 the pom.xml file so that Maven can automatically download, manage, and add them to your project's
 classpath
```

> 1. Basic Structure
```
All individual dependencies must be placed inside a parent <dependencies> tag. Each dependency
 is uniquely identified by its "coordinates": groupId, artifactId, and version
```
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" ...>
    <!-- Other configuration tags -->

    <dependencies>
        <!-- Example: Adding Apache Commons Lang -->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.14.0</version>
            <scope>compile</scope> <!-- Optional: defaults to compile -->
        </dependency>
    </dependencies>

</project>

```

> 2. Core Coordinates Explained
```
- <groupId>: The organization or package name that created the library (e.g., org.junit.jupiter).
- <artifactId>: The unique name of the specific project/JAR module (e.g., junit-jupiter-api).
- <version>: The specific release version you want to use (e.g., 5.10.2).
```

> 3. Dependency Scopes
```
The <scope> tag tells Maven when and where the library should be available

- compile: Default scope.
           Available everywhere (compile, test, and execution).
           Core application libraries (e.g., Log4j, Jackson).

- test   : Only available during compilation and execution of test classes.
           Testing frameworks (e.g., JUnit, Mockito)

- provided: Used for compilation/test but expected to be provided by the runtime environment
           (like Tomcat)
            Servlet APIs or server-runtime frameworks.

- runtime: Not needed to compile the code, but required to run it.
           Database drivers (e.g., MySQL or PostgreSQL drivers).

- system: Loaded from a hardcoded local file path instead of a repository (discouraged).
          Legacy/proprietary local .jar files.

```

> 4. Direct vs. Transitive Dependencies
```
- Direct Dependencies: Libraries you explicitly declare in your pom.xml.
- Transitive Dependencies: Libraries that your direct dependencies rely on. Maven handles these
  automatically,so if you import Library A, and Library A requires Library B, Maven fetches both
```

> 5. Excluding Transitive Dependencies
```
If a transitive dependency causes a conflict, you can block it using the <exclusions> tag:
```
```xml
<dependency>
    <groupId>org.example</groupId>
    <artifactId>some-library</artifactId>
    <version>1.0.0</version>
    <exclusions>
        <exclusion>
            <groupId>org.unwanted</groupId>
            <artifactId>conflicting-jar</artifactId>
        </exclusion>
    </exclusions>
</dependency>

```
---

#### dependencyManagement

```
The primary use of the <dependencyManagement> section in a Maven pom.xml file is centralized
 version control and configuration for project dependencies

 Unlike the standard <dependencies> block, declaring an artifact inside <dependencyManagement>
  does not actually add the library to your project's classpath. Instead,
  it acts as a lookup table or blueprint
```

##### Key Benifits

```
Version Consistency: It defines a single source of truth for library versions across multi-module
 projects. Every child module inheriting from this POM will automatically use the specified version
 without needing to explicitly state it

Cleaner Child POMs: Because the versions, exclusions, and scopes are managed centrally, child modules
 only need to specify the groupId and artifactId to pull in a dependency

Transitive Dependency Control: If a library you use relies on a third-party dependency
 (a transitive dependency) that is causing conflicts, you can use <dependencyManagement>
  to force Maven to use a specific, compatible version of that background library

BOM (Bill of Materials) Imports: It allows you to import third-party dependency ecosystems
 (like Spring Boot or AWS SDK) as a BOM using the import scope, ensuring all framework components
 remain perfectly compatible

```

##### How It Works (Example)

> 1. Defined in the Parent POM:
```
You declare the version details centrally inside <dependencyManagement>
```
```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.14.0</version>
        </dependency>
    </dependencies>
</dependencyManagement>
```

> 2. Used in the Child POM:
```
The child module explicitly pulls in the dependency, but omits the version.
 Maven matches the groupId and artifactId against the parent's lookup table and
automatically applies version 3.14.0
```
```xml
<dependencies>
    <dependency>
        <groupId>org.apache.commons</groupId>
        <artifactId>commons-lang3</artifactId>
        <!-- No version tag needed here! -->
    </dependency>
</dependencies>
```
---