#!/bin/bash

# Death Star Leak CTF - Setup Script v2.0
# Enhanced with multiple web vulnerabilities for Burp Suite testing
# Run this script as root to set up the CTF environment

set -e

echo "=================================================="
echo "  DEATH STAR LEAK - CTF Setup v2.0"
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
apt-get install -y apache2 php php-mysqli php-sqlite3 sqlite3 python3 python3-pip ssh curl wget gcc libapache2-mod-php > /dev/null 2>&1

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

# Create web application directory structure
echo "[+] Deploying Imperial Network web interface..."
mkdir -p /var/www/deathstar
mkdir -p /var/www/deathstar/uploads
mkdir -p /var/www/deathstar/admin
mkdir -p /var/www/deathstar/includes
mkdir -p /var/www/deathstar/backup
chmod 777 /var/www/deathstar/uploads

# Create SQLite database with users
echo "[+] Setting up Imperial database..."
rm -f /var/www/deathstar/imperial.db
sqlite3 /var/www/deathstar/imperial.db << 'EOFDB'
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT,
    password TEXT,
    clearance TEXT
);

INSERT INTO users VALUES (1, 'TK-421', 'tk421isdown', 'stormtrooper');
INSERT INTO users VALUES (2, 'admin', 'sup3rs3cr3t', 'admin');
INSERT INTO users VALUES (3, 'tarkin', 'deathstar2187', 'commander');

