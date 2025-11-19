# Death Star Leak - CTF Challenge

```
    ⭐ STAR WARS: OPERATION STARDUST ⭐

         .
        / \
       /   \
      /  |  \
     /   |   \
    |    |    |
    |  .-'-.  |
    | /     \ |
    |/       \|
    |\       /|
    | \     / |
    |  '---'  |
    |    |    |
     \   |   /
      \  |  /
       \ | /
        \|/
         '
    DEATH STAR - IMPERIAL NETWORK
```

## 🎯 Mission Briefing

**Classification Level:** TOP SECRET
**Operation Name:** STARDUST
**Mission Objective:** Infiltrate the Death Star's Imperial network and retrieve the station plans

The Rebellion has learned that the Empire's ultimate weapon - the Death Star - is operational. Intelligence reports indicate that the complete technical plans are hidden deep within the station's network, protected by layers of Imperial security.

Your mission, should you choose to accept it, is to infiltrate the Death Star's systems as a Rebel spy. You must work your way through the ranks of Imperial security clearances to reach the Emperor's vault where the plans are stored.

## 🎬 The Story

This CTF follows the journey of **Jyn Erso and the Rogue One team** as they attempt to steal the Death Star plans. Each privilege escalation represents climbing through the Imperial hierarchy, from lowly Stormtrooper to the Emperor himself.

## 🏆 Difficulty Level

**Intermediate** - Suitable for users with basic Linux and pentesting knowledge

## 🎯 Learning Objectives

- Web application exploitation
- Linux privilege escalation techniques
- Password cracking
- File permission exploitation
- SUID binary exploitation
- Sudo misconfiguration
- Cron job exploitation
- SSH key management
- Binary analysis

## 📊 Rank Structure

Your journey through the Imperial hierarchy:

1. 🚀 **External Access** - Rebel Infiltrator
2. 👤 **Stormtrooper** - TK-421 (Low-level grunt)
3. 🎖️ **Imperial Officer** - Lieutenant Renz
4. ⭐ **Commander** - Grand Moff Tarkin
5. ⚫ **Darth Vader** - Dark Lord of the Sith
6. 👑 **Emperor** - Darth Sidious (ROOT)

Each rank contains a flag in the format: `DSL{...}`

## 🚀 Deployment Instructions

### For CTF Hosts

1. Clone this repository
2. Run the setup script as root:
```bash
sudo ./setup.sh
```

3. The script will:
   - Create all necessary user accounts
   - Set up the web application
   - Configure privilege escalation paths
   - Place flags in appropriate locations
   - Set correct permissions

4. Access the box at `http://<IP_ADDRESS>:8080`

### For Players

1. Start by scanning the target machine
2. Find the entry point (web application on port 8080)
3. Gain initial access
4. Escalate through each rank to reach Emperor (root)
5. Collect all 6 flags

## 🎯 Flags

There are **6 flags** total:
- Flag 1: Initial access
- Flag 2: Stormtrooper
- Flag 3: Imperial Officer
- Flag 4: Commander
- Flag 5: Darth Vader
- Flag 6: Emperor (Root)

## ⚠️ Disclaimer

This is a CTF challenge for educational purposes only. All techniques demonstrated should only be used in authorized testing environments.

## 📝 Credits

Created for the cybersecurity community
Theme: Star Wars - Rogue One
May the Force be with you!

---

*"Rebellions are built on hope."* - Jyn Erso
