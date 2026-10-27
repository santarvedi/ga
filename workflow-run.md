> \[!NOTE]
> **actions job run**
>
> **Setup job**
>
> ```bash
> Current runner version: '2.338.0'
> Runner name: 'Nantarvedi-LT'
> Runner group name: 'Default'
> Machine name: 'Nantarvedi-LT'
> GITHUB_TOKEN Permissions
>  Contents: read
>  Metadata: read
>  Packages: read
> Secret source: Actions
> Cache mode: write
> Prepare workflow directory
> Prepare all required actions
> Getting action download info
> Download action repository 'actions/checkout@v4' (SHA:11d5960a326750d5838078e36cf38b85af677262)
> Complete job name: first-job
> ```
> ---
> **Current runner version: '2.338.0'**
>
> ```bash
>
> total 221220
> -rw-r--r--  1 root root 226430031 Sep 20 07:01 actions-runner-linux-x64-2.337.0.tar.gz
> lrwxrwxrwx  1 root root        46 Oct 27 11:31 bin -> /home/nagaantarvedi/actions-runner/bin.2.338.0
> drwxr-xr-x 17 1001 1001     20480 Aug 26 20:00 bin.2.337.0
> drwxr-xr-x 17 root root     20480 Oct 27 11:31 bin.2.338.0
> -rwxr-xr-x  1 root root      2458 Oct  6 19:21 config.sh
> drwxr-xr-x  4 root root      4096 Oct 27 12:18 _diag
> -rwxr-xr-x  1 root root       646 Oct  6 19:21 env.sh
> lrwxrwxrwx  1 root root        52 Oct 27 11:31 externals -> /home/nagaantarvedi/actions-runner/> externals.2.338.0
> drwxr-xr-x  6 1001 1001      4096 Aug 26 20:00 externals.2.337.0
> drwxr-xr-x  6 root root      4096 Oct 27 11:31 externals.2.338.0
> -rw-r--r--  1 root root      1824 Oct  6 19:21 run-helper.cmd.template
> -rwxr-xr-x  1 root root      2866 Oct 27 11:31 run-helper.sh
> -rwxr-xr-x  1 root root      2866 Oct  6 19:21 run-helper.sh.template
> -rwxr-xr-x  1 root root      2885 Oct  6 19:21 run.sh
> -rwxr-xr-x  1 root root       751 Oct  6 19:21 safe_sleep.sh
> -rwxr-xr-x  1 root root      5220 Sep 20 07:16 svc.sh
> drwxr-xr-x  8 root root      4096 Oct 27 12:18 _work
> [nagaantarvedi@Nantarvedi-LT actions-runner]$
>```
>
> `bin -> /home/nagaantarvedi/actions-runner/bin.2.338.0`  
> `externals -> /home/nagaantarvedi/actions-runner/externals.2.338.0`  
>
> These are `symlinks (symbolic links) used by the GitHub Actions runner to perform seamless, zero-uptime self-updates`
>
> When the GitHub Actions runner updates itself to a new version, it downloads the new binaries into a version-specific folder (like bin.2.338.0) and simply updates the main bin and externals pointers to look at the new directory.
>
> Here is a breakdown of what these specific directories do:
>
> - `bin:` Points to the core executable files and libraries required to run the GitHub Actions runner application itself (the .NET core runtime application).
> - `externals:` Points to third-party tools and dependencies that the runner relies on to execute tasks (such as specific versions of NodeJS, Git, or other built-in utilities).
>
> **How it works behind the scenes**
>
> 1. `The Runner Idle State:` The runner agent listens for jobs using the paths pointing to the current version.
> 2. `The Update Trigger:` When GitHub releases a new runner version, your runner notices this and downloads the new files into a folder appended with the new version number (e.g., bin.2.340.0).
> 3. `The Swap:` To avoid breaking a running job or causing downtime, it changes the symlink (bin -> bin.new.version). This allows older jobs to finish using the old directories while new jobs instantly use the updated ones.
>
> You should not delete or modify these folders or links manually, as doing so will break your self-hosted runner.
>
> ---
> **Runner name: 'Nantarvedi-LT'**
> 
> It is the runner choose by the current job from the list of runners for this repository and the list can be accessed via.
> ```bash
>.
> └── Settings
>     └── Actions
>         └── Runners
> ```
> ---
> ```bash
> Runner name: 'Nantarvedi-LT'
> Runner group name: 'Default'
> Machine name: 'Nantarvedi-LT'
>```
> - `Runner name:` the name you give to the runner.
> - `Machine name:` the Runner machine's hostname
>
> A machine can have multiple runners
> ```bash
> [root@ga-runners actions-runner]# ll
> total 12
> drwxr-xr-x 8 1001 docker 4096 Oct 27 00:39 runner196-01
> drwxr-xr-x 8 1001 docker 4096 Oct 27 00:39 runner196-02
> drwxrwxr-x 6 root root   4096 Jul 30  2024 runner196-07
> [root@ga-runners actions-runner]# hostname
> ga-runners
> [root@ga-runners actions-runner]#
>
> ```
> ---
> 
> **GITHUB_TOKEN Permissions**
> 
> The GITHUB_TOKEN is `an automatically generated, short-lived security token provided by GitHub Actions to authenticate workflow jobs within a repository`. To follow security best practices like the principle of least privilege, you should explicitly define what the token can read or modify.
>
> ##### Setting Token Permissions in YAML
>
> You can configure permissions globally for the entire workflow or granularly for individual jobs. **When you declare the `permissions` block, any scope not explicitly listed is automatically set to `none`** (with the exception of `metadata`, which always keeps `read` access)
>```yml
>
>name: CI Example
>
>on: [push]
>
># Global permissions for all jobs in this workflow
>permissions:
>  contents: read
>  issues: write
>
>jobs:
>  build:
>    runs-down: ubuntu-latest
>    # Job-level permissions (overrides global settings)
>    permissions:
>      contents: write
>      pull-requests: write
>    steps:
>      - uses: actions/checkout@v4
>``` 
>
> #### Available Permission Scopes
>
>Each permission scope can be configured to read, write, or none:
> 
>| **Scope** | **Description** | **Common Use Case** |
>| :--- | :--- | :--- |
>|`actions`|Workflows and workflow runs|Canceling runs or triggering workflows|
>|`checks`|Check runs and check suites|Displaying code analysis results|
>|`contents`|Git commits, branches, releases, and repository files|Pushing code tags or creating draft releases|
>|`deployments`|Deployment histories and states|Managing environment deployments|
>|`id-token`|OpenID Connect (OIDC) tokens|Authenticating securely with cloud providers (AWS, Azure, GCP)|
>|`issues`|Issues and comments|Creating bug reports or adding labels|
>|`packages`|GitHub Packages container/npm registry|Publishing built Docker images or packages|
>|`pages`|GitHub Pages configuration and deployments|Deploying static documentation sites|
>|`pull-requests`|Pull requests, comments, and reviews|Automated PR commenting or closing|
>|`repository-projects`|GitHub projects (classic) boards|Moving project cards or managing workflow tasks|
>|`security-events`|GitHub Code Scanning alerts|Uploading SARIF files from security tools|
>|`statuses`|Commit statuses|Reporting success/failure markers to commits|
>
>
> #### Default Repository Settings
> 
> Repository and Organization administrators can set the fallback behavior when the YAML file does not declare permissions:
> 1. **Read/Write**: The token inherits full write access across all scopes by default. 
> 2. **Read-only**: The token defaults strictly to contents: read and metadata: read
>
> If you need to adjust **repository-wide default settings**, navigate to **Settings → Actions → General → Workflow permissions**. If you are instead looking to manage **Personal Access Tokens (PATs)** for local terminal access or external integrations, those are created under your user profile's **Developer settings**
>
> `GITHUB_TOKEN` **read-only** permissions
>```bash
>Current runner version: '2.338.0'
>Runner name: 'Nantarvedi-LT'
>Runner group name: 'Default'
>Machine name: 'Nantarvedi-LT'
>GITHUB_TOKEN Permissions
>  Contents: read
>  Metadata: read
>  Packages: read
>```
>
> `GITHUB_TOKEN` **read-write** permission
>```bash
>Current runner version: '2.338.0'
>Runner name: 'Nantarvedi-LT'
>Runner group name: 'Default'
>Machine name: 'Nantarvedi-LT'
>GITHUB_TOKEN Permissions
>  Actions: write
>  ArtifactMetadata: write
>  Attestations: write
>  Checks: write
>  CodeQuality: write
>  Contents: write
>  CopilotRequests: write
>  Deployments: write
>  Discussions: write
>  Drives: write
>  Issues: write
>  Metadata: read
>  Models: read
>  Packages: write
>  Pages: write
>  PullRequests: write
>  RepositoryProjects: write
>  SecurityEvents: write
>  Statuses: write
>  VulnerabilityAlerts: read
>```