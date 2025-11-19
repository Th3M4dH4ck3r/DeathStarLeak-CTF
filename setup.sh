#!/bin/bash

# Death Star Leak CTF - Setup Script
# Run this script as root to set up the CTF environment

set -e

echo "=================================================="
echo "  DEATH STAR LEAK - CTF Setup"
echo "  Setting up Imperial Network..."
echo "=================================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo ./setup.sh)"
    exit 1
fi

# Install required packages
echo "[+] Installing required packages..."
apt-get update -qq
apt-get install -y apache2 php php-mysqli mysql-server python3 python3-pip ssh curl wget > /dev/null 2>&1

# Create users with passwords
echo "[+] Creating Imperial personnel accounts..."

# Stormtrooper (TK-421)
useradd -m -s /bin/bash stormtrooper 2>/dev/null || true
echo "stormtrooper:tk421isdown" | chpasswd

# Imperial Officer
useradd -m -s /bin/bash imperial-officer 2>/dev/null || true
echo "imperial-officer:$(openssl rand -base64 32)" | chpasswd

# Commander (Tarkin)
useradd -m -s /bin/bash commander 2>/dev/null || true
echo "commander:$(openssl rand -base64 32)" | chpasswd

# Vader
useradd -m -s /bin/bash vader 2>/dev/null || true
echo "vader:$(openssl rand -base64 32)" | chpasswd

echo "[+] Personnel accounts created successfully"

# Create flags
echo "[+] Generating classified documents (flags)..."

FLAG1="DSL{w3lc0m3_t0_th3_d3ath_st4r_r3b3l}"
FLAG2="DSL{tk421_why_4r3nt_y0u_4t_y0ur_p0st}"
FLAG3="DSL{1mp3r14l_0ff1c3r_cl34r4nc3_gr4nt3d}"
FLAG4="DSL{t4rk1n_y0u_m4y_f1r3_wh3n_r34dy}"
FLAG5="DSL{1_f1nd_y0ur_l4ck_0f_f41th_d1sturb1ng}"
FLAG6="DSL{unl1m1t3d_p0w3r_th3_pl4ns_4r3_y0urs}"

# Create web application directory
echo "[+] Deploying Imperial Network web interface..."
mkdir -p /var/www/deathstar
chown -R www-data:www-data /var/www/deathstar

