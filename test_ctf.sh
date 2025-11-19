#!/bin/bash

# Death Star Leak CTF - Testing Script
# This script verifies that the CTF is set up correctly

echo "=================================================="
echo "  Death Star Leak CTF - Testing Script"
echo "=================================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PASSED=0
FAILED=0

# Function to test and report
test_item() {
    local description="$1"
    local command="$2"

    echo -n "Testing: $description... "

    if eval "$command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASS${NC}"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗ FAIL${NC}"
        ((FAILED++))
        return 1
    fi
}

# Function to test file existence and permissions
test_file() {
    local description="$1"
    local filepath="$2"
    local expected_perms="$3"

    echo -n "Testing: $description... "

    if [ -f "$filepath" ]; then
        if [ -z "$expected_perms" ] || [ "$(stat -c %a $filepath)" = "$expected_perms" ]; then
            echo -e "${GREEN}✓ PASS${NC}"
            ((PASSED++))
            return 0
        else
            echo -e "${YELLOW}⚠ EXISTS (wrong permissions)${NC}"
            ((FAILED++))
            return 1
        fi
    else
        echo -e "${RED}✗ FAIL (not found)${NC}"
        ((FAILED++))
        return 1
    fi
}

echo "=== System Services ==="
test_item "Apache2 service running" "systemctl is-active --quiet apache2"
test_item "SSH service running" "systemctl is-active --quiet ssh"
test_item "Apache listening on port 8080" "netstat -tuln | grep -q ':8080'"
test_item "SSH listening on port 22" "netstat -tuln | grep -q ':22'"

echo ""
echo "=== User Accounts ==="
test_item "Stormtrooper user exists" "id stormtrooper"
test_item "Imperial-officer user exists" "id imperial-officer"
test_item "Commander user exists" "id commander"
test_item "Vader user exists" "id vader"

echo ""
echo "=== Web Application ==="
test_file "Web index.php exists" "/var/www/deathstar/index.php"
test_file "Web upload.php exists" "/var/www/deathstar/upload.php"
test_file "First flag exists" "/var/www/deathstar/first_access_flag.txt" "644"
test_item "Web application accessible" "curl -s http://localhost:8080 | grep -q 'DEATH STAR'"

echo ""
echo "=== Home Directories ==="
test_file "Stormtrooper home exists" "/home/stormtrooper/flag.txt" "644"
test_file "Stormtrooper message exists" "/home/stormtrooper/message.txt"
test_file "Officer SSH key in backup" "/home/stormtrooper/.backup/officer_key" "644"
test_file "Imperial-officer home exists" "/home/imperial-officer/flag.txt" "644"
test_file "Commander home exists" "/home/commander/flag.txt" "644"
test_file "Vader home exists" "/home/vader/flag.txt" "644"

echo ""
echo "=== Privilege Escalation Paths ==="
test_file "SUID scanner exists" "/usr/local/bin/deathstar_scanner"
test_item "Scanner has SUID bit" "[ -u /usr/local/bin/deathstar_scanner ]"
test_item "Scanner owned by vader" "[ \$(stat -c '%U' /usr/local/bin/deathstar_scanner) = 'vader' ]"
test_item "Imperial-officer has sudo rights" "sudo -l -U imperial-officer 2>/dev/null | grep -q find"
test_item "Vader has sudo rights" "sudo -l -U vader 2>/dev/null | grep -q systemctl"

echo ""
echo "=== SSH Configuration ==="
test_file "Imperial-officer SSH dir exists" "/home/imperial-officer/.ssh/authorized_keys" "600"
test_item "Imperial-officer SSH key works" "[ -f /home/imperial-officer/.ssh/id_rsa ]"

echo ""
echo "=== Root Flag ==="
test_file "Emperor vault exists" "/root/emperor_vault/death_star_plans.txt" "600"

echo ""
echo "=== File Permissions ==="
test_item "Stormtrooper home readable" "[ -r /home/stormtrooper ]"
test_item "Web directory owned by www-data" "[ \$(stat -c '%U' /var/www/deathstar) = 'www-data' ]"

echo ""
echo "=== Flag Content Verification ==="
test_item "Flag 1 contains DSL{" "grep -q 'DSL{' /var/www/deathstar/first_access_flag.txt"
test_item "Flag 2 contains DSL{" "grep -q 'DSL{' /home/stormtrooper/flag.txt"
test_item "Flag 3 contains DSL{" "grep -q 'DSL{' /home/imperial-officer/flag.txt"
test_item "Flag 4 contains DSL{" "grep -q 'DSL{' /home/commander/flag.txt"
test_item "Flag 5 contains DSL{" "grep -q 'DSL{' /home/vader/flag.txt"
test_item "Flag 6 contains DSL{" "grep -q 'DSL{' /root/emperor_vault/death_star_plans.txt"

echo ""
echo "=================================================="
echo "  Test Results"
echo "=================================================="
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed! CTF is ready!${NC}"
    echo ""
    echo "Players can now access:"
    echo "  - Web: http://$(hostname -I | awk '{print $1}'):8080"
    echo "  - SSH: ssh $(hostname -I | awk '{print $1}')"
    echo ""
    echo "May the Force be with you!"
    exit 0
else
    echo -e "${RED}✗ Some tests failed. Please review the setup.${NC}"
    echo ""
    echo "Troubleshooting:"
    echo "  1. Make sure you ran setup.sh as root"
    echo "  2. Check that all services started correctly"
    echo "  3. Review /var/log/apache2/error.log for web issues"
    echo "  4. Verify all user accounts were created"
    exit 1
fi
