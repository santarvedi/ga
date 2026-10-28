> \[!NOTE]
> **GitHub Actions: Environment variables in workflow YAML and on the runner**
> 
> In GitHub Actions, environment variables let you pass configuration between workflow steps, jobs, and programs running on the runner. The important distinction is `where a variable is defined, where it is available, and whether it persists to the next step.`
> 
> Let's break this down with practical YAML examples, including self-hosted Kubernetes runners and .NET builds.
>
> `1. Three types of environment variables`
>
>| **Type** | **Defined using** | **Scope** |
>| :--- | :--- | :--- |
>|Custom environment variables|env:|Workflow,job,step|
>|GitHub-provided variables|github.* , runner.* , vars.*, etc  |Accessed through context in YAML|
>|Runner process environment|export, $GITHUB_ENV|Shell process or subsequent steps|
>
> `2. Custom variables using env:`
> 
> You can define environment variables at three levels.
>```yaml
>name: Build Application
>
>on:
>  push:
>    branches: [main]
>
>env:                         # Workflow level
>  APP_NAME: MyApplication
>  BUILD_MODE: Release
>
>jobs:
>  build:
>    runs-on: self-hosted
>
>    env:                     # Job level
>      DOTNET_VERSION: "8.0"
>
>    steps:
>      - uses: actions/checkout@v4
>
>      - name: Build
>        env:                 # Step level
>          CONFIGURATION: Release
>        run: |
>          echo "App: $APP_NAME"
>          echo "Mode: $BUILD_MODE"
>          echo "SDK: $DOTNET_VERSION"
>          echo "Config: $CONFIGURATION"
>```
>
> **Scope rules:**
> 
> - Workflow-level variables are available to jobs and steps, unless overridden
> - Job-level variables are available to steps within that job.
> - Step-level variables are available only to that step.
> - A narrower scope overrides a broader scope when the variable names match.
> 
> Note that env: variables are environment variables for the step's process. They are not automatically available as `${{ env.APP_NAME }}` on the runner machine outside that step.
>
> `3. GitHub default environment variables`
>
> GitHub automatically provides many variables to every workflow step. You do not need to define them yourself.
> 
> Here are the ones you'll use most often:
> 
>| **Variable** | **Purpose** |**Example**|
>| :--- | :--- | :--- |
>|GITHUB_WORKSPACE|Repository working directory on the runner|`/home/nagaantarvedi/actions-runner/_work/ga/ga`|
>|GITHUB_REPOSITORY|Repository name, such as owner/repo|`santarvedi/ga`|
>|GITHUB_REF|Branch or tag reference|`refs/heads/main`|
>|GITHUB_REF_NAME|Short branch or tag name|`main`|
>|GITHUB_SHA|Commit SHA that triggered the workflow|`12f12da747d023dbbf4e80853d5d0dfd1ae267c0`|
>|GITHUB_RUN_ID|Unique workflow run ID|`40661180406`|
>|GITHUB_RUN_NUMBER|Run number within the repository|`5`|
>|GITHUB_ACTOR|User or actor who initiated the run|`santarvedi`|
>|GITHUB_EVENT_NAME|Trigger event, such as push|`workflow_dispatch`|
>|GITHUB_ENV|File used to export variables to subsequent steps|`/home/nagaantarvedi/actions-runner/_work/_temp/_runner_file_commands/set_env_687205b9-d462-426e-a774-c3ce0273bc79`|
>|RUNNER_NAME|Name of the runner|`Nantarvedi-LT`|
>|RUNNER_OS|Runner OS: Linux, Windows, or macOS|`Linux`|
>|RUNNER_ARCH|Runner architecture, such as X64 or ARM64|`X64`|
>|RUNNER_TEMP|Temporary directory on the runner|`/home/nagaantarvedi/actions-runner/_work/_temp`|
>|CI|Usually true in GitHub Actions|`true`|
>
>
>
> 
>| **Variable** | **Example** |
>| :--- | :--- |
>|GITHUB_WORKSPACE||
>|GITHUB_REPOSITORY||
>|GITHUB_REF||
>|GITHUB_REF_NAME||
>|GITHUB_SHA||
>|GITHUB_RUN_ID||
>|GITHUB_RUN_NUMBER||
>|GITHUB_ACTOR||
>|GITHUB_EVENT_NAME||
>|GITHUB_ENV||
>|RUNNER_NAME||
>|RUNNER_OS||
>|RUNNER_ARCH||
>|RUNNER_TEMP||
>|CI||
>
