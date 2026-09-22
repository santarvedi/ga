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
>
> ```bash
> $ git log --oneline
> 101d7ab (HEAD -> master, tag: 1.0.0.106) TFID-1232: group item master slots/UOMs per SKU and select iLPN slot by operation (#112)
> 0f932d8 (tag: 1.0.0.105) TFID-1221: map decant inv-adj expiration epoch and CC reason to WMS (#110)
>39e9be9 (tag: 1.0.0.104) TFID-1213: subscribe IMS cycle-count-complete NATS subject (#109)
>f2be710 (tag: 1.0.0.103) TFID-1078: map stocking_unit for cycle count ESB routes (#108)
> 9bd91ca (tag: 1.0.0.102) TFID-1073: pass wave UOM to OE stocking_unit for GTP pick (#107)
> 2f19de4 (tag: 1.0.0.101) TFID-1147, TFID-1150: fix decant ESB outbound to WMS (#105)
> 39fb179 (tag: 1.0.0.100) TFID-1124: wave download validation and SFTP archive (#104)
> bbe5f6a (tag: 1.0.0.99) Merge pull request #103 from ThermoFisherKY/feature/TFID-1131
> 218fb17 (origin/feature/TFID-1131) TFID-1131: Split Item Master ADD/UPDATE list before WES MDS item write: code changes
> 4359f6c (tag: 1.0.0.98) Merge pull request #102 from ThermoFisherKY/feature/TFID-1143
> 0412c7b (origin/feature/TFID-1143) TFID-1143 update pick line update stream
> 0b432ad (tag: 1.0.0.97) Merge pull request #101 from ThermoFisherKY/TFID-1068-1
> 9c48244 (origin/TFID-1068-1) TFID-1068 update stocking_unit changes to ESB
> 07326b8 (tag: 1.0.0.96) TFID-1127: consume OE pick line-update for PICKCONFIRM (#100)
> 65cdf46 (tag: 1.0.0.95) Merge pull request #99 from ThermoFisherKY/fix/TFID-1112
> 8b769ba (origin/fix/TFID-1112) TFID-1112: map wave lot to OE lot_number attribute.
> 191987b (tag: 1.0.0.94) Merge pull request #98 from ThermoFisherKY/TFID-1068
> f4253ce (origin/TFID-1068) TFID-1068 add stocking_unit changes to ESB
> 
> $ git tag --points-at 101d7ab                           
> 1.0.0.106
>```