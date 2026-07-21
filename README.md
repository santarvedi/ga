
>Git Config
- git config list --local
```
core.repositoryformatversion=0
core.filemode=false
core.bare=false
core.logallrefupdates=true
core.symlinks=false
core.ignorecase=true
remote.origin.url=https://github.com/santarvedi/ga.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
branch.main.vscode-merge-base=origin/main
user.name=Srinivas Antarvedi
user.email=srinivas.antarvedi@gmail.com
```
- git config list --global
```
user.name=Naga Antarvedi
user.email=nagaantarvedi@fortna.com
credential.https://scm.wcs.fortna.com.provider=github
```


###### Global Configuration To edit the global config (applies to all repositories)
- git config --global --edit
```
This opens the ~/.gitconfig file in your default editor (often vi if none is set).
Press `i` to enter insert mode in `vi` editor
Make changes, then press `Esc`, type `:wq,` and hit Enter to save and exit
```

###### Local Configuration For repository-specific settings
- git config --edit
```
This edits .git/config inside the current repo
```

- Check specific values (Get Values)
```
git config user.name            ( Srinivas Antarvedi )
git config user.email           ( srinivas.antarvedi@gmail.com )

git config --global user.name   ( Naga Antarvedi )
git config --global user.email  ( nagaantarvedi@fortna.com )

Tip: Use --global for all repos, omit it for local changes.

```

- Check specific values (Set Values)
```
git config user.name  "Srinivas Antarvedi"
git config user.email  "srinivas.antarvedi@gmail.com"

git config --global user.name "Naga Antarvedi"
git config --global user.email "nagaantarvedi@fortna.com"

Tip: Use --global for all repos, omit it for local changes.

```


>Git Remote
```
Git remote is a command used to manage the set of repositories (remotes) whose branches you track.
It allows you to add, remove, and manage connections to other repositories.
```
- Listing Remotes (To list all the remotes associated with your repository, use)
```
git remote
```

- To list remotes with their URLs, use:
```
git remote -v
```

- Adding a Remote (To add a new remote repository, use:)
```
git remote add <name> <URL>

ex:
git remote add origin https://github.com/user/repo.git
```

- Removing a Remote
```
git remote remove <name>

ex:
git remote remove origin
```

- Renaming a Remote
```
git remote rename <old> <new>

ex:
git remote rename origin upstream
```

- Fetching from a Remote (To fetch updates from a remote repository, use:)
```
git fetch <name>

ex:
git fetch origin
```

- Setting the URL for a Remote (To change the URL of a remote repository, use:)
```
git remote set-url <name> <newurl>

ex:
git remote set-url origin https://github.com/user/newrepo.git
```


> Cheat Sheet
##### Setup & Configuration
```
git config --global user.name "Your Name"        # Set global username
git config --global user.email "you@example.com" # Set global email
git config --list                                # View all configurations
git help                                         # Show help for commands
```

##### Repository Initialization & Cloning
```
git init                               # Initialize a new repository
git clone <repo_url>                   # Clone a remote repository
git clone --branch <branch> <repo_url> # Clone specific branch
```

##### Staging & Committing
```
git add <file>           # Stage a file
git add .                # Stage all changes
git status               # Show working tree status
git diff                 # Show unstaged changes
git commit -m "message"  # Commit staged changes
git commit -am "message" # Stage & commit tracked files
```

##### Branching & Merging
```
git branch             # List branches
git branch <name>      # Create branch
git checkout <name>    # Switch branch
git checkout -b <name> # Create & switch branch
git merge <branch>     # Merge branch into current
```

##### Remote Operations
```
git remote                         # List remotes 
git remote -v                      # list remotes with their URLs
git remote add origin <url>        # Add remote
git remote set-url <name> <newurl> # To change URL of a repository
git fetch                          # Fetch changes
git pull                           # Fetch & merge
git push                           # Push changes
git push -u origin <branch>        # Push & set upstream
```

##### History & Inspection
```
git log                         # Commit history
git log --oneline --graph --all # Compact graph view
git show <commit>               # Show commit details
git blame <file>                # Show last change per line
```

##### Undoing Changes
```
git restore <file>        # Discard changes in file
git reset --soft <commit> # Move HEAD, keep changes staged
git reset --hard <commit> # Reset & discard changes
git revert <commit>       # Create commit to undo changes
```

##### Stashing
```
git stash      # Save uncommitted changes
git stash list # List stashes
git stash pop  # Apply & remove latest stash
```

##### Tags
```
git tag                           # List tags
git tag <tagname>                 # Create lightweight tag
git tag -a <tagname> -m "message" # Annotated tag
git push origin <tagname>         # Push tag
```

##### Advanced Tools
```
git rebase <branch>      # Reapply commits on another base
git reflog               # Show HEAD history
git cherry-pick <commit> # Apply specific commit
```

##### Checkout - Git commit ID
```
Get the commit ID (SHA) that you want to checkout.
From your local repository, you can get the commit SHA from the log

git log
git checkout <commit>

You need to be **very careful with this checkout**. It will be in the **detached HEAD mode**.
Meaning, you can play around with making the changes without impacting any branches.
So if you need to make any actual changes to a specific commit, use a branch checkout
as explained in the next step

git checkout -b <new-branch-name> <commit-id-sha>
```