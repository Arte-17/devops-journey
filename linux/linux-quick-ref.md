# Linux Quick Reference

The commands I need to have cold, plus the small slips that cost me marks. **Read every command as an English sentence.**

---

## Files & folders
| Task | Command | Remember |
|---|---|---|
| Go home | `cd ~` | |
| List everything, with details | `ls -la` | `-l` details, `-a` hidden |
| Make nested folders | `mkdir -p a/b/c` | `-p` = make parents too |
| Add a line to a file | `echo "done" >> log.txt` | needs **echo**; `>>` adds |
| **Empty** a file (keep it) | `> big.log` | single `>` goes **first** |
| Copy | `cp WHAT WHERE` | |

> `>` wipes, `>>` adds. Neither works without something to write (`echo`).

## Permissions & users
| Task | Command | Remember |
|---|---|---|
| Set permissions by number | `chmod 750 script.sh` | r=4 w=2 x=1 → owner 7, group 5, other 0 |
| Make runnable | `chmod +x script.sh` | own file = **no sudo** |
| Change owner (and everything inside) | `sudo chown -R john /srv/app` | **owner first, then target**, capital R |
| Add user to a group | `sudo usermod -aG devops john` | capital **G**, user last |

> "Change owner **to john**, **of** /srv/app."

## Searching
| Task | Command | Remember |
|---|---|---|
| Count matching lines | `grep -c failed auth.log` | grep WHAT WHERE |
| Find big files on the system | `find / -size +100M 2>/dev/null` | **find** searches, du measures |
| Hide permission errors | `2>/dev/null` | 2 = errors → the bin |

> `find` = files. `grep` = text in files. `ps aux` = processes, never files.

## Logs
| Task | Command |
|---|---|
| Last 20 lines | `tail -n 20 /var/log/syslog` |
| Watch live | `tail -f /var/log/syslog` (Ctrl+C to stop) |
| A service's logs | `journalctl -u nginx` |

## Text crunching (log digging)
```
cut -d ' ' -f1 access.log | sort | uniq -c | sort -nr
```
Grab IPs (**space between the quotes**) → group → count (**space in `uniq -c`**) → biggest first.

## Processes (server slow)
| Task | Command |
|---|---|
| What's hogging the CPU? (name unknown) | `top` |
| Find a process by name | `ps aux \| grep nginx` |
| Stop it politely / force | `kill 812` / `kill -9 812` (**dash**) |

## Disk full
```
df -h                        # IS it full? (nothing after -h)
du -sh /var/* | sort -hr     # WHAT is filling it? biggest first
```

## Services (site down)
```
systemctl status nginx        # Active = now?  Loaded = on boot?
sudo systemctl start nginx    # fix now
sudo systemctl enable nginx   # fix after reboot
journalctl -u nginx           # why did it stop?
```
> Changing a service = **sudo**. Just looking (`status`) = no sudo.

## Network (site unreachable)
```
ping localhost               # is the machine up? (takes a machine, not a port)
ss -tulpn | grep 443         # is anything listening on the port?
curl localhost:8080          # does it answer? (colon, no space)
```

## Variables
| Task | Command |
|---|---|
| Print a variable | `echo $HOME` |
| Add a folder to PATH (in `~/.bashrc`) | `export PATH="$PATH:$HOME/scripts"` then `source ~/.bashrc` |

## Vim
| Task | Keys |
|---|---|
| Type | `i` |
| Stop typing | `Esc` |
| Save + quit | `:wq` |
| Quit **without** saving | `:q!` |

---

## My slips checklist (check before hitting Enter)
- [ ] **Spaces** where they belong: `-d ' '`, `uniq -c`, `cd ..`
- [ ] **No spaces** where they don't: `localhost:8080`, `name="x"`
- [ ] **Dashes** on flags: `-la`, `-R`, `-n 20`, `-f`, `-9`, `-aG`
- [ ] **sudo** on admin jobs (services, other people's files), **not** on my own files
- [ ] **Finished it?** Filename at the end, `| grep`, `| sort -hr`
- [ ] **Real values**, not placeholders (`localhost`, not `host`)
