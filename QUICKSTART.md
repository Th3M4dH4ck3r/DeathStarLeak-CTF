# Death Star Leak - Quick Start Guide

Get started with the CTF in 5 minutes! ⚡

---

## 🚀 For CTF Hosts / Deployment

### Prerequisites
- Ubuntu 20.04 or 22.04 LTS
- Root access
- Minimum 1GB RAM

### Deploy in 3 Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-repo/DeathStarLeak-CTF.git
   cd DeathStarLeak-CTF
   ```

2. **Run the setup script**
   ```bash
   sudo chmod +x setup.sh
   sudo ./setup.sh
   ```

3. **Verify deployment**
   ```bash
   # Check web service
   curl http://localhost:8080

   # Check SSH
   systemctl status ssh
   ```

**That's it! Your CTF is ready.** 🎉

Players can now access:
- Web interface: `http://<your-server-ip>:8080`
- SSH: `ssh <your-server-ip>`

---

## 🎯 For CTF Players

### Prerequisites
- Kali Linux or similar pentesting distribution
- Basic Linux command line knowledge
- Web browser

### Attack Plan

#### Step 1: Reconnaissance (5 min)
```bash
# Scan the target
export TARGET=<target_ip>
nmap -sV -sC -p- $TARGET

# Expected ports: 22 (SSH), 8080 (HTTP)
```

#### Step 2: Web Enumeration (10 min)
```bash
# Visit the web application
firefox http://$TARGET:8080 &

# Look for:
# - Login forms
# - Debug parameters
# - Hidden features
```

#### Step 3: Initial Access (15-30 min)
- Find the vulnerability in the web app
- Hint: Check for debug modes
- Exploit to gain shell access
- Capture Flag 1

#### Step 4: Privilege Escalation (1-2 hours)
Climb through the Imperial ranks:
1. **Stormtrooper** - Find credentials
2. **Imperial Officer** - SSH key exploitation
3. **Commander** - Sudo privilege abuse
4. **Vader** - SUID binary exploitation
5. **Emperor** - Advanced privilege escalation

### Useful Commands

```bash
# Spawn better shell
python3 -c 'import pty;pty.spawn("/bin/bash")'

# Stabilize shell
export TERM=xterm
# Ctrl+Z
stty raw -echo; fg

# Enumerate users
ls -la /home

# Check sudo privileges
sudo -l

# Find SUID binaries
find / -perm -4000 -type f 2>/dev/null

# Check current user
id
whoami
```

---

## 📊 Flag Checklist

Track your progress:

- [ ] **Flag 1**: Initial Access (www-data)
- [ ] **Flag 2**: Stormtrooper (TK-421)
- [ ] **Flag 3**: Imperial Officer
- [ ] **Flag 4**: Commander (Tarkin)
- [ ] **Flag 5**: Vader
- [ ] **Flag 6**: Emperor (Root)

All flags follow the format: `DSL{...}`

---

## 🆘 Stuck? Here's What to Do

### General Tips
1. **Enumerate thoroughly** - Don't rush, check everything
2. **Read all files** - Story hints are embedded
3. **Check permissions** - `ls -la` is your friend
4. **Google is allowed** - Research techniques you don't know

### When Completely Stuck

1. **Check HINTS.md** - Progressive hints available
2. **Take a break** - Fresh eyes help
3. **Review basics**:
   - Did you check `sudo -l`?
   - Did you search for SUID binaries?
   - Did you look in all home directories?
4. **Ask the community** - (if playing on TryHackMe)

### Resources
- [GTFOBins](https://gtfobins.github.io/) - Binary exploitation techniques
- [HackTricks](https://book.hacktricks.xyz/) - Pentesting guide
- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings) - Useful payloads

---

## ⚡ Speed Run Tips

For experienced players trying to beat the clock:

1. **Parallel enumeration** - Run multiple scans simultaneously
2. **Know GTFOBins** - Memorize common sudo/SUID exploits
3. **Script repetitive tasks** - Automate shell spawning, etc.
4. **Chain commands** - Use `&&` to run multiple commands
5. **Pre-written shells** - Have reverse shell payloads ready

**Current Speed Run Record**: *Be the first!* ⏱️

---

## 📝 Submission Format (For Competitions)

If submitting flags to a competition platform:

```
Flag 1: DSL{...}
Flag 2: DSL{...}
Flag 3: DSL{...}
Flag 4: DSL{...}
Flag 5: DSL{...}
Flag 6: DSL{...}
```

---

## 🎓 Learning Path

**Beginner?** Start with these TryHackMe rooms first:
1. Linux Fundamentals (Part 1-3)
2. Web Fundamentals
3. Linux PrivEsc
4. Sudo Security Bypass
5. SUID

**Then come back and crush this CTF!**

---

## ⚠️ Important Notes

### Legal Notice
- **Only attack systems you own or have permission to test**
- This CTF is for educational purposes only
- Techniques learned here should only be used legally

### Ethical Hacking Guidelines
✅ DO:
- Practice on authorized systems (TryHackMe, HackTheBox, your own VMs)
- Learn and improve your skills
- Help others learn

❌ DON'T:
- Attack systems without permission
- Use these techniques maliciously
- Share flags (if on a learning platform)

---

## 🌟 Difficulty Rating

| Aspect | Rating | Notes |
|--------|--------|-------|
| Initial Access | ⭐⭐⭐ | Medium - Command injection |
| Linux PrivEsc | ⭐⭐⭐⭐ | Medium-Hard - Multiple techniques |
| Overall | ⭐⭐⭐ | Intermediate |
| Fun Factor | ⭐⭐⭐⭐⭐ | Star Wars theme! |

**Estimated Time**: 2-3 hours for intermediate players

---

## 🎯 Success Metrics

After completing this CTF, you should be able to:

✅ Identify and exploit command injection vulnerabilities
✅ Perform thorough Linux system enumeration
✅ Find and use SSH private keys
✅ Exploit sudo misconfigurations
✅ Identify and exploit SUID binaries
✅ Perform privilege escalation to root
✅ Chain multiple vulnerabilities together

---

## 🎉 Completion

### After Getting All Flags

1. **Take a screenshot** of the root flag
2. **Write a mini write-up** - Practice documentation skills
3. **Help others** - Without spoiling the fun
4. **Share feedback** - Help improve the CTF

### Share Your Success

Found this CTF fun? Share it!
- Tweet about it with #DeathStarCTF
- Write a blog post
- Create a video walkthrough
- Recommend it to friends learning cybersecurity

---

## 📧 Support

**Issues or Questions?**
- Check the documentation files
- Read HINTS.md for progressive hints
- Review WALKTHROUGH.md (spoilers!)
- Open an issue on GitHub

---

## 🎬 Final Words

> *"Rebellions are built on hope."* - Jyn Erso

Good luck, and may the Force be with you! ⭐

---

**Ready to start?**

```bash
# For attackers:
nmap -sV <target_ip>

# For defenders:
sudo ./setup.sh
```

**Happy Hacking!** 🚀
