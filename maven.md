#### Apache Maven standard directory layout

```
The Apache Maven standard directory layout is a predefined, rigid folder structure
 that ensures consistency across all Maven projects. By adhering to this layout,
 Maven automatically locates source code, resources, and tests without requiring
 manual path configuration
```

##### Core Project Structure

```
At the root level of any Maven project, there is a pom.xml configuration file and a src directory.
A typical project looks like this:
```
```text
my-project/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   ├── resources/
│   │   └── webapp/
│   └── test/
│       ├── java/
│       └── resources/
└── target/

```