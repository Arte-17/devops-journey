# What OverTheWire Bandit Taught Me (Levels 0–6)

I'm working through [OverTheWire Bandit](https://overthewire.org/wargames/bandit/) to practise Linux. They ask people not to post solutions, so this isn't a walkthrough. It's what I picked up along the way and the mistakes I kept making.

---

## Connecting to a remote server

My first attempt at SSH was `ssh server port: 2220`, which is wrong in two ways. No username meant it used my laptop's, and that's not how you set a port. The pattern is:

```
ssh USER@SERVER -p PORT
```

I also kept forgetting the `ssh` at the start and typing just the address. Linux thinks that's a command and says "command not found".

Every level is a separate user with its own home folder, so you can't see the next user's files until you log in as them. Took me a bit to get my head round that.

## `~` isn't the same as `/home`

`~` is *my* home folder (`/home/bandit1`, for example). `/home` is the folder that holds *everyone's* home folders. I went looking in the wrong one more than once.

## Awkward filenames

This came up a lot, and it's where I learned the most.

- **A name starting with `-`** looks like an option to Linux, the same way `-la` or `--help` do. A lone `-` is even worse, because to `cat` it means "read from the keyboard", so the terminal just hangs. The fix is putting `./` in front, which turns it into a path: "this file, in this folder".
- **Spaces in a name** split it into separate words. The fix is quotes.
- **Both at once?** Use both: `./"name with spaces"`

A normal name like `notes.txt` doesn't need any of this.

## Hidden files

Anything starting with `.` is hidden. A folder can look empty with `ls` and still have files in it. `ls -a` shows everything.

## Working smarter, not one file at a time

A few times I checked files one by one with `cat` until I found the right one. It works, but it's slow, and binary files print garbage all over the screen. There are tools built for this:

- `file ./*` tells you what type every file in a folder is (text, binary, etc.)
- `find` searches every folder and subfolder at once by type, size, permissions and more. One command did what took me twenty `cd` and `ls` commands.

## `cd` is for folders, `cat` is for files

I tried to `cd` into a file. `find` gave me the full path to it, and I could've just used `cat` on that path straight away instead of navigating there first.

## Mistakes I keep making

- **Missing spaces:** `cd..`, `cd/`, `cd~`, `cd./folder`. The command, then a space, then what it acts on.
- **The dash on options:** `ls la` or `ls - la` instead of `ls -la`
- **Case:** `hiding` isn't `Hiding`. Linux cares.
- **Not using Tab.** Autocomplete would have saved me loads of typos.

The pattern is that most of my errors are small typos, not not understanding. So when something fails, I check the basics first.