CREATE TABLE logs (
    id INTEGER PRIMARY KEY,
    message TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO logs VALUES (1, 'System initialized', datetime('now'));
INSERT INTO logs VALUES (2, 'Security scan complete', datetime('now'));
EOFDB

chmod 666 /var/www/deathstar/imperial.db
chown www-data:www-data /var/www/deathstar/imperial.db

# Create main index.php with SQL injection
cat > /var/www/deathstar/index.php << 'EOFPHP'
<?php
session_start();
?>
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
            padding: 8px;
            width: 200px;
            margin: 5px 0;
        }
        input[type="submit"] {
            background: #f00;
            color: #fff;
            border: 1px solid #f00;
            padding: 8px 15px;
            cursor: pointer;
            margin-top: 10px;
        }
        input[type="submit"]:hover {
            background: #ff3333;
        }
        .error { color: #f00; }
        .success { color: #0ff; }
        pre { color: #0f0; }
        a { color: #0ff; }
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
            <h2>CLASSIFIED ACCESS - PERSONNEL LOGIN</h2>
            <p>Imperial Personnel: Authenticate to access restricted systems</p>

            <form method="POST" action="">
                <label>Personnel ID:</label><br>
                <input type="text" name="username" placeholder="Personnel ID"><br>
                <label>Access Code:</label><br>
                <input type="password" name="password" placeholder="Access Code"><br>
                <input type="submit" name="login" value="AUTHENTICATE">
            </form>

            <?php
            if (isset($_POST['login'])) {
                $username = $_POST['username'];
                $password = $_POST['password'];

                // Vulnerable SQL query - SQLi possible!
                $db = new SQLite3('/var/www/deathstar/imperial.db');
                $query = "SELECT * FROM users WHERE username = '$username' AND password = '$password'";
                $result = $db->query($query);

                if ($row = $result->fetchArray()) {
                    $_SESSION['user'] = $row['username'];
                    $_SESSION['clearance'] = $row['clearance'];
                    echo "<div class='success'><br>Access Granted!<br>";
                    echo "Welcome, " . htmlspecialchars($row['username']) . "<br>";
                    echo "Clearance: " . htmlspecialchars($row['clearance']) . "<br>";

                    if ($row['clearance'] == 'admin') {
                        echo "<br><a href='admin/'>Access Admin Panel</a>";
                    }
                    echo "</div>";
                } else {
                    echo "<div class='error'><br>Access Denied<br>Invalid credentials</div>";
                }
                $db->close();
            }
            ?>
        </div>

        <div class="terminal">
            <h3>System Status</h3>
            <p>Death Star Status: <span style="color:#0f0;">OPERATIONAL</span></p>
            <p>Superlaser: <span style="color:#f00;">CHARGING</span></p>
            <p>Security Level: <span style="color:#ff0;">ELEVATED</span></p>
        </div>

        <div class="terminal">
            <h3>Quick Links</h3>
            <p><a href="viewer.php?page=about">About the Death Star</a></p>
            <p><a href="upload.php">File Transfer System</a></p>
        </div>
    </div>
</body>
</html>
EOFPHP

# Create viewer.php with LFI vulnerability
cat > /var/www/deathstar/viewer.php << 'EOFPHP'
<?php
session_start();
?>
<!DOCTYPE html>
<html>
<head>
    <title>Death Star - Document Viewer</title>
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
        }
        .content {
            background: #001100;
            padding: 15px;
            border: 1px solid #0f0;
            margin: 20px 0;
            white-space: pre-wrap;
        }
        a { color: #0ff; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Imperial Document Viewer</h1>

        <div class="content">
        <?php
        if (isset($_GET['page'])) {
            $page = $_GET['page'];

            // Vulnerable to LFI - no proper sanitization!
            $file = "includes/" . $page . ".php";

            // Basic "protection" that can be bypassed
            if (strpos($page, '..') === false) {
                if (file_exists($file)) {
                    include($file);
                } else {
                    // Try without .php extension for txt files
                    $file = "includes/" . $page;
                    if (file_exists($file)) {
                        echo htmlspecialchars(file_get_contents($file));
                    } else {
                        echo "Document not found.";
                    }
                }
            } else {
                // Can still be bypassed with ....// or encoding
                echo "Invalid path detected!";
            }
        } else {
            echo "Select a document to view.";
        }
        ?>
        </div>

        <p><a href="index.php">Back to Login</a></p>
    </div>
</body>
</html>
EOFPHP

# Create about page
cat > /var/www/deathstar/includes/about.php << 'EOFPHP'
<h2>About the Death Star</h2>
<p>The DS-1 Orbital Battle Station, also known as the Death Star, is a moon-sized Imperial military battlestation armed with a planet-destroying superlaser.</p>
<p>This terminal provides access to Imperial systems. Authorized personnel only.</p>
<p>For technical support, contact your commanding officer.</p>
EOFPHP

# Create upload.php with file upload vulnerability
cat > /var/www/deathstar/upload.php << 'EOFPHP'
<?php
session_start();
$message = "";

if (isset($_POST['upload'])) {
    $target_dir = "uploads/";
    $target_file = $target_dir . basename($_FILES["file"]["name"]);

    // Weak validation - only checks content-type header (can be spoofed!)
    $allowed_types = array('image/jpeg', 'image/png', 'image/gif');

    if (in_array($_FILES["file"]["type"], $allowed_types)) {
        if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
            $message = "<span style='color:#0f0'>File uploaded successfully: " . htmlspecialchars(basename($_FILES["file"]["name"])) . "</span>";
        } else {
            $message = "<span style='color:#f00'>Error uploading file.</span>";
        }
    } else {
        // Hidden bypass: if filename contains .imperial, allow any type
        if (strpos($_FILES["file"]["name"], '.imperial') !== false) {
            $clean_name = str_replace('.imperial', '', $_FILES["file"]["name"]);
            $target_file = $target_dir . basename($clean_name);
            if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
                $message = "<span style='color:#0f0'>Imperial override: File uploaded as " . htmlspecialchars($clean_name) . "</span>";
            }
        } else {
            $message = "<span style='color:#f00'>Invalid file type. Only images allowed.</span>";
        }
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Death Star - File Transfer</title>
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
        }
        .terminal {
            background: #001100;
            padding: 15px;
            border: 1px solid #0f0;
            margin: 20px 0;
        }
        input[type="file"] {
            color: #0f0;
            margin: 10px 0;
        }
        input[type="submit"] {
            background: #f00;
            color: #fff;
            border: 1px solid #f00;
            padding: 8px 15px;
            cursor: pointer;
        }
        a { color: #0ff; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Imperial File Transfer System</h1>

        <div class="terminal">
            <h3>Upload File</h3>
            <p>Transfer files to the Death Star network.</p>
            <p><em>Note: Only image files are permitted for security reasons.</em></p>

            <form method="POST" enctype="multipart/form-data">
                <input type="file" name="file" required><br>
                <input type="submit" name="upload" value="UPLOAD">
            </form>

            <?php if ($message) echo "<p>$message</p>"; ?>
        </div>

        <div class="terminal">
            <h3>Recent Uploads</h3>
            <?php
            $files = glob("uploads/*");
            if (count($files) > 0) {
                foreach ($files as $file) {
                    echo "<p><a href='" . htmlspecialchars($file) . "'>" . htmlspecialchars(basename($file)) . "</a></p>";
                }
            } else {
                echo "<p>No files uploaded.</p>";
            }
            ?>
        </div>

        <p><a href="index.php">Back to Login</a></p>
    </div>
</body>
</html>
EOFPHP

# Create admin panel
cat > /var/www/deathstar/admin/index.php << 'EOFPHP'
<?php
session_start();

// Check if user has admin clearance
if (!isset($_SESSION['clearance']) || $_SESSION['clearance'] != 'admin') {
    header('Location: ../index.php');
    exit;
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Death Star - Admin Panel</title>
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
            border: 2px solid #f00;
            padding: 20px;
        }
        .terminal {
            background: #110000;
            padding: 15px;
            border: 1px solid #f00;
            margin: 20px 0;
        }
        input[type="text"] {
            background: #000;
            border: 1px solid #f00;
            color: #0f0;
            padding: 8px;
            width: 300px;
        }
        input[type="submit"] {
            background: #f00;
            color: #fff;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
        }
        a { color: #0ff; }
    </style>
</head>
<body>
    <div class="container">
        <h1 style="color:#f00;">ADMIN CONTROL PANEL</h1>

        <div class="terminal">
            <h3>System Command Interface</h3>
            <p>Execute system diagnostics:</p>

            <form method="POST">
                <input type="text" name="cmd" placeholder="Enter command...">
                <input type="submit" value="EXECUTE">
            </form>

            <?php
            if (isset($_POST['cmd'])) {
                $cmd = $_POST['cmd'];
                echo "<pre style='color:#0f0; margin-top:15px;'>";
                echo "$ " . htmlspecialchars($cmd) . "\n\n";
                // Command injection - but requires admin access first
                echo shell_exec($cmd);
                echo "</pre>";
            }
            ?>
        </div>

        <div class="terminal">
            <h3>Classified Information</h3>
            <p>First Access Flag: <code><?php echo file_get_contents('/var/www/deathstar/first_access_flag.txt'); ?></code></p>
        </div>

        <p><a href="../index.php">Logout</a></p>
    </div>
</body>
</html>
EOFPHP

# Create robots.txt with hints
cat > /var/www/deathstar/robots.txt << 'EOF'
User-agent: *
Disallow: /admin/
Disallow: /backup/
Disallow: /uploads/
Disallow: /includes/
EOF

# Create backup directory with hints
cat > /var/www/deathstar/backup/db_backup.txt << 'EOF'
Imperial Database Backup Log
============================
Last backup: [REDACTED]

Note: Database credentials stored in /var/www/deathstar/imperial.db
Backup user: backup_admin
Hint: The admin password follows the pattern sup3r[word]

For emergency access, check the TK-421 stormtrooper credentials.
His password is based on the famous "why aren't you at your post" incident.
EOF

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

# Enable required modules
a2enmod php* > /dev/null 2>&1 || true
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
chmod 600 /home/stormtrooper/flag.txt
chown stormtrooper:stormtrooper /home/stormtrooper/flag.txt

# Hidden SSH key for imperial-officer
mkdir -p /home/stormtrooper/.backup
mkdir -p /home/imperial-officer/.ssh
ssh-keygen -t rsa -f /home/imperial-officer/.ssh/id_rsa -N "" -C "imperial-officer@deathstar" > /dev/null 2>&1
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
chmod 600 /home/imperial-officer/flag.txt
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
chmod 600 /home/commander/flag.txt

# Create SUID binary for commander -> vader
cat > /tmp/deathstar_scanner.c << 'EOFC'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char **argv) {
    setuid(geteuid());
    setgid(getegid());

    if (argc < 2) {
        printf("Death Star Security Scanner v1.0\n");
        printf("Usage: %s <sector>\n", argv[0]);
        printf("Scanning for unauthorized access...\n");
        return 1;
    }

    // Intentional vulnerability - no input sanitization
    char command[256];
    snprintf(command, sizeof(command), "/bin/echo 'Scanning sector: %s'", argv[1]);
    system(command);

    return 0;
}
EOFC

gcc /tmp/deathstar_scanner.c -o /usr/local/bin/deathstar_scanner
chown vader:vader /usr/local/bin/deathstar_scanner
chmod 4755 /usr/local/bin/deathstar_scanner
rm /tmp/deathstar_scanner.c

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
chmod 700 /home/commander

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

The Emperor's vault lies beyond. The complete Death Star
plans rest there, along with the ultimate power of the Empire.

====================================
THE DARK SIDE IS STRONG
====================================
EOF

echo "$FLAG5" > /home/vader/flag.txt
chmod 600 /home/vader/flag.txt

# Sudo entry for vader -> root
echo "vader ALL=(ALL) NOPASSWD: /bin/systemctl status *" >> /etc/sudoers

cat > /home/vader/instructions.txt << 'EOF'
Lord Vader,

Your emergency access protocols:

1. You have sudo access to check system status
2. Use your authority wisely

The Emperor awaits your success.

Commands you can run:
- sudo /bin/systemctl status <service>

Remember: The Force is strong with you.
EOF

chown -R vader:vader /home/vader
chmod 700 /home/vader

# Root flag (Emperor's vault)
mkdir -p /root/emperor_vault
cat > /root/emperor_vault/death_star_plans.txt << 'EOF'
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║              EMPEROR'S VAULT - LEVEL 10                      ║
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
- Infiltrated the Imperial Network
- Compromised Stormtrooper TK-421
- Elevated to Imperial Officer clearance
- Assumed Commander Tarkin's authority
- Wielded Vader's dark power
- Seized the Emperor's ultimate access

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

# Set proper permissions - IMPORTANT FOR PRIVESC CHAIN
chown -R stormtrooper:stormtrooper /home/stormtrooper
chown -R imperial-officer:imperial-officer /home/imperial-officer
chmod 700 /home/stormtrooper /home/imperial-officer /home/commander /home/vader

# Allow reading the backup directory for SSH key discovery
chmod 755 /home/stormtrooper/.backup

# Web directory permissions
chown -R www-data:www-data /var/www/deathstar

# Start SSH service
systemctl enable ssh > /dev/null 2>&1
systemctl start ssh > /dev/null 2>&1

echo ""
echo "=================================================="
echo "  Death Star CTF Setup Complete! v2.0"
echo "=================================================="
echo ""
echo "Access Points:"
echo "  - Web Interface: http://localhost:8080"
echo "  - SSH Service: Port 22"
echo ""
echo "Attack Vectors:"
echo "  1. SQL Injection on login form"
echo "  2. File Upload bypass (.imperial trick)"
echo "  3. LFI via viewer.php?page="
echo "  4. Directory enumeration (robots.txt)"
echo "  5. Admin panel command injection"
echo ""
echo "Privilege Escalation Chain:"
echo "  stormtrooper -> imperial-officer (SSH key)"
echo "  imperial-officer -> commander (sudo find)"
echo "  commander -> vader (SUID binary)"
echo "  vader -> root (sudo systemctl)"
echo ""
echo "Total Flags: 6"
echo ""
echo "May the Force be with you!"
echo "=================================================="
