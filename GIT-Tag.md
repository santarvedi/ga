> \[!NOTE]
> The `git tag` command is used to `create`, `list`, `delete`, or `verify` tags, which `act as permanent, unmovable bookmarks pointing to specific commits in your Git repository's history`. They are most commonly used to mark release points (e.g., `v1.0.0`).
>
> ### Quick Reference Cheat Sheet  
>  
>| Action | Command | Purpose / Notes |
>| :--- | :---: | ---: |
>| List Tags | `git tag` | Lists all local tags in alphabetical order. |
>| Search Tags | `git tag -l "v1.4*"` | Finds tags matching a specific pattern. |
>| Create Annotated Tag | `git tag -a v1.0.0 -m "Release message"` | Recommended for releases.<br> Includes metadata and a message. |
>| Create Lightweight Tag | `git tag v1.0.0-l` | Creates a simple pointer without metadata (private/temporary). |
