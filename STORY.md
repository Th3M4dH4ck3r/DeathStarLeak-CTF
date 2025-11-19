# Death Star Leak - The Complete Story

*A Rogue One: A Star Wars Story Inspired CTF Adventure*

---

## 🎬 Opening Crawl

```
A long time ago in a galaxy far, far away....

                STAR WARS
        OPERATION STARDUST

    It is a period of civil war. The
    Empire has constructed the ultimate
    weapon - the DEATH STAR, a battle
    station with enough power to
    destroy an entire planet.

    Rebel spies have learned that the
    technical plans to the station are
    hidden deep within the Imperial
    network, protected by layers of
    security clearances.

    Your mission: Infiltrate the Death
    Star's systems and steal the plans
    that could save the Rebellion and
    restore freedom to the galaxy....
```

---

## 📖 The Mission Briefing

**Location**: Rebel Base, Yavin 4

**Rebel Leader**: "We've received intelligence from Galen Erso, the scientist forced to build the Death Star. Before his death, he sent a message - he's hidden a weakness in the design. But we need the complete technical plans to find it."

**Mon Mothma**: "This is our only chance. If the Death Star becomes fully operational, the Empire will crush the Rebellion. We cannot let that happen."

**Admiral Raddus**: "We're authorizing a covert mission - Operation Stardust. Your team will infiltrate the Imperial network and retrieve the plans from the Emperor's vault."

**Jyn Erso**: "My father spent years building this weapon. He wouldn't have done it without a reason. I'm going to finish what he started."

**Cassian Andor**: "We'll need to breach their security systems. The Empire uses a hierarchical access control system. We'll have to climb through their ranks."

**K-2SO**: "I calculate your chances of success at approximately 2.4%. However, I've been wrong before."

---

## 🚀 Chapter 1: The Infiltration

**Location**: Death Star - Outer Perimeter

**Jyn Erso**: "We're approaching the Death Star. Their sensors are everywhere."

**Bodhi Rook**: "I'm transmitting our stolen Imperial codes now. They should buy us enough time to find a weakness in their network."

**K-2SO**: "Their web interface is accessible on port 8080. It appears to be a personnel management system."

**Cassian**: "Let's see if their security is as strong as they think. Look for any development features they might have left enabled."

**Chirrut Îmwe**: "The Force is with us. Trust in it."

*[Team discovers the debug parameter in the Imperial web application]*

**K-2SO**: "Interesting. Their debug mode reveals command execution capabilities. I'm detecting a severe command injection vulnerability."

**Jyn**: "Then let's use it. Get us inside their network."

---

## 🎯 Flag 1: Initial Access

**System Access**: www-data

*[Shell access established]*

**K-2SO**: "We're in. Limited access, but it's a start."

**Cassian**: "This is just the outer layer. We need to go deeper."

**Jyn**: "The plans won't be accessible from this level. We need to find a way to access the stormtrooper accounts."

**Baze Malbus**: "I count at least four security levels between us and the Emperor's vault."

**Jyn**: "Then we'll breach all four. For my father. For the Rebellion."

**🏆 FLAG CAPTURED**: `DSL{w3lc0m3_t0_th3_d3ath_st4r_r3b3l}`

---

## 👤 Chapter 2: The Stormtrooper

**Location**: Death Star - Personnel Files

**K-2SO**: "I'm accessing the personnel database. There's a stormtrooper designation TK-421 with security clearance to restricted areas."

**Cassian**: "See if you can find his credentials."

