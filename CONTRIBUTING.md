# Contributing to Death Star Leak CTF

First off, thank you for considering contributing to Death Star Leak CTF! 🌟

The following is a set of guidelines for contributing to this CTF challenge.

---

## 🎯 Ways to Contribute

### 1. Bug Reports
Found an issue? Let us know!

**Before submitting:**
- Check if the issue already exists
- Test on a fresh installation
- Include steps to reproduce

**Include in your report:**
- What you expected to happen
- What actually happened
- Steps to reproduce
- System information (OS, version, etc.)

### 2. Feature Requests

Have an idea to improve the CTF?

**Suggestions could include:**
- New privilege escalation techniques
- Additional story elements
- Improved hints
- Better documentation
- Additional challenges

### 3. Documentation Improvements

Documentation is crucial for learning!

**Areas to improve:**
- Clearer explanations
- Additional examples
- Fixed typos
- Better organization
- More resources

### 4. Code Contributions

Want to add new features or fix bugs?

**Guidelines:**
- Fork the repository
- Create a feature branch
- Make your changes
- Test thoroughly
- Submit a pull request

---

## 🔧 Development Setup

### Prerequisites
- Ubuntu 20.04 or 22.04
- Root access for testing
- Basic understanding of bash scripting
- Familiarity with Linux security

### Setup for Development

1. **Fork and clone:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/DeathStarLeak-CTF.git
   cd DeathStarLeak-CTF
   ```

2. **Create a test VM:**
   - Use VirtualBox or VMware
   - Install fresh Ubuntu
   - Snapshot before testing

3. **Test your changes:**
   ```bash
   sudo ./setup.sh
   sudo ./test_ctf.sh
   ```

---

## 📝 Pull Request Process

### Before Submitting

1. **Test thoroughly:**
   - Fresh installation works
   - All flags accessible
   - No unintended shortcuts
   - Scripts execute without errors

2. **Update documentation:**
   - Update README if needed
   - Modify walkthrough if paths change
   - Add to CHANGELOG if significant

3. **Follow coding standards:**
   - Use shellcheck for bash scripts
   - Comment complex sections
   - Follow existing style

### Submitting a PR

1. **Create a descriptive title:**
   - Good: "Add alternative privilege escalation path for vader user"
   - Bad: "Update stuff"

2. **Describe your changes:**
   ```markdown
   ## What does this PR do?
   Brief description of changes

   ## Why is this needed?
   Explain the problem or enhancement

   ## How was this tested?
   Describe your testing process

   ## Checklist
   - [ ] Tested on fresh VM
   - [ ] Documentation updated
   - [ ] No unintended solutions
   - [ ] Scripts pass shellcheck
   ```

3. **Link related issues:**
   - Reference issue numbers
   - Use "Fixes #123" for bug fixes

---

## 🎨 Style Guidelines

### Bash Scripts

```bash
#!/bin/bash

# Description of what the script does

# Constants
CONSTANT_VALUE="value"

# Functions
function_name() {
    local var_name="$1"

    # Clear comments
    command

    return 0
}

# Main script logic
main() {
    # Organized and commented
}

