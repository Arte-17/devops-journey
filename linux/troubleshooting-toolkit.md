# Linux Troubleshooting Toolkit

## Why I went back

After the Linux basics and a few Bandit levels, I jumped into SadServers (broken servers you have to fix). First scenario: a process filling up the disk by writing to a log non-stop.

I got stuck straight away. The instructor was using commands I hadn't learnt yet, and I caught myself copying them without knowing what they did. That's no use in an interview or on a real server, so I stepped back and learnt the troubleshooting side properly. For every command, I predicted what it would do before running it.

---

## Pipes
`|` passes one command's output into the next, like a production line.
`ps aux | grep bash | wc -l` lists processes, keeps the bash ones, and counts them.
**Caught me out:** I kept naming a file after the pipe. Only the first command reads a file.

## Processes: what's running?
`ps aux | grep NAME` to find it, `kill PID` to stop it, `kill -9 PID` if it won't.
I practised by starting `sleep 500 &`, finding it and killing it.
**Learnt:** PIDs change every time, `grep` shows up in its own results, and always check it's actually gone.

## Logs: what happened?
Logs live in `/var/log`, newest at the bottom. `tail -f` watches one live. I tested it with two terminals open, one writing and one watching.
**Caught me out:** `grep ERROR file | tail -n 1` and `tail -n 1 file | grep ERROR` look the same but aren't. Order matters in a pipe.

## Counting: how many, and what's most common?
`grep WORD file | wc -l` for how many. `sort file | uniq -c | sort -nr` for what's most common, like which IP is hitting a server most.
**Caught me out:** `uniq` only counts duplicates that are next to each other, so you have to sort first. I also tried chaining two sorts, but the second just undoes the first.

## Disk: is it full, and what's filling it?
`df -h` checks the whole disk. `du -sh /folder/* | sort -hr` finds what's big. On my own machine the biggest thing in `/var` was the system logs.
**Caught me out:** `sort -n` thinks 840K is bigger than 6.6M. `sort -h` understands K, M and G.

## Services: is it running?
`systemctl status`, `restart` and `enable`, plus `journalctl -u NAME` for its logs. I practised stopping and starting `cron` and found my own actions in its logs.
**The big one:** `start` means now, and `enable` means after a reboot. Forget enable and the service won't come back after a restart.

## Network: is it listening, and does it answer?
`ss -tulpn | grep PORT` shows what's listening, and `curl localhost:PORT` checks it actually responds. I ran a little Python web server on port 8000, saw it with `ss`, hit it with `curl`, then killed it and watched curl fail.
**Takeaway:** a server can answer ping and the site can still be down. Ping checks the machine, and curl checks the service. My CCNA study helped here.

---

## "The website's down": where I'd start
1. Is the service running? → `systemctl status`
2. Why did it stop? → check its logs
3. Is it listening on the right port? → `ss`
4. Does it respond? → `curl`
5. Is the disk full? → `df -h`
6. Fix it, then check the fix actually worked

**Update:** came back and solved SadServers 'Saskatoon' (counting IPs) myself.
