# Death Star Leak - Resources & Learning Materials

Helpful resources to complete the CTF and improve your skills.

---

## 🎓 Recommended Learning Path

### Before Starting This CTF

If you're new to Linux or pentesting, complete these first:

1. **Linux Basics**
   - [OverTheWire: Bandit](https://overthewire.org/wargames/bandit/) - Linux command line fundamentals
   - [TryHackMe: Linux Fundamentals](https://tryhackme.com/module/linux-fundamentals)
   - [Linux Journey](https://linuxjourney.com/) - Comprehensive Linux guide

2. **Web Application Security**
   - [PortSwigger Web Security Academy](https://portswigger.net/web-security) - Free web hacking tutorials
   - [OWASP Top 10](https://owasp.org/www-project-top-ten/) - Most critical web vulnerabilities
   - [TryHackMe: Web Fundamentals](https://tryhackme.com/module/web-hacking-1)

3. **Linux Privilege Escalation**
   - [TryHackMe: Linux PrivEsc](https://tryhackme.com/room/linuxprivesc)
   - [HackTheBox: Linux PrivEsc](https://academy.hackthebox.com/course/preview/linux-privilege-escalation)

---

## 🔧 Essential Tools

### Reconnaissance & Scanning

- **Nmap** - Port scanning and service detection
  - [Nmap Reference Guide](https://nmap.org/book/man.html)
  - [Nmap Cheat Sheet](https://www.stationx.net/nmap-cheat-sheet/)

- **Gobuster/Dirb** - Directory brute forcing
  - [Gobuster GitHub](https://github.com/OJ/gobuster)

- **Nikto** - Web vulnerability scanner
  - [Nikto Documentation](https://cirt.net/Nikto2)

### Web Exploitation

- **Burp Suite** - Web application testing
  - [Burp Suite Documentation](https://portswigger.net/burp/documentation)
  - [Burp Suite Tutorial](https://portswigger.net/burp/documentation/desktop/getting-started)

- **curl** - Command line web requests
  - [curl Cheat Sheet](https://devhints.io/curl)

### Shells & Access

- **Netcat** - The TCP/IP Swiss Army knife
  - [Netcat Cheat Sheet](https://www.sans.org/security-resources/sec560/netcat_cheat_sheet_v1.pdf)

- **Reverse Shell Cheat Sheet**
  - [PentestMonkey Reverse Shells](http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet)
  - [Reverse Shell Generator](https://www.revshells.com/)

### Privilege Escalation

- **LinPEAS** - Linux privilege escalation script
  - [LinPEAS GitHub](https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS)

- **LinEnum** - Linux enumeration script
  - [LinEnum GitHub](https://github.com/rebootuser/LinEnum)

- **Linux Smart Enumeration (LSE)**
  - [LSE GitHub](https://github.com/diego-treitos/linux-smart-enumeration)

---

## 📚 Reference Guides

### Exploitation Databases

- **GTFOBins** - ⭐ ESSENTIAL for this CTF!
  - [https://gtfobins.github.io/](https://gtfobins.github.io/)
  - Unix binaries that can be exploited for privilege escalation
  - **Relevant for this CTF**: find, systemctl, bash

- **Exploit-DB**
  - [https://www.exploit-db.com/](https://www.exploit-db.com/)
  - Exploits and vulnerable software database

### Command Injection

- **Command Injection Guide**
  - [OWASP Command Injection](https://owasp.org/www-community/attacks/Command_Injection)
  - [PayloadsAllTheThings - Command Injection](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Command%20Injection)

### Linux Privilege Escalation

- **HackTricks - Linux PrivEsc**
  - [https://book.hacktricks.xyz/linux-hardening/privilege-escalation](https://book.hacktricks.xyz/linux-hardening/privilege-escalation)
  - Comprehensive privilege escalation techniques

- **PayloadsAllTheThings - Linux PrivEsc**
  - [GitHub Link](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Linux%20-%20Privilege%20Escalation.md)

- **g0tmi1k's Linux PrivEsc Guide**
  - [Blog Post](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/)
  - Classic privilege escalation reference

### SUID Exploitation

- **SUID Binaries Exploitation**
  - [HackTricks SUID](https://book.hacktricks.xyz/linux-hardening/privilege-escalation#suid)
  - How to find and exploit SUID binaries

### Sudo Exploitation

- **Sudo Privilege Escalation**
  - [GTFOBins Sudo](https://gtfobins.github.io/#+sudo)
  - [HackTricks Sudo](https://book.hacktricks.xyz/linux-hardening/privilege-escalation#sudo-and-suid)

### SSH Key Exploitation

- **SSH Key Authentication**
  - [SSH Keys Explained](https://www.ssh.com/academy/ssh/key)
  - [Using SSH Keys for Authentication](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server)

---

## 🎯 Specific Techniques Used in This CTF

### 1. Command Injection in Web Applications

**What to learn:**
- How command injection works
- Bypassing input validation
- Chaining commands with `;`, `|`, `&&`

**Resources:**
- [OWASP Command Injection](https://owasp.org/www-community/attacks/Command_Injection)
- [PortSwigger: OS Command Injection](https://portswigger.net/web-security/os-command-injection)

**CTF Practice:**
- TryHackMe: Injection
- HackTheBox: Command Injection machines

### 2. Finding SSH Private Keys

**What to learn:**
- Linux file permissions
- Where SSH keys are typically stored
- Using SSH keys for authentication

**Resources:**
- [SSH Key Management](https://www.ssh.com/academy/ssh/key)

**Commands:**
```bash
# Find SSH keys
find / -name id_rsa 2>/dev/null
find / -name authorized_keys 2>/dev/null

# Use a private key
chmod 600 key.pem
ssh -i key.pem user@host
```

### 3. Sudo Privilege Escalation with Find

**What to learn:**
- How sudo works
- GTFOBins for sudo exploitation
- `find` command capabilities

**Resources:**
- [GTFOBins: find](https://gtfobins.github.io/gtfobins/find/)

**Example:**
```bash
# Check sudo privileges
sudo -l

# Exploit find
sudo -u <user> find . -exec /bin/bash \;
```

### 4. SUID Binary Exploitation

**What to learn:**
- What SUID is and how it works
- Finding SUID binaries
- Exploiting vulnerable SUID programs

**Resources:**
- [SUID Exploitation Guide](https://pentestlab.blog/category/privilege-escalation/)
- [HackTricks SUID](https://book.hacktricks.xyz/linux-hardening/privilege-escalation#suid)

**Commands:**
```bash
# Find SUID binaries
find / -perm -4000 -type f 2>/dev/null

# Check binary ownership and permissions
ls -la /path/to/binary
```

### 5. Systemctl Pager Escape

**What to learn:**
- How pagers (less, more) work
- Executing commands from pagers
- Systemctl sudo exploitation

**Resources:**
- [GTFOBins: systemctl](https://gtfobins.github.io/gtfobins/systemctl/)
- [GTFOBins: less](https://gtfobins.github.io/gtfobins/less/)

**Example:**
```bash
# When systemctl opens a pager
sudo systemctl status <service>
# In the pager, type:
!/bin/bash
```

---

## 🏆 Similar CTF Challenges

Practice similar techniques with these CTFs:

### TryHackMe Rooms
- **Linux PrivEsc** - Comprehensive privilege escalation practice
- **Basic Pentesting** - Similar beginner-friendly approach
- **Kenobi** - Star Wars themed, SUID exploitation
- **Skynet** - More Star Wars theming
- **Pickle Rick** - Web exploitation and privilege escalation

### HackTheBox Machines
- **Lame** - Classic easy box
- **Shocker** - Web exploitation
- **Beep** - Multiple privilege escalation paths
- **Nibbles** - Web to root

### VulnHub
- **Mr. Robot** - Themed CTF with progressive difficulty
- **DC Series** - Progressive privilege escalation

---

## 📖 Books & Courses

### Books

- **The Hacker Playbook 3** by Peter Kim
  - Practical pentesting techniques
  - Red team strategies

- **Linux Basics for Hackers** by OccupyTheWeb
  - Perfect for beginners
  - Linux fundamentals for security

- **The Web Application Hacker's Handbook** by Dafydd Stuttard
  - Comprehensive web security guide

### Online Courses

- **TryHackMe Offensive Pentesting Path**
  - [https://tryhackme.com/path/outline/pentesting](https://tryhackme.com/path/outline/pentesting)

- **HackTheBox Academy**
  - [https://academy.hackthebox.com/](https://academy.hackthebox.com/)

- **PentesterLab**
  - [https://pentesterlab.com/](https://pentesterlab.com/)

---

## 🎬 Video Tutorials

### YouTube Channels

- **IppSec** - HackTheBox walkthroughs
  - [https://www.youtube.com/c/ippsec](https://www.youtube.com/c/ippsec)

- **John Hammond** - CTF and security content
  - [https://www.youtube.com/c/JohnHammond010](https://www.youtube.com/c/JohnHammond010)

- **LiveOverflow** - Advanced security topics
  - [https://www.youtube.com/c/LiveOverflow](https://www.youtube.com/c/LiveOverflow)

- **The Cyber Mentor** - Ethical hacking tutorials
  - [https://www.youtube.com/c/TheCyberMentor](https://www.youtube.com/c/TheCyberMentor)

---

## 🛠️ Setting Up Your Pentesting Environment

### Kali Linux
- [Download Kali](https://www.kali.org/get-kali/)
- Pre-installed with most tools you need

### Parrot Security OS
- Alternative to Kali
- [Download Parrot](https://www.parrotsec.org/download/)

### Custom Ubuntu Setup
```bash
# Install common pentesting tools
sudo apt update
sudo apt install -y nmap netcat gobuster curl wget python3 python3-pip
pip3 install pwntools
```

---

## 🌐 Communities & Forums

### Discord Servers
- **TryHackMe Discord** - Active community
- **HackTheBox Discord** - CTF discussions
- **InfoSec Community** - General security

### Subreddits
- r/netsec - Network security
- r/HowToHack - Learning resources
- r/cybersecurity - General security news

### Forums
- **TryHackMe Forums** - CTF discussions
- **HackTheBox Forums** - Machine writeups

---

## 📝 Cheat Sheets

- **Nmap Cheat Sheet**: [https://www.stationx.net/nmap-cheat-sheet/](https://www.stationx.net/nmap-cheat-sheet/)
- **Linux Privilege Escalation**: [https://github.com/swisskyrepo/PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)
- **Reverse Shell Cheat Sheet**: [http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet](http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet)
- **GTFOBins**: [https://gtfobins.github.io/](https://gtfobins.github.io/)

---

## ⚠️ Responsible Disclosure & Ethics

### Learn Ethically
- Only test systems you own or have explicit permission to test
- Never attack production systems without authorization
- Respect responsible disclosure policies

### Certifications
- **OSCP** - Offensive Security Certified Professional
- **CEH** - Certified Ethical Hacker
- **eJPT** - eLearnSecurity Junior Penetration Tester

---

## 🎯 Next Steps After This CTF

1. **Write a blog post** about your experience
2. **Try harder CTFs** on TryHackMe/HackTheBox
3. **Learn a new technique** you struggled with
4. **Help others** in the community
5. **Build your own CTF** to solidify knowledge

---

May the Force (and knowledge) be with you! ⭐

**Happy Learning!** 🚀