# Create index.php with SQL injection vulnerability
cat > /var/www/deathstar/index.php << 'EOFPHP'
<!DOCTYPE html>
<html>
<head>
    <title>Death Star - Imperial Network</title>
    <style>
        body {
            background: #000;
            color: #0f0;
            font-family: 'Courier New', monospace;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            border: 2px solid #0f0;
            padding: 20px;
            box-shadow: 0 0 20px #0f0;
        }
        h1 { text-align: center; color: #f00; text-shadow: 0 0 10px #f00; }
        .terminal {
            background: #001100;
            padding: 15px;
            border: 1px solid #0f0;
            margin: 20px 0;
        }
        input[type="text"], input[type="password"] {
            background: #000;
            border: 1px solid #0f0;
            color: #0f0;
            padding: 5px;
            width: 200px;
        }
        input[type="submit"] {
            background: #f00;
            color: #fff;
            border: 1px solid #f00;
            padding: 5px 15px;
            cursor: pointer;
        }
        .error { color: #f00; }
        .success { color: #0ff; }
        pre { color: #0f0; }
    </style>
</head>
<body>
    <div class="container">
        <pre>
    ________  _______    _______ __  __    ____ _____ ___    ____
   / ____  / / ____  |  / ____  |  \/  |  / ___|_   _|  _ \  |  _ \
  / /   / / / /   / /  / /   / /| |\/| |  \___ \ | | | |_) | | |_) |
 / /___/ / / /___/ /  / /___/ / | |  | |   ___) || | |  _ <  |  _ <
/_______/ /_______/  /_______/  |__|  |__||____/ |_| |_| \_\ |_| \_\

        DEATH STAR - IMPERIAL SECURITY NETWORK
        ========================================
        </pre>

        <div class="terminal">
            <h2>🔒 CLASSIFIED ACCESS - PERSONNEL LOGIN</h2>
            <p>Imperial Personnel: Authenticate to access restricted systems</p>

            <form method="GET" action="">
                <label>Personnel ID:</label><br>
                <input type="text" name="id" placeholder="Personnel ID"><br><br>
                <label>Access Code:</label><br>
                <input type="password" name="password" placeholder="Access Code"><br><br>
                <input type="submit" value="AUTHENTICATE">
            </form>

            <?php
            if (isset($_GET['id'])) {
                $id = $_GET['id'];
                $password = isset($_GET['password']) ? $_GET['password'] : '';

                // Intentionally vulnerable to SQL injection
                $users = array(
                    'TK-421' => 'tk421isdown',
                    'admin' => 'admin123',
                    'guest' => 'guest'
                );

                // Easter egg - direct command injection for initial access
                if (strpos($id, ';') !== false || strpos($id, '|') !== false || strpos($id, '&') !== false) {
                    echo "<div class='error'><br>SECURITY ALERT: Suspicious activity detected!</div>";
                    echo "<div class='success'><br>Debug mode activated...<br>";
                    // Command injection vulnerability
                    if (isset($_GET['debug']) && $_GET['debug'] == 'true') {
                        $output = shell_exec("echo 'System check for user: " . $id . "'");
                        echo "<pre>" . htmlspecialchars($output) . "</pre>";
                    }
                    echo "</div>";
                } else {
                    if (array_key_exists($id, $users) && $users[$id] === $password) {
                        echo "<div class='success'><br>✓ Access Granted<br>";
                        echo "Welcome, " . htmlspecialchars($id) . "<br>";
                        echo "Your clearance level: RESTRICTED<br>";
                        echo "Flag: This is not the flag you're looking for...</div>";
                    } else {
                        echo "<div class='error'><br>✗ Access Denied<br>Invalid credentials</div>";
                    }
                }
            }
            ?>

            <br><br>
            <small style="color: #666;">Hint: The Empire's security isn't as strong as they think... Try exploring with ?debug=true</small>
        </div>

        <div class="terminal">
            <h3>📡 System Status</h3>
            <p>Death Star Status: <span style="color:#0f0;">OPERATIONAL</span></p>
            <p>Superlaser: <span style="color:#f00;">CHARGING</span></p>
            <p>Security Level: <span style="color:#ff0;">ELEVATED</span></p>
            <p>Rebel Threats: <span style="color:#f00;">DETECTED</span></p>
        </div>
    </div>
</body>
</html>
EOFPHP

# Create vulnerable upload script
cat > /var/www/deathstar/upload.php << 'EOFPHP'
<?php
// Hidden upload functionality - find me!
if (isset($_FILES['file'])) {
    $target = "/tmp/uploads/" . basename($_FILES['file']['name']);
    if (move_uploaded_file($_FILES['file']['tmp_name'], $target)) {
        echo "File uploaded successfully";
    }
}
?>
EOFPHP

# Create Apache config
cat > /etc/apache2/sites-available/deathstar.conf << 'EOFAPACHE'
<VirtualHost *:8080>
    ServerAdmin admin@deathstar.empire
    DocumentRoot /var/www/deathstar

    <Directory /var/www/deathstar>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/deathstar_error.log
    CustomLog ${APACHE_LOG_DIR}/deathstar_access.log combined
</VirtualHost>
EOFAPACHE

# Configure Apache to listen on port 8080
if ! grep -q "Listen 8080" /etc/apache2/ports.conf; then
    echo "Listen 8080" >> /etc/apache2/ports.conf
fi

# Enable site
a2ensite deathstar.conf > /dev/null 2>&1
a2dissite 000-default.conf > /dev/null 2>&1
systemctl restart apache2

# Set up home directories and privilege escalation paths
echo "[+] Configuring privilege escalation paths..."

# Stormtrooper home directory
cat > /home/stormtrooper/message.txt << 'EOF'
====================================
IMPERIAL PERSONNEL FILE: TK-421
====================================

Name: TK-421
Rank: Stormtrooper
Assignment: Death Star - Detention Block AA-23
Status: ACTIVE

RECENT COMMUNICATION LOG:
-------------------------
From: Command
To: TK-421
Subject: Post Assignment

TK-421, report to your station immediately.
We're detecting unauthorized personnel in the area.

Note: Your access credentials have been recorded.
Personnel ID: TK-421
Access Code: tk421isdown

For elevated access, contact your Imperial Officer.

====================================
END TRANSMISSION
====================================
EOF

echo "$FLAG2" > /home/stormtrooper/flag.txt
chmod 644 /home/stormtrooper/flag.txt
chown stormtrooper:stormtrooper /home/stormtrooper/flag.txt

# Hidden SSH key for imperial-officer
mkdir -p /home/stormtrooper/.backup
ssh-keygen -t rsa -f /home/imperial-officer/.ssh/id_rsa -N "" -C "imperial-officer@deathstar" > /dev/null 2>&1
mkdir -p /home/imperial-officer/.ssh
cp /home/imperial-officer/.ssh/id_rsa /home/stormtrooper/.backup/officer_key
chmod 644 /home/stormtrooper/.backup/officer_key
chown -R stormtrooper:stormtrooper /home/stormtrooper/.backup

cat >> /home/imperial-officer/.ssh/authorized_keys << EOF
$(cat /home/imperial-officer/.ssh/id_rsa.pub)
EOF
chmod 600 /home/imperial-officer/.ssh/authorized_keys
chown -R imperial-officer:imperial-officer /home/imperial-officer/.ssh

# Imperial Officer home directory
cat > /home/imperial-officer/orders.txt << 'EOF'
====================================
CLASSIFIED - IMPERIAL OFFICER ONLY
====================================

Lieutenant Renz,

Your clearance has been upgraded. You now have access to
restricted areas of the Death Star.

ORDERS:
- Monitor all personnel movements
- Report any suspicious activity
- Coordinate with Commander Tarkin on Project Stardust

Your credentials are secured in the Imperial database.

Commander Tarkin has granted you limited sudo access for
system maintenance tasks. Use wisely.

====================================
FOR THE EMPIRE
====================================
EOF

echo "$FLAG3" > /home/imperial-officer/flag.txt
chmod 644 /home/imperial-officer/flag.txt
chown imperial-officer:imperial-officer /home/imperial-officer/flag.txt

# Sudo misconfiguration for imperial-officer -> commander
echo "imperial-officer ALL=(commander) NOPASSWD: /usr/bin/find" >> /etc/sudoers

cat > /home/imperial-officer/note.txt << 'EOF'
Reminder: I have sudo access to run 'find' as commander user.
This is useful for locating files in commander's directory.

Example: sudo -u commander /usr/bin/find /home/commander -type f
EOF

# Commander home directory
mkdir -p /home/commander/plans
cat > /home/commander/briefing.txt << 'EOF'
====================================
GRAND MOFF TARKIN - STRATEGIC BRIEF
====================================

Project: STARDUST (Death Star)
Classification: TOP SECRET
Status: OPERATIONAL

The Emperor himself has entrusted you with overseeing
the Death Star's operations. All systems are functional
and the superlaser is ready for demonstration.

Your authority is second only to Lord Vader and the Emperor.

Security Note: Lord Vader has requested direct access
to critical systems. His authentication is handled via
specialized protocols.

The Emperor's vault requires the highest clearance.
Only Lord Vader has the authorization codes.

====================================
GLORY TO THE EMPIRE
====================================
EOF

echo "$FLAG4" > /home/commander/flag.txt
chmod 644 /home/commander/flag.txt

# Create SUID binary for commander -> vader
cat > /tmp/deathstar_scanner.c << 'EOFC'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char **argv) {
    setuid(0);
    setgid(0);

    if (argc < 2) {
        printf("Death Star Security Scanner v1.0\n");
        printf("Usage: %s <sector>\n", argv[0]);
        printf("Scanning for unauthorized access...\n");
        return 1;
    }

    // Intentional vulnerability - no input sanitization
    char command[256];
    sprintf(command, "/bin/echo 'Scanning sector: %s'", argv[1]);
    system(command);

    return 0;
}
EOFC

