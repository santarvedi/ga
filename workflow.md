> \[!NOTE]
>  
> When you clone a repository on a self-hosted runner (typically using the actions/checkout step), the code is checked out inside a specific directory structured under the _work folder within your runner installation directory
>
> ##### The Default Path Structure
>
> `/path/to/actions-runner/_work/<repository-name>/<repository-name>`
>
> For example, if you installed the runner application in /home/ubuntu/actions-runner and your repository is named my-awesome-app, the code will be checked out to:
>
> `/home/ubuntu/actions-runner/_work/my-awesome-app/my-awesome-app/`
>
> ##### How to Reference This Path Dynamically
>
> You do not need to hardcode this path in your scripts. GitHub Actions provides built-in environment variables that automatically point to this location during a job execution:
> + `${{ github.workspace }}` (GitHub Context): Resolves directly to the root directory where your code is checked out (e.g., `_work/my-awesome-app/my-awesome-app`).
> + `$GITHUB_WORKSPACE` (Environment Variable): The OS-level environment variable equivalent that you can use inside your `run:` bash or PowerShell steps.
>
> ##### Customizing the Checkout Location
>
>If you prefer the code to be placed somewhere else (for instance, if you are running concurrent jobs or need a cleaner directory structure), you can customize it using the path parameter in the checkout action:
> ```yaml
> - name: Checkout code
>   uses: actions/checkout@v4
>   with:
>     path: 'my-custom-folder'
>```
> Resulting location: `/path/to/actions-runner/_work/<repository-name>/my-custom-folder`
>
>  ##### A Critical Difference: ${{ github.workspace }} vs $GITHUB_WORKSPACE
>
```bash
__________________________________________________________________________________
Feature         ${{ github.workspace }}            $GITHUB_WORKSPACE     
                (GitHub Context)                   (Shell Env Var)
___________________________________________________________________________________
Who            GitHub's engine before the          The runner's operating system
evaluates      script is sent to the runner.       shell (bash, cmd, powershell)
it?                                                during execution.
____________________________________________________________________________________
Where to        Anywhere in the YAML               Strictly inside a `run:` block
use it?        ( `with:`, `env:`, `if:`, `name:`)
_____________________________________________________________________________________
Syntax          Always wrapped in ${{ }}            Depends on OS:
                                                    $GITHUB_WORKSPACE (Linux/MacOS)
                                                    $env.GITHUB_WORKSPACE(PowerShell)
______________________________________________________________________________________
```
---