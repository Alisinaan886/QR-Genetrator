# QR Generator
# 🔒 QR Code Phishing Lab - Educational Cybersecurity Project

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://python.org)
![Educational](https://img.shields.io/badge/Purpose-Educational-green.svg)
![Status](https://img.shields.io/badge/Status-Active-success.svg)

> **⚠️ EDUCATIONAL PURPOSES ONLY ⚠️**  
> This project is designed for cybersecurity education in controlled environments.  
> Unauthorized phishing attacks are **ILLEGAL**.

![Project Banner](screenshots/banner.png)
<!-- You can create a simple banner image or remove this line -->

---

## 📋 Table of Contents

- [Overview](#overview)
- [⚠️ Legal Disclaimer](#legal-disclaimer)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [How It Works](#how-it-works)
- [Security Lessons](#security-lessons)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

---

## 🎯 Overview

This project simulates **QR code phishing (Quishing)** attacks in a safe, controlled environment to demonstrate how these attacks work and how to defend against them.

### Why This Project?

QR code phishing is one of the **fastest-growing cyber threats**:
- 📈 587% increase in quishing attacks in 2023
- 💰 Billions lost annually to phishing scams
- 📱 Mobile devices are particularly vulnerable
- 🎓 Security awareness is critical

This lab provides hands-on experience with:
✅ Understanding attack vectors  
✅ Recognizing social engineering tactics  
✅ Implementing detection mechanisms  
✅ Building security awareness  

---

## ⚠️ Legal Disclaimer

**READ CAREFULLY BEFORE USE**

### ✅ Authorized Use

This software may ONLY be used for:
- Educational purposes in academic settings
- Authorized security research
- Controlled penetration testing with written permission
- Cybersecurity training and awareness programs

### ❌ Prohibited Use

This software must NEVER be used for:
- Unauthorized access to systems or accounts
- Stealing credentials or personal information
- Harming individuals or organizations
- Any illegal activities

### 📜 Legal Notice

- Unauthorized phishing attacks are **ILLEGAL** in most jurisdictions
- Violators may face criminal prosecution
- Users are solely responsible for compliance with local laws
- The author assumes no liability for misuse

**By using this software, you agree to use it ethically and legally.**

---

## ✨ Features

- 🎨 **QR Code Generation** - Create legitimate and phishing demo QR codes
- 🏷️ **Branded QR Codes** - Simulate real-world social engineering tactics
- 🌐 **Web Interfaces** - Side-by-side comparison of legitimate vs. phishing pages
- 📊 **Credential Capture Demo** - Visualize what attackers steal
- 🛡️ **Detection Algorithms** - Learn to identify malicious QR codes
- 📚 **Comprehensive Documentation** - Detailed explanations and lab exercises
- 🎓 **Educational Focus** - Emphasis on defense and awareness

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| **Python 3.8+** | QR code generation and image processing |
| **qrcode** | QR code creation library |
| **Pillow (PIL)** | Image manipulation and branding |
| **HTML5/CSS3** | Web interface design |
| **JavaScript** | Form handling and data capture simulation |
| **HTTP Server** | Local testing environment |
| **Bash** | Automation scripts |

---

## 📦 Installation

### Prerequisites

- Python 3.8 or higher
- pip (Python package manager)
- Web browser
- Mobile device with camera (for testing)

### Step 1: Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/qr-phishing-lab.git
cd qr-phishing-lab
```

### Step 2: Install Dependencies
```bash
# Install required Python packages
pip install qrcode[pil] pillow

# Or use requirements.txt
pip install -r requirements.txt
```

### Step 3: Run Setup Script
```bash
# Make script executable (Linux/Mac)
chmod +x scripts/setup_lab.sh

# Run setup
bash scripts/setup_lab.sh
```

---

## 🚀 Usage

### Quick Start
```bash
# 1. Generate QR codes
python src/generate_qr.py
python src/generate_custom_qr.py

# 2. Start web servers (use separate terminals)

# Terminal 1 - Legitimate site
cd web/legitimate_page
python -m http.server 8000

# Terminal 2 - Phishing demo site
cd web/phishing_page
python -m http.server 8001

# 3. Access the pages
# Legitimate: http://localhost:8000
# Phishing: http://localhost:8001

# 4. Scan QR codes from examples/qr_codes/ with your phone
```

### Detailed Lab Instructions

See [docs/lab-guide.md](docs/lab-guide.md) for complete step-by-step instructions.

---

## 📁 Project Structure
```
qr-phishing-lab/
├── README.md                 # This file
├── LICENSE                   # MIT License
├── ETHICS.md                 # Ethical guidelines
├── requirements.txt          # Python dependencies
├── .gitignore               # Git ignore rules
│
├── docs/                    # Documentation
│   ├── lab-guide.md         # Complete lab instructions
│   ├── setup.md             # Setup guide
│   └── security-analysis.md # Security concepts
│
├── src/                     # Source code
│   ├── generate_qr.py       # Basic QR generator
│   ├── generate_custom_qr.py # Branded QR generator
│   └── validate_qr.py       # QR validation script
│
├── web/                     # Web pages
│   ├── legitimate_page/     # Legitimate login page
│   │   └── index.html
│   └── phishing_page/       # Phishing demo page
│       └── index.html
│
├── scripts/                 # Utility scripts
│   └── setup_lab.sh         # Automated setup
│
├── examples/                # Example outputs
│   └── qr_codes/           # Sample QR codes
│
└── screenshots/            # Project screenshots
    ├── demo.png
    └── comparison.png
```

---

## 🔍 How It Works

### Attack Flow
```
1. Attacker creates fake login page
   ↓
2. Generates QR code with malicious URL
   ↓
3. Distributes QR code (email, physical stickers, etc.)
   ↓
4. Victim scans QR code
   ↓
5. Redirected to fake page
   ↓
6. Victim enters credentials
   ↓
7. Credentials stolen!
```

### Technical Implementation

**QR Code Generation:**
```python
# Creates QR code with embedded URL
qr = qrcode.QRCode(version=1, error_correction=qrcode.constants.ERROR_CORRECT_H)
qr.add_data(url)
qr.make(fit=True)
img = qr.make_image(fill_color="black", back_color="white")
```

**Credential Capture (Demo):**
```javascript
// Simulates what attackers collect
function captureCredentials(email, password) {
    const data = {
        email: email,
        password: password,
        timestamp: new Date(),
        userAgent: navigator.userAgent,
        ip: window.location.hostname
    };
    // In real attack: send to attacker's server
    console.log('Demo: Captured', data);
}
```

---

## 🛡️ Security Lessons

### Red Flags to Watch For

#### Before Scanning:
- ⚠️ Unexpected QR codes in emails
- ⚠️ QR codes on physical items (parking tickets, flyers)
- ⚠️ Stickers placed over original QR codes
- ⚠️ Requests for urgent action

#### When Scanning:
- ⚠️ URL preview shows suspicious domain
- ⚠️ Misspelled domain names (paypa1.com vs paypal.com)
- ⚠️ URL shorteners (bit.ly, tinyurl)
- ⚠️ IP addresses instead of domain names

#### On the Website:
- ⚠️ Missing HTTPS padlock
- ⚠️ Invalid SSL certificate
- ⚠️ Poor grammar/spelling
- ⚠️ Generic greetings ("Dear Customer")

### Defense Strategies

✅ **Always preview URLs** before opening  
✅ **Verify domain spelling** carefully  
✅ **Use QR scanner apps** that show URL preview  
✅ **Enable two-factor authentication**  
✅ **Keep software updated**  
✅ **Report suspicious QR codes**  

---

## 📸 Screenshots

### QR Code Comparison
![QR Codes](screenshots/qr-comparison.png)

### Legitimate vs. Phishing Pages
![Page Comparison](screenshots/page-comparison.png)

### Credential Capture Demo
![Capture Demo](screenshots/capture-demo.png)

---

## 🤝 Contributing

Contributions for educational improvements are welcome!

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -m 'Add educational feature'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

### Contribution Guidelines

- ✅ Must maintain educational focus
- ✅ Must include proper documentation
- ✅ Must follow ethical guidelines
- ❌ No features that facilitate actual attacks
- ❌ No removal of safety warnings

---

## 📜 License

This project is licensed under the **MIT License with Educational Use Restriction**.

See [LICENSE](LICENSE) file for details.

**Additional Restriction:** This software is provided for EDUCATIONAL PURPOSES ONLY. Any malicious use is strictly prohibited and illegal.

---

## 📧 Contact

**Your Name** - [Your Email]

- 🔗 LinkedIn: [Your LinkedIn]
- 🐦 Twitter: [@YourTwitter]
- 🌐 Portfolio: [Your Website]

**Project Link:** [https://github.com/YOUR_USERNAME/qr-phishing-lab](https://github.com/YOUR_USERNAME/qr-phishing-lab)

---

## 🙏 Acknowledgments

- **Course:** [Your Course Name]
- **University:** [Your University]
- **Instructor:** [Professor Name]
- **Semester:** [Semester/Year]

### Resources & References

- [OWASP Phishing Guide](https://owasp.org/www-community/attacks/Phishing)
- [Anti-Phishing Working Group](https://apwg.org/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [Python qrcode Library](https://github.com/lincolnloop/python-qrcode)

### Inspiration

This project was created to address the growing threat of QR code phishing and to provide hands-on cybersecurity education.

---

## 📊 Project Statistics

- **Lines of Code:** ~800
- **Time Invested:** [X hours]
- **Technologies Used:** 7
- **Security Concepts Covered:** 15+

---

## ⭐ Star This Repository

If you found this educational project helpful, please consider giving it a star! ⭐

It helps others discover this resource and supports cybersecurity education.

---

**Made with 🔒 for Cybersecurity Education**

---

**Last Updated:** March 2024
```

---

## 📄 **STEP 2: Create Additional Files**

### **2.1 Create LICENSE File**

Create `LICENSE` file:
```
MIT License with Educational Use Restriction

Copyright (c) 2024 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

ADDITIONAL RESTRICTION - EDUCATIONAL USE ONLY:
This software is provided for EDUCATIONAL PURPOSES ONLY. Any use of this 
software for malicious purposes, unauthorized access, credential theft, or 
any illegal activity is strictly prohibited and constitutes a violation of 
this license. The software must only be used in controlled environments with 
proper authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.