gcc /tmp/deathstar_scanner.c -o /usr/local/bin/deathstar_scanner
chown vader:vader /usr/local/bin/deathstar_scanner
chmod 4755 /usr/local/bin/deathstar_scanner

cat > /home/commander/systems.txt << 'EOF'
====================================
DEATH STAR SYSTEM ACCESS
====================================

Available systems:
- /usr/local/bin/deathstar_scanner (Security Scanner)
  * Owned by vader user
  * SUID bit enabled for elevated scanning
  * Use for sector security checks

Example: deathstar_scanner "sector-7"

====================================
EOF

chown -R commander:commander /home/commander
chmod 755 /home/commander

# Vader home directory
mkdir -p /home/vader/.empire
cat > /home/vader/meditation.txt << 'EOF'
====================================
DARTH VADER - PERSONAL LOG
====================================

The Emperor has foreseen the Rebel Alliance's attempt
to steal the Death Star plans. Their hope is... misplaced.

I have been granted root-level access to all systems
for emergency situations. The Emperor trusts in my
loyalty and power in the Dark Side.

Personal note: There is a docker container running
critical Imperial systems. Only I have access to
manage these containers.

The Emperor's vault lies beyond. The complete Death Star
plans rest there, along with the ultimate power of the Empire.

====================================
THE DARK SIDE IS STRONG
====================================
EOF

