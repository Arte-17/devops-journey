# Bash scripts

Every script here was written by me while learning Bash. Run any of them with `./script.sh` (after `chmod +x script.sh`).

| Script | What it does | Run it like |
|---|---|---|
| `hello.sh` | My first script: prints Hello World | `./hello.sh` |
| `about.sh` | Variables: builds a sentence from fixed values (name, town, course) | `./about.sh` |
| `intro.sh` | Parameters: fills the same sentence with what you type after the script | `./intro.sh Arte Birmingham DevOps` |
| `rect.sh` | Works out a rectangle's area and perimeter with `$(( ))` maths | `./rect.sh 4 5` |
| `pass.sh` | A simple `if`: says "You passed" if the score is 50 or more | `./pass.sh 65` |
| `grade.sh` | `if` / `elif` / `else`: Distinction (70+), Pass (50+) or Fail | `./grade.sh 72` |
| `age.sh` | Asks your age, checks it's a number, handles silly answers | `./age.sh` |
| `countdown.sh` | A `while` loop that counts down from a number, then says GO! | `./countdown.sh 5` |
| `topip.sh` | Ranks the IPs in a log by number of requests; errors if the file's missing | `./topip.sh access.log` |
| `alllogs.sh` | Runs `topip.sh` on every log in a folder, skipping the noisy one | `./alllogs.sh` |
| `checkfiles.sh` | A function that says OK or MISSING for each file | `./checkfiles.sh` |
| `readlist.sh` | Reads a file line by line with `while read` | `./readlist.sh` |
| `checklist.sh` | Reads filenames from `files.txt` and checks each one exists | `./checklist.sh` |
| `sysinfo.sh` | Prints your user, home folder, shell and current folder from environment variables | `./sysinfo.sh` |
| `logreport.sh` | **Capstone:** a report on any log (line count, top 3 IPs, who ran it and when) | `./logreport.sh access.log > report.txt` |

## Folders
- `hub/`: the course's assignment challenges
- `practice/`: earlier versions and rebuilds. I rebuild scripts from a blank file until I can write them without help, and these show the reps.
