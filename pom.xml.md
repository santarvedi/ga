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
> In Root project  - parent pom - fetch from repositories
> in Child project - parent pom - looks one folder up at ../pom.xml 