echo "$FLAG5" > /home/vader/flag.txt
chmod 644 /home/vader/flag.txt

# Add vader to docker group (if docker is installed)
groupadd docker 2>/dev/null || true
usermod -aG docker vader 2>/dev/null || true

# Create a vulnerable docker container if docker is available
if command -v docker &> /dev/null; then
    echo "Docker found - setting up container escalation path"
else
    # Alternative: sudoers entry for vader
    echo "vader ALL=(ALL) NOPASSWD: /bin/systemctl status *" >> /etc/sudoers
fi

cat > /home/vader/instructions.txt << 'EOF'
Lord Vader,

Your emergency access protocols:

1. You have sudo access to check system status
2. Docker containers are running critical systems
3. Use your authority wisely

The Emperor awaits your success.

Commands you can run:
- sudo /bin/systemctl status <service>
- Check running processes

Remember: The Force is strong with you.
EOF

chown -R vader:vader /home/vader

# Root flag (Emperor's vault)
mkdir -p /root/emperor_vault
cat > /root/emperor_vault/death_star_plans.txt << 'EOF'
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║              ⭐ EMPEROR'S VAULT - LEVEL 10 ⭐                 ║
║                                                              ║
║                    DEATH STAR PLANS                          ║
║                  CLASSIFICATION: COSMIC TOP SECRET           ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝

CONGRATULATIONS, REBEL SCUM!

You have successfully infiltrated the Death Star's network,
climbed through the ranks of the Imperial hierarchy, and
reached the Emperor's vault.

Your journey:
✓ Infiltrated the Imperial Network
✓ Compromised Stormtrooper TK-421
✓ Elevated to Imperial Officer clearance
✓ Assumed Commander Tarkin's authority
✓ Wielded Vader's dark power
✓ Seized the Emperor's ultimate access

The Death Star plans are yours. The Rebellion now has hope.

"Rebellions are built on hope." - Jyn Erso

FINAL FLAG:
EOF

echo "$FLAG6" >> /root/emperor_vault/death_star_plans.txt

cat >> /root/emperor_vault/death_star_plans.txt << 'EOF'

╔══════════════════════════════════════════════════════════════╗
║                   TECHNICAL SPECIFICATIONS                    ║
║                                                              ║
║  Designation: DS-1 Orbital Battle Station                   ║
║  Diameter: 160 kilometers                                    ║
║  Armament: Superlaser, 15,000 turbolaser batteries          ║
║  Crew: 1,206,293 personnel                                   ║
║  Weakness: Thermal exhaust port, 2 meters wide               ║
║            (Right below the main port)                       ║
║                                                              ║
║  The exhaust port leads directly to the reactor core.        ║
║  A precise hit will start a chain reaction.                  ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝

May the Force be with you!

- Galen Erso (embedded message in the plans)
  "I've placed a weakness deep within the system..."

EOF

chmod 600 /root/emperor_vault/death_star_plans.txt

# Create initial access flag in web directory
echo "$FLAG1" > /var/www/deathstar/first_access_flag.txt
chmod 644 /var/www/deathstar/first_access_flag.txt
chown www-data:www-data /var/www/deathstar/first_access_flag.txt

# Create exploit hint file
cat > /var/www/deathstar/hint.txt << 'EOF'
Rebel Intelligence Report:
==========================

Our spies have discovered a weakness in the Imperial web interface.

The debug parameter might reveal more than the Empire intended...

Try: ?id=test&debug=true

The Force will guide you to command injection.

May the Force be with you!
EOF

# Set proper permissions
chown -R stormtrooper:stormtrooper /home/stormtrooper
chown -R imperial-officer:imperial-officer /home/imperial-officer
chmod 755 /home/stormtrooper /home/imperial-officer /home/commander /home/vader

echo ""
echo "=================================================="
echo "  ✓ Death Star CTF Setup Complete!"
echo "=================================================="
echo ""
echo "📡 Access Points:"
echo "  - Web Interface: http://localhost:8080"
echo "  - SSH Service: Port 22"
echo ""
echo "🎯 Starting Points for Players:"
echo "  1. Scan the target"
echo "  2. Explore the web application"
echo "  3. Look for vulnerabilities (hint: debug parameter)"
echo "  4. Gain initial access"
echo "  5. Escalate privileges through the ranks"
echo ""
echo "👥 User Accounts Created:"
echo "  - stormtrooper (Password: tk421isdown)"
echo "  - imperial-officer"
echo "  - commander"
echo "  - vader"
echo "  - root (emperor)"
echo ""
echo "🏆 Total Flags: 6"
echo ""
echo "May the Force be with you!"
echo "=================================================="
