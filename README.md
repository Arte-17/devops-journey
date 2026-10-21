# DevOps Journey

My name is Abdulrahman Arte. I have a background in IT, and this repo documents my journey into becoming a DevOps engineer. Everything here is written by me as I learn it: notes, scripts, and the mistakes I made along the way.

## Current Status
Linux ✅ (all 5 troubleshooting scenarios done) → **Bash scripting (nearly finished)** → Git next

## Modules
- ✅ Linux Fundamentals
- → Bash Scripting
- Git & GitHub
- Networking
- Docker
- AWS
- Terraform
- CI/CD (GitHub Actions)
- Kubernetes
- Projects: the ECS project (Docker + AWS + Terraform + CI/CD)

## What's in here
| Folder | What it is |
|---|---|
| `linux/` | My Linux cheatsheet, a quick reference, the slip-ups I kept making, what Bandit taught me, and 5 troubleshooting scenarios with how I'd talk through each one in an interview |
| `bash/` | Every script I've written while learning Bash, from `hello.sh` to scripts that loop, check input and report errors |

## Scripts I'm most proud of
- **`topip.sh`**: ranks the IPs in a log file by number of requests. It started as a pipeline I kept typing by hand (`cut | sort | uniq -c | sort -nr`). Now it's one command that works on any log, checks the file exists first, and exits with an error code if it doesn't.
- **`alllogs.sh`**: loops through every log in a folder and runs `topip.sh` on each one, skipping the noisy one. This was the moment scripting clicked for me: one script handing work to another.
- **`age.sh`**: asks for your age, checks it's actually a number before doing anything with it, and handles silly answers (I added a "ghost" check for anything over 150).

## What I've Learned So Far (and what I've found difficult)
- **Permissions took me a while.** Reading `rwxr-x---` made no sense at first, but working out owner / group / others one section at a time made it click.
- **Troubleshooting is a method, not a memory test.** Look, work out the question, pick the tool, fix, verify. The verify step has caught my own mistakes more than once.
- **Most of my errors are small things.** A missing space, a missing dash, forgetting `sudo`, or using `>` when I meant `>>`. When something fails, I check the basics first and read the error message properly.
- **Bash only made sense once I stopped copying.** Parameters (`$1`) confused me until I thought of a script as a form with blanks that get filled in when you run it. Functions clicked when I thought of them as speed dial: save it once, then press it whenever you need it.
- **I test my own scripts at the edges.** 49 and 50, 0 and 1, a decimal, a word instead of a number. That's where the bugs hide.

## Next Steps
Finish the last Bash videos (`set -u`, `-x`, environment variables, working with files), then move on to Git and Networking.
