# Gotchas & Lessons Learned

Things that went wrong, why, and how I fixed them.

---

## Setting up WSL, Git & SSH

**`wsl --install` said "distribution already exists"**
- Why: Ubuntu was already installed from before.
- Fix: nothing to install. Just open Ubuntu from the Start menu.

**`wsl -u root` → "command not found"**
- Why: I ran it inside Ubuntu. `wsl` is a Windows command.
- Fix: run Windows commands in PowerShell (`PS C:\>`) and Linux commands in Ubuntu (`user@laptop:~$`).

**SSH key didn't save because I typed a path with the wrong case**
- Why: Linux is **case-sensitive**, so `/home/Abdia` and `/home/abdia` are different paths, and the one I typed didn't exist.
- Fix: press Enter at the prompt to accept the default path. Use `~` for home so the case never matters.

**Typed `Github` at the ssh-keygen file prompt**
- Why: the prompt asks for a *file path*, not a name. It saved the key as a file called `Github` in whatever folder I was in (system32).
- Fix: `cd ~` first, rerun, and press Enter to keep the default `~/.ssh/id_ed25519`.

**Ubuntu opened in `/mnt/c/WINDOWS/system32`**
- Why: I launched it by typing `wsl` in PowerShell, which was sitting in system32.
- Fix: open Ubuntu from the Start menu, or `cd ~` straight away.

**Ctrl+C doesn't copy in the terminal**
- Why: Ctrl+C cancels the running command in Linux.
- Fix: use Ctrl+Shift+C / Ctrl+Shift+V.
