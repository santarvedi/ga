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
>| **Env Variable** |**Context Variable**|**Purpose**|
>| :--- | :--- | :--- |
>|$GITHUB_WORKSPACE|${{ github.workspace }}|Repository working directory on the runner|
>|$GITHUB_REPOSITORY|${{ github.repository }}|Repository name, such as owner/repo|
>|$GITHUB_REF|${{ github.ref}}|Branch or tag reference|
>|$GITHUB_REF_NAME|${{ github.ref_name}}|Short branch or tag name|
>|$GITHUB_SHA|${{ github.sha}}|Commit SHA that triggered the workflow|
>|$GITHUB_RUN_ID|${{ github.run_id}}|Unique workflow run ID|
>|$GITHUB_RUN_NUMBER|${{ github.run_number}}|Run number within the repository|
>|$GITHUB_ACTOR|${{ github.actor}}|User or actor who initiated the run|
>|$GITHUB_EVENT_NAME|${{ github.event_name}}|Trigger event, such as push|
>|$GITHUB_ENV|${{ github.env}}|File used to export variables to subsequent steps|
>|$RUNNER_NAME|${{ runner.name}}|Name of the runner|
>|$RUNNER_OS|${{ runner.os}}|Runner OS: Linux, Windows, or macOS|
>|$RUNNER_ARCH|${{ runner.arch}}|Runner architecture, such as X64 or ARM64|
>|$RUNNER_TEMP|${{ runner.temp}}|Temporary directory on the runner|
>|$CI||Usually true in GitHub Actions|
>
>
>
> 
>| **Variable** | **Example** |
>| :--- | :--- |
>|$GITHUB_WORKSPACE|`/home/nagaantarvedi/actions-runner/_work/ga/ga`|
>|$GITHUB_REPOSITORY|`santarvedi/ga`|
>|$GITHUB_REF|`refs/heads/main`|
>|$GITHUB_REF_NAME|`main`|
>|$GITHUB_SHA|`12f12da747d023dbbf4e80853d5d0dfd1ae267c0`|
>|$GITHUB_RUN_ID|`40661180406`|
>|$GITHUB_RUN_NUMBER|`5`|
>|$GITHUB_ACTOR|`santarvedi`|
>|$GITHUB_EVENT_NAME|`workflow_dispatch`|
>|$GITHUB_ENV|`/home/nagaantarvedi/actions-runner/_work/_temp/_runner_file_commands/set_env_687205b9-d462-426e-a774-c3ce0273bc79`|
>|$RUNNER_NAME|`Nantarvedi-LT`|
>|$RUNNER_OS|`Linux`|
>|$RUNNER_ARCH|`X64`|
>|$RUNNER_TEMP|`/home/nagaantarvedi/actions-runner/_work/_temp`|
>|$CI|`true`|
>
>
> These are environment variables available inside the runner's job, not permanent variables on the machine
>
> ---
>
> **4. Context variables:** `${{ github.* }}, ${{ runner.* }}, ${{ vars.* }}`
>
> GitHub Actions also has contexts. These are especially useful in YAML fields that GitHub evaluates before executing a shell command.
> 
>| **Context** | **Examples** |
>| :--- | :--- |
>|`github`|${{ github.repository }}, ${{ github.ref_name }}, ${{ github.sha }}|
>|`runner`|${{ runner.os }}, ${{ runner.arch }}, ${{ runner.name }}|
>|`vars`|${{ vars.DOCKER_REGISTRY }}|
>|`secrets`|${{ secrets.NUGET_API_KEY }}|
>|`env`|${{ env.APP_NAME }}|
>|`steps`|${{ steps.build.outputs.version }}|
>|`needs`|${{ needs.build.outputs.version }}|
>|`matrix`|${{ matrix.dotnet-version }}|
>|`inputs`|${{ inputs.environment }}-|
>
> For example, suppose you want to run a deployment step only on `main`:
>```yaml
>- name: Deploy
>  if: ${{ github.ref == 'refs/heads/main' }}
>  run: echo "Deploying to main"
>```
>Why use `github.ref` instead of `$GITHUB_REF` here? The `if:` condition is evaluated by GitHub Actions before the step runs on the runner. The context is appropriate for that stage.
>
> You can also use contexts in a `run` step:
>
>```yaml
>- name: Show branch
>  run: echo "Branch is ${{ github.ref_name }}"
>```
>
> However, for shell commands, using `$GITHUB_REF_NAME` is often simpler. Be careful when interpolating untrusted event data directly into shell scripts.
>
> ---
>
> **5. Repository and organization variables using `vars`**
>
> Suppose your repository has a configuration variable named `AWS_REGION` defined in ***Settings → Secrets and variables → Actions → Variables**.
>
> You can access it in YAML like this:
>
> ```yaml
>env:
>  AWS_REGION: ${{ vars.AWS_REGION }}
>
>jobs:
>  build:
>    runs-on: self-hosted
>    steps:
>      - name: Show region
>        run: echo "Region is $AWS_REGION"
>```
>
> Use `vars` for ordinary configuration such as region names, registry URLs, and environment names. Use `secrets` for credentials, tokens, passwords, and other sensitive values. Variables are not automatically masked in logs
>
> ---
>
> **6. Setting an environment variable dynamically on the runner**
>
> This is one of the most important concepts.
>
> Suppose Step 1 calculates a version, and Step 2 needs to use it. A normal shell assignment does not persist into another step. Use the special file `$GITHUB_ENV` instead
>
>```yaml
>steps:
>  - name: Calculate version
>    run: |
>      VERSION="1.2.5"
>      echo "APP_VERSION=$VERSION" >> "$GITHUB_ENV"
>
>  - name: Use version
>    run: |
>      echo "Application version: $APP_VERSION"
>      dotnet build -p:Version="$APP_VERSION"
>```
>
> Output in the second step:
>```text
>Application version: 1.2.5
>```
>
> Important rules:
> - The variable becomes available to subsequent steps in the same job.
> - It is not available in the step that writes it.
> - It does not automatically carry over to another job.
> - It does not permanently modify the runner machine's environment.
>
> What if you use `export` instead?
> 
>```yaml
> - name: Step 1
>   run: |
>     export DB_VERSION="1.2.5"
>     echo "$DB_VERSION"
>
> - name: Step 2
>   run: |
>     echo "$DB_VERSION"
>```
>
> Step 2 will not normally receive the value from Step 1. Each `run` step starts a separate shell process.
>
> ---
>
> **$GITHUB_OUTPUT**
>
> `$GITHUB_OUTPUT` is the **standard environment file used in GitHub Actions to set step output parameters**. It replaces the older, deprecated `::set-output` syntax.
>
> When you write a key-value pair to this file, it exposes a variable that subsequent steps or jobs can reference
>
> **1. Basic Syntax (Same Job)**
> 
> To set an output in a step, append the data in a `KEY=VALUE` format to the file path stored in the `$GITHUB_OUTPUT` environment variable.
>```yaml
>jobs:
>  build-and-share:
>    runs-on: ubuntu-latest
>    steps:
>      # Step 1: Generate the output (Must have an 'id')
>      - name: Generate random number
>        id: generator
>        run: echo "random_number=42" >> $GITHUB_OUTPUT
>
>      # Step 2: Consume the output in the same job
>      - name: Use the number
>        run: echo "The number was ${{ steps.generator.outputs.random_number }}"
>```
>
> **2. Syntax by Shell / OS**
> 
> Depending on the operating system and runner shell you are using, the exact command syntax changes slightly to handle file redirection:
>
>| **Shell** | **Operating System** |**Syntax**|
>| :--- | :--- | :--- |
>|**Bash**|`Linux` / `macOS` / `Windows`|`echo "key=value" >> $GITHUB_OUTPUT`|
>
>
> **3. Passing Outputs Between Jobs**
>
> Jobs run on completely isolated runners. To pass data from one job to another, you must explicitly declare it at the job level using `jobs.<job_id>.outputs`
> ```yaml
>jobs:
>  job1:
>    runs-on: ubuntu-latest
>    outputs:
>      shared_var: ${{ steps.step1.outputs.my_key }} # Maps step output to job output
>    steps:
>      - id: step1
>        run: echo "my_key=hello-world" >> $GITHUB_OUTPUT
>
>  job2:
>    runs-on: ubuntu-latest
>    needs: job1 # Essential to pull context from job1
>    steps:
>      - name: Read variable from job1
>        run: echo "Received value is ${{ needs.job1.outputs.shared_var }}"
>``` 
>
> ---
>
> **$GITHUB_OUTPUT Vs $GITHUB_ENV**
>
> **The core difference is scope**: Use `$GITHUB_ENV` to share variables between steps **within the same job**, and use `$GITHUB_OUTPUT` when you need to pass data **across different jobs** or out of a reusable action.
>
> While both files allow you to persist data dynamically during a workflow run, they serve completely different parts of the GitHub Actions architecture.
>
> **Key Structural Differences**
>
> 
> 1. **Scope & Visibility**
>
> - `$GITHUB_ENV`: Modifies the operating system's environment variables. Once you write to it, the variable becomes immediately available in all **subsequent steps** of that specific job. It cannot be read by other jobs
> 
> - `$GITHUB_OUTPUT`: Saves data to a runner file that attaches specifically to that step. These parameters are hidden from the OS environment and can only be accessed using GitHub's expression syntax (`${{ steps... }}`). Because they are tied to the step's metadata, they can be elevated to job outputs and sent to completely separate jobs
>
> 2. **Access Syntax**
>
> - `$GITHUB_ENV`: Best accessed directly via the runner's native shell syntax (e.g., `$MY_VAR` in Bash or `$env:MY_VAR` in PowerShell)
> - `$GITHUB_OUTPUT`: Must be accessed using GitHub Actions context interpolation: `${{ steps.<step_id>.outputs.<key_name> }}`
>
> ---
>
> **7. Quick reference: Which syntax should you use?**
>
>| **Shell** | **Operating System** |
>| :--- | :--- |
>|**Need a value throughout a workflow?**|Use top-level `env:`|
>|**Need branch, commit, or repository details?**|Use `$GITHUB_SHA`, `$GITHUB_REF_NAME`, or `${{ github.repository }}`|
>|**Need reusable repository configuration?**|Use `${{ vars.VARIABLE_NAME }}`|
>|**Need credentials?**|Use `${{ secrets.SECRET_NAME }}`.|
>|**Need to pass a calculated variable to the next step?**|Write it to `$GITHUB_ENV`|
>|**Need to pass a calculated variable to the next Job?**|Write it to `GITHUB_OUTPUT`|
>
> ---
>