# TryHackMe Submission Guide

This guide helps prepare the Death Star Leak CTF for TryHackMe submission.

---

## 📋 Pre-Submission Checklist

### Technical Requirements

- [x] **Linux Base**: Ubuntu/Debian based system
- [x] **Difficulty Level**: Intermediate
- [x] **Estimated Time**: 2-3 hours
- [x] **Learning Paths**:
  - Linux Privilege Escalation
  - Web Application Security
  - Penetration Testing Fundamentals

### Content Quality

- [x] **Theme**: Star Wars - Rogue One (Death Star heist)
- [x] **Story Integration**: Each flag includes story progression
- [x] **Multiple Flags**: 6 flags total (good for TryHackMe points system)
- [x] **Varied Techniques**: Different privilege escalation methods
- [x] **Educational Value**: Teaches real-world techniques

### Documentation

- [x] README.md with deployment instructions
- [x] Complete walkthrough for reviewers
- [x] Hints system for players
- [x] Setup script for easy deployment

---

## 🎯 Room Information

### Suggested Room Details

**Room Name**: Death Star Leak

**Short Description**:
"Infiltrate the Death Star's Imperial network as a Rebel spy. Climb through the ranks from Stormtrooper to Emperor to steal the Death Star plans."

**Long Description**:
```
The Rebellion has discovered that the Empire's ultimate weapon - the Death Star - is operational.
Your mission is to infiltrate the station's network and steal the technical plans.

Work your way through the Imperial hierarchy:
→ Gain initial access to the Imperial network
→ Compromise a Stormtrooper account
→ Escalate to Imperial Officer clearance
→ Assume Commander Tarkin's authority
→ Wield Darth Vader's power
→ Breach the Emperor's vault

This box teaches web exploitation, Linux enumeration, and various privilege escalation techniques
including SUID exploitation, sudo abuse, and creative binary exploitation.

"Rebellions are built on hope." - Jyn Erso
```

**Tags**:
- Linux
- Privilege Escalation
- Web
- Boot2Root
- Star Wars
- SUID
- Sudo
- CTF

**Difficulty**: Medium

**Type**: Challenge

---

## 🎓 Learning Objectives

Players will learn:

1. **Web Application Security**
   - Command injection vulnerabilities
   - Debug parameter exploitation
   - Gaining initial access through web apps

2. **Linux Enumeration**
   - Finding readable files
   - Locating SSH keys
   - Identifying SUID binaries
   - Checking sudo privileges

3. **Privilege Escalation**
   - Horizontal privilege escalation via SSH keys
   - Sudo misconfiguration exploitation (`find` command)
   - SUID binary command injection
   - Systemctl pager escape to root

4. **Lateral Movement**
   - Using found credentials
   - SSH key authentication
   - Chaining multiple vulnerabilities

---

## 📝 Questions for TryHackMe Room

### Task 1: Mission Briefing
*Deploy the machine and read the mission briefing*

1. What is the operation name for this mission?
   - **Answer**: `STARDUST`

2. What port is the Imperial web interface running on?
   - **Answer**: `8080`

### Task 2: Initial Access

3. What is the vulnerable parameter that enables debug mode?
   - **Answer**: `debug`

4. What user do you initially gain access as?
   - **Answer**: `www-data`

5. Submit the first flag (initial access)
   - **Answer**: `DSL{w3lc0m3_t0_th3_d3ath_st4r_r3b3l}`

### Task 3: Stormtrooper Rank

6. What is TK-421's password?
   - **Answer**: `tk421isdown`

7. Submit the Stormtrooper flag
   - **Answer**: `DSL{tk421_why_4r3nt_y0u_4t_y0ur_p0st}`

### Task 4: Imperial Officer Rank

8. What directory contains the SSH key for the imperial-officer?
   - **Answer**: `.backup`

9. Submit the Imperial Officer flag
   - **Answer**: `DSL{1mp3r14l_0ff1c3r_cl34r4nc3_gr4nt3d}`

### Task 5: Commander Rank

10. What command can imperial-officer run as commander via sudo?
    - **Answer**: `/usr/bin/find`

11. Submit the Commander flag
    - **Answer**: `DSL{t4rk1n_y0u_m4y_f1r3_wh3n_r34dy}`

### Task 6: Darth Vader Rank

12. What is the full path of the SUID binary owned by vader?
    - **Answer**: `/usr/local/bin/deathstar_scanner`

13. Submit the Vader flag
    - **Answer**: `DSL{1_f1nd_y0ur_l4ck_0f_f41th_d1sturb1ng}`

### Task 7: Emperor Access (Root)

14. What command can vader run as root via sudo?
    - **Answer**: `/bin/systemctl status *`

