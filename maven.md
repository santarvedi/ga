> maven settings.xml
```
the Maven settings.xml file is explicitly designed to define and configure repositories,
profiles, active profiles, and server definitions.
```

```
<servers>: Stores authentication credentials (usernames, passwords, or private keys) for
remote repositories or deployment targets. The id of a server blocks connects directly
to the repository configurations defined elsewhere.

<profiles>: Provides local environment configurations. While pom.xml profiles can contain
heavy build changes, settings.xml profiles are intentionally restricted. They generally only
allow configuring remote artifact repositories, plugin repositories, and custom environment properties

<repositories>: Defined inside a specific <profile> block. This dictates alternate remote locations
from which Maven should download dependencies and plugins.

<activeProfiles>: Lists the identifiers (id) of the profiles that Maven must always activate by default
during every build execution.
```
```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <!-- 1. Server Definitions (Credentials) -->
  <servers>
    <server>
      <id>company-private-repo</id>
      <username>myRepoUser</username>
      <password>mySecurePassword123</password>
    </server>
  </servers>

  <!-- 2. Profiles (Repositories and Properties) -->
  <profiles>
    <profile>
      <id>company-env</id>
      <repositories>
        <repository>
          <id>company-private-repo</id> <!-- Matches the Server ID above -->
          <url>https://company.com</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>false</enabled></snapshots>
        </repository>
      </repositories>
    </profile>
  </profiles>

  <!-- 3. Active Profiles (Always On) -->
  <activeProfiles>
    <activeProfile>company-env</activeProfile>
  </activeProfiles>
  
</settings>
