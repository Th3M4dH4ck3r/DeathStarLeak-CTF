# Death Star Leak CTF - File Structure

Overview of all files in this repository and their purposes.

---

## 📂 Repository Structure

```
DeathStarLeak-CTF/
│
├── 📄 README.md                    # Main project documentation
├── 📄 LICENSE                      # MIT License with Star Wars disclaimer
├── 📄 QUICKSTART.md                # Quick start guide for players and hosts
├── 📄 WALKTHROUGH.md               # Complete solution guide (SPOILERS!)
├── 📄 HINTS.md                     # Progressive hints for each level
├── 📄 STORY.md                     # Complete Star Wars narrative
├── 📄 RESOURCES.md                 # Learning resources and references
├── 📄 TRYHACKME_SUBMISSION.md      # Guide for TryHackMe submission
├── 📄 CONTRIBUTING.md              # Contribution guidelines
├── 📄 FILE_STRUCTURE.md            # This file
│
├── 🔧 setup.sh                     # Main setup script (run as root)
├── 🔧 test_ctf.sh                  # Testing script to verify setup
│
└── 📁 .git/                        # Git repository data
```

---

## 📝 File Descriptions

### Core Documentation

#### README.md
- **Purpose**: Main entry point for the repository
- **Audience**: Everyone
- **Content**:
  - Project overview and mission briefing
  - Rogue One storyline introduction
  - Deployment instructions for hosts
  - Player starting instructions
  - Rank structure and flag information
  - Difficulty level and learning objectives

#### QUICKSTART.md
- **Purpose**: Get started quickly without reading everything
- **Audience**: Players and hosts who want immediate action
- **Content**:
  - 3-step deployment for hosts
  - Quick attack plan for players
  - Essential commands cheat sheet
  - Flag checklist
  - Troubleshooting tips

#### LICENSE
- **Purpose**: Legal protection and Star Wars disclaimer
- **Type**: MIT License
- **Content**:
  - Open source MIT license
  - Star Wars trademark disclaimer
  - Fair use statement for educational purposes

---

### Player Guides

#### HINTS.md
- **Purpose**: Help players who get stuck
- **Format**: Collapsible spoilers for progressive revelation
- **Content**:
  - Hints for each privilege escalation level
  - 4 levels of hints per challenge (easy to solution)
  - General CTF tips and techniques
  - Links to external resources

#### WALKTHROUGH.md
- **Purpose**: Complete solution guide
- **Audience**: Stuck players, reviewers, instructors
- **Content**:
  - Step-by-step instructions for each level
  - All commands needed to solve
  - All 6 flags with stories
  - Techniques summary table
  - Skills learned section

#### STORY.md
- **Purpose**: Complete narrative experience
- **Audience**: Star Wars fans, immersive learners
- **Content**:
  - Full Rogue One-inspired storyline
  - Story segments for each flag
  - Character dialogues
  - Mission briefings and epilogue
  - ASCII art and formatting

#### RESOURCES.md
- **Purpose**: Learning materials and references
- **Audience**: Learners who want to improve
- **Content**:
  - Recommended learning path
  - Tool references and guides
  - Links to GTFOBins, HackTricks, etc.
  - Book recommendations
  - Community resources

---

### Host/Admin Documentation

#### TRYHACKME_SUBMISSION.md
- **Purpose**: Guide for submitting to TryHackMe
- **Audience**: CTF creators, TryHackMe reviewers
- **Content**:
  - Submission checklist
  - Suggested room information
  - Questions for TryHackMe tasks
  - Difficulty breakdown
  - VM requirements
  - Testing checklist

#### CONTRIBUTING.md
- **Purpose**: Guidelines for contributors
- **Audience**: Developers, contributors
- **Content**:
  - How to contribute
  - Development setup
  - Pull request process
  - Style guidelines
  - Security considerations
  - Code of conduct

#### FILE_STRUCTURE.md
- **Purpose**: Repository organization reference
- **Audience**: Contributors, maintainers
- **Content**: This file!

---

### Setup Scripts

#### setup.sh
- **Purpose**: Automated CTF environment deployment
- **Type**: Bash script (must run as root)
- **What it does**:
  - Installs required packages (Apache, PHP, MySQL, etc.)
  - Creates user accounts (stormtrooper, imperial-officer, commander, vader)
  - Sets up passwords and permissions
  - Generates all 6 flags
  - Creates web application with vulnerabilities
  - Configures Apache on port 8080
  - Sets up privilege escalation paths:
    - SSH keys for horizontal movement
    - Sudo misconfiguration for imperial-officer
    - SUID binary for vader escalation
    - Systemctl sudo for root escalation
  - Creates story files in home directories
  - Places flags in correct locations

**Key Features**:
- Idempotent (can be run multiple times safely)
- Error handling with `set -e`
- Progress indicators
- Final summary output

#### test_ctf.sh
- **Purpose**: Verify CTF is set up correctly
- **Type**: Bash script (can run as any user, some tests need root)
- **What it tests**:
  - Service status (Apache, SSH)
  - Port listening (8080, 22)
  - User account existence
  - File existence and permissions
  - Web application accessibility
  - Privilege escalation path configuration
  - Flag content verification
  - SUID binary setup
  - Sudo configuration

**Features**:
- Color-coded output (green/red/yellow)
- Pass/fail counters
- Detailed error reporting
- Exit codes for automation

---

## 🎯 File Purposes by Audience

### For Players

