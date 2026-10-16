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

Did this 5 or 6 times with different logs until I could do it first try with no help. Then solved **SadServers "Saskatoon"** with it. Later I turned the whole pipeline into a script (`bash/topip.sh`) that takes the log file as `$1`.

**Talk me through it:** "Look at the first few lines to see the format, cut out the IP field, sort so duplicates sit together, count them with uniq -c, then sort by count, biggest first. Then check the top answer against the original log with grep -c."

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
- `df -h` vs `du -sh`. I kept giving `df` the wrong flags, and once merged them into one command. They're two steps answering two questions: *is* it full (`df -h`, nothing after it), then *what's* filling it (`du`).

**Talk me through it:** "Confirm the disk is actually full with df -h. Then du -sh on each folder, sorted biggest first, and keep drilling into the biggest one until I find the file. If the app still needs it, I empty it with > instead of deleting it. Then du again to prove the space came back."

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

**Learnt:** check the COMMAND column before killing anything. Ctrl+C only stops foreground stuff, so background hogs need `kill`. If I don't know the name yet, `top` first, not `ps aux`. On a real server `ps aux` is hundreds of lines in no order, while `top` puts the hog at the top.

**Talk me through it:** "Open top to see what's using the CPU, note the PID and check the command is what I think it is. kill it politely first, kill -9 only if that fails, then check it's gone."

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

**Talk me through it:** "systemctl status shows two things: Active (is it running now?) and Loaded (enabled or disabled, i.e. will it come back after a reboot?). Start fixes now, enable fixes the reboot. Then status again, and curl to prove the site actually answers."

---

## 5. Site unreachable
**Ticket:** users say the website on port 8000 is unreachable.

Like checking a house: is the house there, is anyone home, do they answer the door?

```
ping localhost                 # is the machine up?
ss -tulpn | grep 8000          # is anything listening on the port?
ss -tulpn                      # nothing? see everything that IS listening
kill 535                       # stop the one on the wrong port (pid= label)
python3 -m http.server 8000 &  # start it on the right port
curl localhost:8000            # does it actually answer?
```

Ping was fine and nothing was on 8000, but the full `ss` list showed python listening on **8001**. Wrong port. I killed it, restarted it on 8000, and curl got a page back.

**What tripped me up:**
- Typing placeholders literally: `ping host`, `grep port 8000`. The word gets swapped for the real value.
- `ping` takes a machine, not a port. `ping 80` pinged an address called 0.0.0.80 for 12 minutes.
- `curl localhost :80` with a space. Address and port are one word: `localhost:80`
- Reading the PID: look for `pid=` in the ss output, not a random number in the row.

**Talk me through it:** "Ping to check the machine's up. ss to see if anything's listening on the port. If not, look at the full list to see if it's on the wrong port or not running at all. Fix it, then curl to prove it answers."

---

## Tricks that helped
- **Read the command as an English sentence.** "grep *failed* in *auth.log*" sounds right; "grep auth.log in failed" doesn't. This fixed most of my order mistakes.
- **Read the error message.** It usually tells you exactly what's wrong.
- **`>` only means "write output into a file", and it wipes the file first.** I learnt that the hard way on a SadServers box.
- **Plan before touching anything.** Say the steps out loud first. In an interview, "talk me through it" comes before the keyboard.

---

*All 5 done and cold-run. Now carrying on with Bash scripting (see the `bash/` folder).*
