# Linux Cheat Sheet

Quick reference, following the CoderCo Linux section. One line per command. Detail lives in [gotchas.md](./gotchas.md).

---

## Navigating
| Command | What it does |
|---------|--------------|
| `pwd` | Show current folder |
| `ls` / `ls -la` | List contents / with details + hidden files |
| `cd folder` | Move into folder |
| `cd ..` | Up one level |
| `cd ~` or `cd` | Go to home folder |
| `cd -` | Go back to previous folder |

## Creating & reading files
| Command | What it does |
|---------|--------------|
| `touch file.txt` | Create empty file (or update timestamp) |
| `echo "text"` | Print text |
| `echo "text" > file.txt` | Write to file (**overwrites**) |
| `echo "text" >> file.txt` | Append to file |
| `cat file.txt` | Print whole file |
| `head file.txt` / `head -n 5` | First 10 lines / first 5 |
| `tail file.txt` / `tail -n 5` | Last 10 lines / last 5 |
| `tail -f log.txt` | Follow a file live (great for logs) |

## Searching
| Command | What it does |
|---------|--------------|
| `grep word file.txt` | Find lines containing "word" |
| `grep -i word file` | Ignore case |
| `grep -n word file` | Show line numbers |
| `grep -v word file` | Lines that DON'T match |
| `grep -r word folder/` | Search every file in a folder |
| `cat file \| grep word` | Pipe output into grep |

## Shells, programs & binaries
| Command | What it does |
|---------|--------------|
| `echo $SHELL` | Which shell I'm using |
| `cat /etc/shells` | Shells installed |
| `which ls` | Where a program's binary lives |
| `type cd` | Is it a binary, builtin or alias? |
| `sudo apt install zsh` | Install zsh |
| `chsh -s $(which zsh)` | Make zsh the default shell (log out/in after) |

- **Shell** = the program that reads what I type and runs commands (bash, zsh)
- **Binary** = a compiled program file, usually in `/bin` or `/usr/bin`

## File system directories
| Dir | What's in it |
|-----|--------------|
| `/` | Root: the top of everything |
| `/home` | Users' home folders |
| `/root` | Root user's home |
| `/bin`, `/usr/bin` | Programs/commands |
| `/sbin` | Admin/system programs |
| `/etc` | Config files |
| `/var` | Changing data, e.g. logs in `/var/log` |
| `/tmp` | Temporary files, wiped on reboot |
| `/dev` | Devices (disks etc.) |
| `/proc` | Live info about running processes |
| `/opt` | Optional/third-party software |
| `/mnt`, `/media` | Mounted drives (WSL: Windows C: is `/mnt/c`) |

## File management
| Command | What it does |
|---------|--------------|
| `cp a.txt b.txt` | Copy file |
| `cp -r dir1 dir2` | Copy folder |
| `mv a.txt folder/` | Move file |
| `mv old.txt new.txt` | Rename file |
| `rm file.txt` | Delete file (**no recycle bin**) |
| `rm -i file.txt` | Ask before deleting |
| `mkdir dir` | Create folder |
| `mkdir -p a/b/c` | Create nested folders |
| `rmdir dir` | Delete **empty** folder |
| `rm -r dir` | Delete folder + everything inside |

## Spaces in names
| Command | What it does |
|---------|--------------|
| `cd "My Folder"` | Quotes |
| `cd My\ Folder` | Backslash escapes the space |

Best habit: don't use spaces. Use `my-folder` or `my_folder`.

## Vim
| Key | What it does |
|-----|--------------|
| `vim file.txt` | Open file |
| `i` | Insert mode (start typing) |
| `Esc` | Back to normal mode |
| `:w` / `:q` / `:wq` | Save / quit / save + quit |
| `:q!` | Quit without saving |
| `h j k l` | Left, down, up, right |
| `gg` / `G` | Top / bottom of file |
| `dd` | Delete line |
| `yy` / `p` | Copy line / paste |
| `u` | Undo |
| `/word` | Search (`n` for next) |

