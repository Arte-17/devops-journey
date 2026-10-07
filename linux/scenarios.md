# Troubleshooting Scenarios I've Practised

After going back to learn the troubleshooting side properly, I started practising it as "tickets" on my own laptop. A setup command breaks something (or creates a messy log), and I have to fix it without notes, using the same method each time:

**Look → work out the question → pick the tool → fix → verify**

The verify step was the one I kept skipping at first. It ended up catching a real mistake of mine, so now it's a habit.

---

## 1. Log digging: "what's most common?"
**Ticket:** a server's getting hammered. Which IP made the most requests? Which page is most popular?

```
head -n 3 access.log                                    # look at the data first
cut -d ' ' -f1 access.log | sort | uniq -c | sort -nr   # group → count → rank
echo "10.20.0.2" > answer.txt                           # write the answer
grep -c "10.20.0.2" access.log                          # prove it against the source
```

**What tripped me up:**
- `cut` splits at *every* space, so I had to count fields carefully (the IP was field 1, the page was field 6)
- `uniq -c` counts *each* item, while `wc -l` gives one total. I mixed these up more than once.
- For verifying, I kept checking my answer against my own answer file. You check it against the original data.

Did this 5 or 6 times with different logs until I could do it first try with no help. Then solved **SadServers "Saskatoon"** with it.

---

## 2. Disk full
**Ticket:** disk space alert. Find what's eating it and free it up without deleting files the app still needs.

```
df -h                              # IS the disk full?
du -sh /srv/* | sort -hr           # WHAT is big? then drill down folder by folder
> /srv/var/log/nginx/error.log     # empty the file (keeps it for the app)
du -sh /srv/var/log/nginx/*        # verify it's now 0
```

**What tripped me up:**
- First time, I emptied `app.log` from the wrong folder, which just created a new empty file. My verify step showed the real one was still 60M, so I caught it.
- `server*` vs `server/*`: without the slash you only get the folder's total, not what's inside it
- `df -h` vs `du -sh`. I kept giving `df` the wrong flags.

---

## 3. Something hogging the CPU
**Ticket:** the server's really slow.

```
top                      # live view, hungriest process at the top
ps aux | grep NAME       # find a specific one (PID = 2nd column)
kill 1422                # polite stop
kill -9 1422             # force, only if the first fails
free -h                  # memory: read the "available" column
```

I made a fake hog with `yes > /dev/null &`, caught it in `top` at 96% CPU, killed it and checked it was gone.

**Learnt:** check the COMMAND column before killing anything. Ctrl+C only stops foreground stuff, so background hogs need `kill`.

---

## 4. Service down
**Ticket:** users say the website is down.

```
systemctl status nginx           # Active: inactive  +  Loaded: disabled = two problems
sudo systemctl start nginx       # fix it now
sudo systemctl enable nginx      # fix it for after a reboot
systemctl status nginx           # verify: active (running) + enabled
curl localhost                   # verify the site actually responds
```

Installed nginx, broke it, then fixed it myself. I hit "Interactive authentication required" and worked out from the error that I needed `sudo`.

**Learnt:** `start` means now, `enable` means after a reboot. Easy to forget the second one and have the site die again overnight.

---

## Tricks that helped
- **Read the command as an English sentence.** "grep *failed* in *auth.log*" sounds right; "grep auth.log in failed" doesn't. This fixed most of my order mistakes.
- **Read the error message.** It usually tells you exactly what's wrong.
- **`>` only means "write output into a file", and it wipes the file first.** I learnt that the hard way on a SadServers box.

---

*Next: site unreachable (ports and curl), then carrying on with Bash scripting.*
