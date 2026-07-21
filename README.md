
>Git
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

- git config --local user.name "Srinivas Antarvedi"
- git config --local user.email "srinivas.antarvedi@gmail.com"

> Global Configuration To edit the global config (applies to all repositories)
- git config --global --edit
```
This opens the ~/.gitconfig file in your default editor (often vi if none is set).
Press `i` to enter insert mode in `vi` editor
Make changes, then press `Esc`, type `:wq,` and hit Enter to save and exit
```

> Local Configuration For repository-specific settings
- git config --edit
```
This edits .git/config inside the current repo
```

- git remote -v
```
origin  https://github.com/santarvedi/ga.git (fetch)
origin  https://github.com/santarvedi/ga.git (push)
```

- Check specific values (Get Values)
```
git config user.name            Srinivas Antarvedi
git config user.email           srinivas.antarvedi@gmail.com

git config --global user.name   Naga Antarvedi
git config --global user.email  nagaantarvedi@fortna.com

Tip: Use --global for all repos, omit it for local changes.

```