*[Team discovers message.txt in stormtrooper's directory]*

**Jyn**: "Got it. TK-421's access code is 'tk421isdown'. The Empire's security is sloppy."

**Bodhi**: "They have thousands of stormtroopers. They probably don't expect anyone to track individual credentials."

*[SSH access as stormtrooper established]*

**Imperial Officer** *(over comms)*: "TK-421, why aren't you at your post?"

*[Silence]*

**Imperial Officer**: "TK-421, do you copy?"

**Jyn** *(whispering)*: "We're in position. The stormtrooper armor worked, but we can't stay hidden long. We need to escalate to officer clearance."

---

## 🎯 Flag 2: Stormtrooper Access

**Cassian**: "Check TK-421's personal files. Imperial officers are often careless with security protocols."

**K-2SO**: "Scanning... I've found a backup directory containing what appears to be an SSH private key for an Imperial Officer."

**Jyn**: "The Empire's arrogance is their weakness. They never expected rebels to get this far."

**Chirrut**: "The Force guides those who seek the light."

**🏆 FLAG CAPTURED**: `DSL{tk421_why_4r3nt_y0u_4t_y0ur_p0st}`

---

## 🎖️ Chapter 3: The Imperial Officer

**Location**: Death Star - Command Level

**Bodhi**: "Using the stolen key now... Access granted. We're in as Imperial Officer Lieutenant Renz."

**Jyn**: "What's our clearance level?"

**K-2SO**: "Significantly improved. Lieutenant Renz has oversight of multiple sections. He also has sudo privileges for certain system commands."

**Cassian**: "That could be our ticket to Commander access. We need to reach Tarkin's level."

**Baze**: "I'm picking up increased security chatter. They might be onto us."

**Jyn**: "Then we move fast. K-2, what can this officer account do?"

**K-2SO**: "Lieutenant Renz can execute the 'find' command as the commander user. Interesting... the Empire didn't properly restrict what the find command can do."

---

## 🎯 Flag 3: Imperial Officer Clearance

**Cassian**: "The find command can execute other programs. It's a classic privilege escalation technique."

**Jyn**: "Can we use it to access Tarkin's files?"

**K-2SO**: "Affirmative. Exploiting now..."

*[Privilege escalation to commander successful]*

**Jyn**: "We're getting closer. I can feel it."

**🏆 FLAG CAPTURED**: `DSL{1mp3r14l_0ff1c3r_cl34r4nc3_gr4nt3d}`

---

## ⭐ Chapter 4: The Commander

**Location**: Death Star - Strategic Command

**Grand Moff Tarkin** *(in recording)*: "You may fire when ready."

*[Holographic display shows the destruction of Jedha City]*

**Jyn**: "The power... it's worse than we thought. This weapon can destroy entire cities in seconds."

**Cassian**: "And they're not going to stop with Jedha. We NEED those plans."

**K-2SO**: "We're now operating at Commander Tarkin's access level. Only two more security clearances remain: Lord Vader and the Emperor himself."

**Bodhi**: "How do we get past Darth Vader? He's not just a user account - he's the Dark Lord of the Sith."

**K-2SO**: "Examining Tarkin's files... There's a system scanner utility with elevated permissions. It runs with Vader's security context."

**Baze**: "If it's vulnerable, we could exploit it to assume Vader's identity in the system."

---

## 🎯 Flag 4: Commander Authority

**Jyn**: "My father built this station. He knew the Empire would try to protect it with layers of security. But every security system has flaws."

**Chirrut**: "The Force flows through all things. Even Imperial security systems."

**Cassian**: "The scanner binary - let's analyze it."

**K-2SO**: "I've detected a critical vulnerability. The scanner doesn't properly sanitize input before executing system commands."

**Jyn**: "Then we exploit it. For every life the Empire has taken, we fight back."

**🏆 FLAG CAPTURED**: `DSL{t4rk1n_y0u_m4y_f1r3_wh3n_r34dy}`

---

## ⚫ Chapter 5: The Dark Lord

**Location**: Death Star - Vader's Chambers

*[Meditation chamber opens, revealing Vader's scarred face]*

**Darth Vader** *(in meditation)*: "The Force is strong with the Emperor. Together, we will rule the galaxy."

*[Team accesses Vader's terminal]*

**Jyn**: "We've accessed Vader's systems. The Emperor's vault is within reach."

**Cassian**: "I'm reading high-level security protocols. Vader has near-unlimited access."

**K-2SO**: "Lord Vader possesses sudo privileges for system service management. There may be a path to root access through the systemctl command."

**Bodhi**: "The Force may not be with us, but we have something better - determination."

**Chirrut**: "The Force IS with us. I feel it. We're close to the plans."

---

## 🎯 Flag 5: Vader's Power

**Baze**: "We're in the lion's den now. One wrong move and we're dead."

**Jyn**: "We've come too far to turn back. My father died to give us this chance."

**Cassian**: "The systemctl command uses a pager for long output. If we can trigger it..."

**K-2SO**: "Pagers like 'less' allow command execution. It's a known escalation vector. Attempting exploitation..."

*[Privilege escalation to root initiated]*

**Jyn**: "This is it. The Emperor's vault. Everything we've fought for."

**🏆 FLAG CAPTURED**: `DSL{1_f1nd_y0ur_l4ck_0f_f41th_d1sturb1ng}`

---

## 👑 Chapter 6: The Emperor's Vault

**Location**: Death Star - Emperor's Personal Archive

*[Massive vault doors slide open with a hiss]*

**Jyn**: "We're in. We actually made it."

**K-2SO**: "Congratulations. The odds of success were 3,720 to 1. I'm pleasantly surprised."

**Cassian**: "Search for the Death Star plans. Quickly!"

*[Holographic blueprints materialize]*

**Jyn**: "These are them. The complete technical specifications."

*[A hidden message appears in the plans]*

**Galen Erso** *(recorded message)*: "Jyn, if you're seeing this, then you've found what you were looking for. I've spent years working on this project, not because I wanted to, but because I had no choice. But I DID have a choice in how I built it."

"I've placed a weakness deep within the system. A flaw so small, the Empire would never notice it. But one precise strike, and the entire station will tear itself apart."

"The thermal exhaust port, right below the main port. Two meters wide. It leads directly to the reactor core. One proton torpedo, precisely placed, will start a chain reaction."

**Jyn**: "He did it. He actually did it. My father saved the Rebellion."

---

## 🎯 Flag 6: The Emperor's Secret

**Bodhi**: "I'm transmitting the plans to the Rebel Fleet now!"

**Admiral Raddus** *(over comms)*: "We're receiving the transmission! The plans are coming through!"

**Cassian**: "We need to get out of here. The Empire will detect the breach any second."

**Chirrut**: "The Force is with us."

**Baze**: "And I'm one with the Force."

*[Death Star alarms begin to sound]*

**Imperial Officer**: "Intruder alert! Sector 7-G! Lock down all systems!"

**Darth Vader**: "The Rebel fleet is preparing to jump to hyperspace. I want that ship boarded and the plans recovered. NOW!"

**Jyn**: "We did it. The plans are safe. The Rebellion has hope."

**K-2SO**: "Statistically speaking, we should all be dead. I'm glad my calculations were incorrect."

**🏆 FINAL FLAG CAPTURED**: `DSL{unl1m1t3d_p0w3r_th3_pl4ns_4r3_y0urs}`

---

## 🎬 Epilogue: A New Hope

**Location**: Rebel Fleet, Above Scarif

**Admiral Raddus**: "Rogue One, the plans are safely in our hands. Your sacrifice will not be forgotten."

**Mon Mothma**: "Thanks to the bravery of Jyn Erso and her team, we now know the Death Star's weakness. This is our chance to strike back at the Empire."

*[Plans are loaded onto a data disk]*

**Rebel Soldier**: "Your Highness, we've loaded the plans onto the Tantive IV."

**Princess Leia** *(taking the disk)*: "Hope. This Rebellion is built on hope. And now, we have a chance to destroy the Empire's ultimate weapon."

*[Tantive IV jumps to hyperspace]*

---

## 🌟 The Legacy

The plans you've stolen will make their way to a young farm boy on Tatooine. Luke Skywalker will use them to identify the exhaust port and destroy the Death Star, saving the Rebellion and bringing balance to the Force.

But that's another story...

Your journey through the Imperial ranks:

✅ **Infiltrator** → Breached the outer network
✅ **Stormtrooper** → Compromised TK-421's account
✅ **Imperial Officer** → Assumed Lieutenant Renz's identity
✅ **Commander** → Wielded Grand Moff Tarkin's authority
✅ **Darth Vader** → Harnessed the Dark Lord's power
✅ **Emperor** → Breached the ultimate security

---

## 💭 Final Words

**Jyn Erso**: "Rebellions are built on hope."

**Galen Erso**: "I've placed a flaw in the design. Use it well."

**Chirrut Îmwe**: "The Force is with you. Always."

**K-2SO**: "Your chances of survival were minimal. You succeeded anyway. I'm proud of you."

---

```
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║                    MISSION ACCOMPLISHED                       ║
║                                                              ║
║  The Death Star plans are in Rebel hands. Hope has been      ║
║  restored to the galaxy. The Empire's ultimate weapon has    ║
║  a fatal flaw, and the Rebellion now knows how to exploit    ║
║  it.                                                         ║
║                                                              ║
║  May the Force be with you, always.                          ║
║                                                              ║
╔══════════════════════════════════════════════════════════════╗
```

---

**THE END**

*Thank you for playing Death Star Leak CTF*

*May the Force be with you!* ⭐

---

## 🎵 Credits Roll

**CTF Created By**: The Rebel Alliance Cyber Division

**Inspired By**:
- Rogue One: A Star Wars Story
- The Original Trilogy
- The countless rebels who fight for freedom

**Special Thanks To**:
- George Lucas - For creating Star Wars
- Gareth Edwards - For directing Rogue One
- The TryHackMe Community
- All CTF enthusiasts and hackers

**Dedicated To**:
Everyone who believes that rebellions are built on hope.

---

*"The Force will be with you. Always."* - Obi-Wan Kenobi