## sudo & root
| Command | What it does |
|---------|--------------|
| `sudo command` | Run one command as admin |
| `sudo -i` | Become root (prompt changes to `#`) |
| `exit` | Leave root |
| `whoami` | Which user I am |

⛔ **Never run `sudo rm -rf /`.** It deletes the entire system.

## Users & groups
| Command | What it does |
|---------|--------------|
| `id` | My user ID + groups |
| `sudo useradd -m bob` | Create user with home folder |
| `sudo passwd bob` | Set their password |
| `sudo userdel -r bob` | Delete user + home folder |
| `su - bob` | Switch to that user |
| `cat /etc/passwd` | List all users |
| `groups` | My groups |
| `sudo groupadd devs` | Create group |
| `sudo usermod -aG devs bob` | Add bob to group (**-a or you wipe his other groups**) |
| `cat /etc/group` | List all groups |

## Permissions
Reading `ls -l`: `-rwxr-xr--`

| Part | Meaning |
|------|---------|
| 1st char | `-` file, `d` directory |
| `rwx` | **User** (owner) |
| `r-x` | **Group** |
| `r--` | **Others** |

| Letter | Number | Meaning |
|--------|--------|---------|
| `r` | 4 | Read |
| `w` | 2 | Write |
| `x` | 1 | Execute |

Add them up per group: `rwx`=7, `rw-`=6, `r-x`=5, `r--`=4

| Command | What it does |
|---------|--------------|
| `chmod 755 file` | rwxr-xr-x (scripts, folders) |
| `chmod 644 file` | rw-r--r-- (normal files) |
| `chmod 600 file` | rw------- (private, e.g. SSH keys) |
| `chmod u+x file` | Give user execute |
| `chmod g-w file` | Remove write from group |
| `chmod o=r file` | Others: read only |
| `chmod ug+rw file` | User + group get read/write |
| `sudo chown bob file` | Change owner |
| `sudo chown bob:devs file` | Change owner + group |
| `sudo chown -R bob dir/` | Whole folder |

## Standard streams & redirection
| Stream | Number | What it is |
|--------|--------|------------|
| stdin | 0 | Input |
| stdout | 1 | Normal output |
| stderr | 2 | Error output |

| Syntax | What it does |
|--------|--------------|
| `cmd > file` | stdout to file (overwrite) |
| `cmd >> file` | stdout to file (append) |
| `cmd 2> errors.txt` | Errors only to file |
| `cmd > out.txt 2>&1` | Output + errors to same file |
| `cmd 2> /dev/null` | Throw errors away |
| `cmd < file` | Use file as input |
| `cmd1 \| cmd2` | Pipe output of cmd1 into cmd2 |

## Environment variables
| Command | What it does |
|---------|--------------|
| `env` / `printenv` | Show all variables |
| `echo $HOME` | Show one variable |
| `echo $PATH` | Folders the shell searches for commands |
| `MYVAR=hello` | Set for this shell only |
| `export MYVAR=hello` | Set + pass to programs launched from this shell |
| `unset MYVAR` | Remove it |

To make it permanent, add the `export` line to `~/.bashrc` (bash) or `~/.zshrc` (zsh), then run `source ~/.zshrc`.

## Aliases
| Command | What it does |
|---------|--------------|
| `alias ll='ls -la'` | Create shortcut |
| `alias` | List aliases |
| `unalias ll` | Remove |

These are also temporary unless added to `~/.bashrc` / `~/.zshrc`.

## CLI shortcuts
| Keys | What it does |
|------|--------------|
| `Tab` | Autocomplete (double-tap for options) |
| `↑` / `↓` | Previous commands |
| `Ctrl+R` | Search command history |
| `Ctrl+C` | Cancel running command |
| `Ctrl+L` | Clear screen |
| `Ctrl+A` / `Ctrl+E` | Start / end of line |
| `Ctrl+U` | Delete everything before the cursor |
| `Ctrl+W` | Delete previous word |
| `!!` | Repeat last command (`sudo !!` = rerun as sudo) |
| `history` | Show past commands |
| `Ctrl+Shift+C` / `Ctrl+Shift+V` | Copy / paste in terminal |