main "$@"
```

### Documentation

- Use clear, concise language
- Include code examples
- Organize with headers
- Use proper markdown formatting

---

## 🔒 Security Considerations

### When Adding Vulnerabilities

1. **Must be educational:**
   - Teaches real-world concepts
   - Not artificially contrived
   - Has practical applications

2. **Must be intentional:**
   - Clearly documented
   - Part of the designed path
   - Not accidental security issues

3. **Must be testable:**
   - Reliable exploitation
   - Consistent behavior
   - Works on target platforms

### What NOT to Add

❌ Real malware or trojans
❌ Destructive commands
❌ Actual data exfiltration
❌ Overly unrealistic scenarios
❌ Dangerous system modifications

---

## 📋 Testing Checklist

Before submitting changes, verify:

- [ ] Setup script runs without errors
- [ ] All services start correctly
- [ ] All 6 flags are accessible
- [ ] Each privilege escalation path works
- [ ] No unintended shortcuts exist
- [ ] Test script passes all checks
- [ ] Documentation is updated
- [ ] Walkthrough reflects changes
- [ ] Story elements are intact
- [ ] Scripts pass shellcheck
- [ ] Tested on fresh Ubuntu installation

---

## 🐛 Reporting Security Issues

Found a security issue in the CTF setup?

**For intended vulnerabilities:**
- These are part of the CTF design
- No need to report

**For unintended vulnerabilities:**
- Report via GitHub issues
- Mark as "security"
- Describe the unintended path

---

## 💡 Ideas for Contributions

Need inspiration? Here are some ideas:

### Easy Contributions
- Fix typos in documentation
- Improve code comments
- Add more hints
- Create video walkthrough
- Translate documentation

### Medium Contributions
- Add alternative exploitation paths
- Improve web application
- Enhance story elements
- Create automated testing
- Add more resources

### Advanced Contributions
- Add new privilege escalation chains
- Create difficulty variations (easy/hard modes)
- Build containerized version
- Add logging and monitoring
- Create instructor's guide

---

## 🎓 Learning Resources for Contributors

### Bash Scripting
- [Advanced Bash Scripting Guide](https://tldp.org/LDP/abs/html/)
- [Shellcheck](https://www.shellcheck.net/) - Script analysis tool

### CTF Design
- [Building Your First CTF](https://ctftime.org/)
- [OWASP WebGoat](https://owasp.org/www-project-webgoat/) - Example vulnerable app

### Security Testing
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
- [HackTricks](https://book.hacktricks.xyz/) - Pentesting techniques

---

## 📜 Code of Conduct

### Our Standards

**Positive behavior:**
- Being respectful and inclusive
- Accepting constructive feedback
- Focusing on what's best for the community
- Showing empathy towards others

**Unacceptable behavior:**
- Harassment or discrimination
- Trolling or insulting comments
- Publishing others' private information
- Other unprofessional conduct

### Enforcement

Violations may result in:
1. Warning
2. Temporary ban
3. Permanent ban

Report issues to the maintainers.

---

## 🏆 Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Credited in significant contributions

---

## 📞 Getting Help

Need help contributing?

- **Open an issue** - For questions or discussions
- **Check existing issues** - Someone may have asked already
- **Read documentation** - Most answers are documented
- **Ask the community** - TryHackMe or CTF forums

---

## 📅 Release Process

### Versioning

We use semantic versioning:
- **Major** (1.0.0): Significant changes
- **Minor** (0.1.0): New features
- **Patch** (0.0.1): Bug fixes

### Release Cycle

1. Changes merged to main
2. Testing on fresh VM
3. Update CHANGELOG
4. Tag release
5. Announce on platforms

---

## 🌟 Star Wars Theme Guidelines

When contributing story elements:

### Do's ✅
- Stay true to Star Wars lore
- Reference Rogue One primarily
- Keep the tone consistent
- Use appropriate terminology
- Respect the source material

### Don'ts ❌
- Don't mix incompatible timelines
- Avoid non-canon elements (unless clearly marked)
- Don't use copyrighted material directly
- Keep it educational, not just fan fiction

---

## 📝 Commit Message Guidelines

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes
- **refactor**: Code refactoring
- **test**: Testing changes
- **chore**: Build process or tools

### Examples
```
feat(webapp): Add SQL injection vulnerability

Added a new SQL injection point in the login form to teach
database exploitation techniques.

Closes #42
```

```
fix(setup): Correct Apache configuration

The previous Apache config didn't listen on port 8080.
Updated ports.conf to include the correct listener.

Fixes #38
```

---

## 🎯 Priority Areas

Current focus areas for contributions:

1. **Testing improvements** - More comprehensive tests
2. **Documentation** - Clearer explanations
3. **Accessibility** - Make it easier for beginners
4. **Platform support** - Debian, other distros
5. **Automation** - Better deployment options

---

## 🙏 Thank You!

Every contribution helps make this CTF better for the community!

**May the Force be with you!** ⭐

---

For questions about contributing, open an issue or reach out to the maintainers.

**Happy Contributing!** 🚀
