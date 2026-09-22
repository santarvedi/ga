> \[!NOTE]
> The `git tag` command is used to `create`, `list`, `delete`, or `verify` tags, which `act as permanent, unmovable bookmarks pointing to specific commits in your Git repository's history`. They are most commonly used to mark release points (e.g., `v1.0.0`).
>
> ### Quick Reference Cheat Sheet  
>  
>
>| Action | Command | Purpose / Notes |
>| :--- | :--- | :--- |
>| List Tags | `git tag` | Lists all local tags in alphabetical order. |
>| List Specific Commit tags|`git tag --points-at 7f3a1b2`|Only tags attached exactly to that specific commit.|
>| Search Tags | `git tag -l "v1.4*"` | Finds tags matching a specific pattern. |
>| Create Annotated Tag | `git tag -a v1.0.0 -m "Release message"` | Recommended for releases.Includes metadata and a message.|
>| Create Lightweight Tag | `git tag v1.0.0-l` | Creates a simple pointer without metadata (private/temporary).|
>|Tag Past Commit|`git tag -a v1.2.0 <commit-hash>`|Places a tag on a specific historical commit.|
>|View Tag Details|`git show v1.0.0`|Displays tag metadata, message, and commit details.|
>|Push One Tag|`git push origin v1.0.0`|Tags are not pushed by default; must be sent explicitly.|
>|Push All Tags|`git push origin --tags`|Pushes all local tags to the remote repository.|
>|Delete Local Tag|`git tag -d v1.0.0`|Removes the tag from your local machine|
>|Delete Remote Tag|`git push origin --delete v1.0.0`|Removes the tag from the remote server|
>
>
> ### Core Concepts
>
> **1. Annotated vs. Lightweight Tags**
>
> + **Annotated Tags (-a):** These are stored as full objects in the Git database. They record the tagger’s name, email, date, and a message. They can also be cryptographically signed using GPG. Always use these for public and official releases
> + **Lightweight Tags:**  These are simply pointers to a specific commit (like a branch that doesn’t move). They don't store extra metadata or messages. Use them for private, quick, or temporary bookmarks.
>
> **2. Checking Out a Tag**
>
> If you want to view the files at a specific tag, you can check it out:
> ```bash
> git checkout v1.0.0
>```
>Note: This puts your repository in a "detached HEAD" state. If you plan to make changes, you should create a new branch from that tag instead
>```bash
> git checkout -b branch-name v1.0.0
>```
>
> **3. git tag --points-at**
>
> The `git tag --points-at` command **lists only the tags that point to a specific commit or Git object**. If no object is provided, it defaults to the `HEAD` **commit** (your current checkout position)
>
> #### Common Use Cases
>
> - Check tags on your current commit:
>```bash
> git tag --points-at
>```
> (Equivalently, you can type git tag --points-at HEAD)
>
> - Check tags on a specific branch or commit hash:
>
>```bash
> git tag --points-at main
> git tag --points-at 7f3a1b2
>```
>
> | Command | What it displays
> | :--- | :--- |
> |`git tag --points-at <commit>`|Only tags attached exactly to that specific commit|
> |`git tag`|Lists every tag in the entire repository history|