**Start here:**
1. `README.md` - Understand the mission
2. `QUICKSTART.md` - Begin attacking

**When stuck:**
3. `HINTS.md` - Get progressive hints
4. `RESOURCES.md` - Learn required techniques

**Complete solution:**
5. `WALKTHROUGH.md` - Full solution (spoilers!)

**For immersion:**
6. `STORY.md` - Complete narrative

### For CTF Hosts

**Deployment:**
1. `README.md` - Overview
2. `setup.sh` - Run this to deploy
3. `test_ctf.sh` - Verify deployment

**Review:**
4. `WALKTHROUGH.md` - Understand solutions
5. `TRYHACKME_SUBMISSION.md` - Platform submission

### For Contributors

**Getting started:**
1. `README.md` - Project overview
2. `CONTRIBUTING.md` - How to contribute
3. `FILE_STRUCTURE.md` - Repository organization

**Development:**
4. `setup.sh` - Understand deployment
5. `test_ctf.sh` - Testing framework

---

## 🔍 Important Paths Created by Setup

### User Home Directories

```
/home/stormtrooper/
├── flag.txt                    # Flag 2
├── message.txt                 # Contains credentials
└── .backup/
    └── officer_key             # SSH key for imperial-officer

/home/imperial-officer/
├── flag.txt                    # Flag 3
├── orders.txt                  # Story element
├── note.txt                    # Hint about sudo
└── .ssh/
    ├── id_rsa                  # Private key
    ├── id_rsa.pub              # Public key
    └── authorized_keys         # For SSH access

/home/commander/
├── flag.txt                    # Flag 4
├── briefing.txt                # Story element
└── systems.txt                 # Hint about scanner

/home/vader/
├── flag.txt                    # Flag 5
├── meditation.txt              # Story element
└── instructions.txt            # Hints
```

### Web Application

```
/var/www/deathstar/
├── index.php                   # Main page with command injection
├── upload.php                  # Hidden upload (bonus)
├── first_access_flag.txt       # Flag 1
└── hint.txt                    # Initial hint
```

### System Binaries

```
/usr/local/bin/
└── deathstar_scanner           # SUID binary owned by vader
```

### Root Files

```
/root/emperor_vault/
└── death_star_plans.txt        # Flag 6 (root flag)
```

---

## 📊 File Size Estimates

| File | Approximate Size | Lines |
|------|-----------------|-------|
| README.md | ~5 KB | 130 |
| WALKTHROUGH.md | ~15 KB | 450 |
| STORY.md | ~12 KB | 400 |
| HINTS.md | ~8 KB | 250 |
| RESOURCES.md | ~10 KB | 350 |
| TRYHACKME_SUBMISSION.md | ~8 KB | 300 |
| QUICKSTART.md | ~6 KB | 200 |
| CONTRIBUTING.md | ~7 KB | 280 |
| setup.sh | ~12 KB | 400 |
| test_ctf.sh | ~5 KB | 150 |

**Total Documentation**: ~88 KB, ~2,910 lines

---

## 🔄 Version History

### v1.0.0 (Initial Release)
- All core files created
- Complete privilege escalation chain
- Full documentation
- TryHackMe ready

---

## 📝 File Maintenance

### Regular Updates Needed

- **RESOURCES.md**: Keep links current
- **WALKTHROUGH.md**: Update if exploitation paths change
- **README.md**: Version information

### Stable Files

- **STORY.md**: Story rarely changes
- **LICENSE**: Legal text is fixed
- **FILE_STRUCTURE.md**: Updated when files added/removed

---

## 🎯 Quick Reference

### "I want to..."

| Goal | Files to Read |
|------|---------------|
| Deploy the CTF | `QUICKSTART.md`, `setup.sh` |
| Play the CTF | `README.md`, `QUICKSTART.md` |
| Get hints | `HINTS.md` |
| See the solution | `WALKTHROUGH.md` |
| Learn techniques | `RESOURCES.md` |
| Enjoy the story | `STORY.md` |
| Submit to TryHackMe | `TRYHACKME_SUBMISSION.md` |
| Contribute | `CONTRIBUTING.md` |
| Understand structure | `FILE_STRUCTURE.md` |

---

## 🛠️ Development Files

### Not Committed to Repository

```
.gitignore                      # Ignore patterns
CONTRIBUTORS.md                 # List of contributors
CHANGELOG.md                    # Version history
```

### Future Additions

Planned files for future versions:
- `CHANGELOG.md` - Detailed version history
- `CONTRIBUTORS.md` - Recognition for contributors
- `FAQ.md` - Frequently asked questions
- `SOLUTIONS/` - Alternative solution paths
- `DOCKER/` - Dockerized deployment option

---

## 📦 Distribution

### For Git Clone
All files are included in the repository.

### For TryHackMe
Upload to platform:
- VM with CTF pre-deployed
- README.md for room description
- Questions from TRYHACKME_SUBMISSION.md

### For Offline Use
Download entire repository:
```bash
git clone https://github.com/your-repo/DeathStarLeak-CTF.git
```

---

## 🔐 Sensitive Files

### No Secrets in Repository

All flags are generated during setup.sh execution:
- Not hardcoded in repository
- Regenerated each deployment
- Customizable if needed

### Password Policy

Default passwords are documented for educational purposes:
- `stormtrooper:tk421isdown` (intentionally weak)
- Other users have random passwords
- Change if deploying in semi-public environments

---

**May the Force be with you!** ⭐

---

*Last updated: 2024*
*For the latest version, see the repository*
