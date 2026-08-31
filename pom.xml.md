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