15. Submit the Emperor flag (root flag)
    - **Answer**: `DSL{unl1m1t3d_p0w3r_th3_pl4ns_4r3_y0urs}`

16. What is the Death Star's main weakness according to the plans?
    - **Answer**: `thermal exhaust port`

---

## 🖼️ Suggested Room Banner

```
    ⭐ DEATH STAR LEAK ⭐

         _.-._
        /     \
       |  .--.  |
       | /    \ |
       |/      \|
       |\      /|
       | \    / |
       |  `--'  |
        \_____/

   INFILTRATE THE EMPIRE
    STEAL THE PLANS
  SAVE THE REBELLION
```

---

## 🎬 Hints System (Progressive)

### Hint 1 - Initial Access (Free)
"Start by exploring the web application. Look for debug or development features that might be enabled."

### Hint 2 - Web Exploitation (Cost: 10%)
"Try the ?debug=true parameter. The application might be vulnerable to command injection."

### Hint 3 - Stormtrooper (Cost: 10%)
"Check the stormtrooper's home directory for any readable files containing credentials."

### Hint 4 - Imperial Officer (Cost: 15%)
"Look for backup directories in the stormtrooper's home. SSH keys might be lying around."

### Hint 5 - Commander (Cost: 15%)
"Check sudo privileges with 'sudo -l'. The find command has interesting capabilities..."

### Hint 6 - Vader (Cost: 20%)
"Search for SUID binaries. Custom binaries might have vulnerabilities."

### Hint 7 - Emperor (Cost: 20%)
"When systemctl opens a pager, you can execute commands by typing '!' followed by the command."

---

## 🔧 Deployment Considerations

### VM Requirements
- **OS**: Ubuntu 20.04 or 22.04 LTS
- **RAM**: 1GB minimum, 2GB recommended
- **Disk**: 10GB
- **CPU**: 1 core minimum

### Services to Enable
- SSH (port 22)
- Apache2 (port 8080)

### Auto-Start Services
```bash
systemctl enable apache2
systemctl enable ssh
```

### Firewall Configuration
```bash
# Allow SSH and HTTP
ufw allow 22/tcp
ufw allow 8080/tcp
ufw enable
```

---

## 📊 Estimated Difficulty Breakdown

| Phase | Difficulty | Time Estimate |
|-------|-----------|---------------|
| Initial Access | Medium | 20-30 min |
| Stormtrooper | Easy | 10 min |
| Imperial Officer | Medium | 15 min |
| Commander | Medium | 15-20 min |
| Vader | Hard | 20-30 min |
| Emperor | Medium-Hard | 15-25 min |
| **Total** | **Medium** | **2-3 hours** |

---

## 🎯 Target Audience

**Ideal For**:
- Users who completed "Linux PrivEsc" room
- Intermediate penetration testers
- Star Wars fans learning cybersecurity
- Those practicing for OSCP/CEH

**Prerequisites**:
- Basic Linux command line knowledge
- Understanding of file permissions
- Basic web exploitation concepts
- Familiarity with privilege escalation concepts

---

## ✅ Testing Checklist Before Submission

- [ ] Fresh VM deployment works with setup.sh
- [ ] All flags are accessible via the intended path
- [ ] No unintended shortcuts exist
- [ ] All services start on boot
- [ ] Web application loads correctly
- [ ] SSH is accessible
- [ ] Each privilege escalation step works
- [ ] No syntax errors in scripts
- [ ] Permissions are set correctly
- [ ] Story elements are present for each flag

---

## 📧 Submission Process

1. **Prepare the VM**
   - Build the VM using the setup script
   - Test all exploitation paths
   - Take a clean snapshot

2. **Create Room Content**
   - Write room description
   - Create task structure
   - Add hints
   - Upload any additional files

3. **Submit for Review**
   - Include walkthrough for reviewers
   - Document any special considerations
   - Provide expected difficulty and time estimates

4. **Address Feedback**
   - Be responsive to reviewer comments
   - Make requested adjustments
   - Test changes thoroughly

---

## 🌟 Unique Selling Points

1. **Immersive Star Wars Theme**: Full Rogue One storyline integration
2. **Progressive Storytelling**: Each flag advances the narrative
3. **Varied Techniques**: No repetitive privilege escalation methods
4. **Educational Value**: Real-world exploitation techniques
5. **Appropriate Difficulty**: Challenging but not frustrating
6. **Clean Design**: Well-documented and professionally presented

---

## 📝 Additional Notes for TryHackMe Staff

- All techniques demonstrated are real-world applicable
- The box teaches proper enumeration habits
- Difficulty curve is well-balanced
- Story makes it memorable and engaging
- Suitable for both learning and entertainment

---

**May the Force be with you in your submission!** ⭐

---

*For questions or issues, contact the creator via GitHub repository.*
