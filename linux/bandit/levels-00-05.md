# OverTheWire Bandit – Levels 0 to 5

My notes from working through Bandit. No passwords, just what I tried, where I went wrong and what I took away from each level.

---

## Level 0 – Logging in

First hurdle was just getting in. I tried:

```
ssh bandit.labs.overthewire.org port: 2220
```

and got "Permission denied" plus a warning about port 22. Two mistakes there. I didn't give a username, so SSH used my laptop's username (`abdia`), and `port: 2220` isn't how you set a port, so it ignored it and went to the default.

What actually works:

```
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

**Takeaway:** the pattern is `ssh USER@SERVER -p PORT`. I won't forget that one.

---

## Level 0 → 1

The password was in a file called `readme` in the home directory. `ls` then `cat readme`, done.

The bit that confused me was afterwards. Each level is a completely different user with its own home folder, so I couldn't see bandit1's files while I was still logged in as bandit0. Once that clicked, the whole game made more sense.

---

## Level 1 → 2

The password was in a file called `-`. This one annoyed me.

First, I went to `/home` looking for it. Wrong place. `/home` is the folder that holds *everyone's* home directories. "Home directory" means mine, which is `~` (`/home/bandit1`).

Then I kept typing `cat -` and the terminal just hung every time. Turns out a lone `-` isn't treated as a filename. To `cat` it means "read from the keyboard", so it was just sitting there waiting for me to type something.

Fix:

```
cd ~
cat ./-
```

The `./` turns it into a path, "the file called `-` in this folder", so `cat` knows it's a file.

**Takeaway:** `~` and `/home` are not the same place. And if a filename could be mistaken for something else, give it a path. A normal name like `dog` doesn't need any of this.

---

## Level 2 → 3

File called `--spaces in this filename--`. Two problems in one name.

`cat --spaces in this filename--` gave "unexpected argument", because the spaces split it into separate words. So I added quotes, and it still errored. The spaces were sorted, but the name starts with `--`, so `cat` thought it was an option like `--help`.

I combined the trick from the last level with the quotes:

```
cat ./"--spaces in this filename--"
```

Quotes deal with the spaces, `./` stops it looking like an option. The error message also hinted at another way: `cat -- "--spaces in this filename--"`, where a lone `--` means "no more options after this".

**Takeaway:** anything starting with `-` looks like an option to Linux. Quotes for spaces, `./` for dashes, and both if it's got both.

---

## Level 3 → 4

Hidden file somewhere in the `inhere` folder. I made a lot of small mistakes on this one, but got there.

- `ls` showed nothing. The folder looked empty.
- I knew I wanted `ls -la` but typed `ls la`, then `ls - la`, then `lsa`. Got the dash and spacing wrong three times in a row.
- `ls -a` finally showed `...Hiding-From-You`
- Then `cat ./ hiding-From-You` failed (a space after `./` and a lowercase h), and `cat ...hiding-From-You` failed (still lowercase).
- `cat ...Hiding-From-You` worked.

Files starting with `.` are hidden, and plain `ls` doesn't show them. You need `-a` for "all".

**Takeaway:** use `ls -a` when a folder looks empty. Linux is case-sensitive, so `hiding` isn't `Hiding`. And I should've been using **Tab** to autocomplete. It would have saved me about four attempts.

---

## Level 4 → 5

Ten files, `-file00` to `-file09`, and only one is human-readable.

I went through them one by one with `cat ./-file00`, `./-file01` and so on. At least the `./` for dash filenames is automatic now; I got that right first time on every one. Most of them printed garbage symbols because they're binary data, not text. `-file07` was the one.

Found out afterwards there's a quicker way:

```
file ./*
```

`file` tells you what type each file is, and `*` means everything in the folder. The one that says "ASCII text" is the answer.

**Takeaway:** brute force is fine for 10 files but not for 1,000. There's usually a tool built for the job, so look for it first.
