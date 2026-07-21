
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

