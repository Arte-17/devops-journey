# Bash assignment challenges

## The scripts
| Script | What it does |
|---|---|
| `filedemo.sh` | Makes a folder, goes into it, writes a file with today's date inside, then shows what's in it. |
| `calc.sh` | Asks for 2 numbers, then adds, subtracts, multiplies and divides them. It won't divide by 0, so it checks the input before using it. |
| `permcheck.sh` | Asks for a file and checks it exists (an exit 1 guard stops it if not). Then checks if it's readable, writable and executable. Handy for "permission denied" tickets. |
| `backup.sh` | Asks for a folder and checks it exists. Copies all .txt files into a new backup folder with the date and time in its name, then counts them. The kind of backup you'd run before changing anything on a server. |
| `sysmon.sh` | Takes a snapshot of the computer and saves it to a dated log file: is the CPU busy, is memory or disk full, and what's eating the memory. First thing to run on a slow server. |

## What I learned
- A guard at the top of a script can save a lot of time. If the input is wrong, it stops straight away instead of breaking halfway through.
- How practical Bash is. These are things you'd actually use at work.
- How to build a calculator and check the input before using it.
- `read` is where the user types something in, and it goes into a box.

## A challenge I'm working through
A lot of this was hard, but the hardest part was combining the different pieces of a script together. I took it bit by bit, building longer scripts in chunks. I can't say I've fully got past it yet, but it's getting clearer every time I rebuild one.

## Why Bash matters in DevOps
Bash lets you automate processes and save a lot of time. You can also combine scripts together to get detailed data very quickly.
