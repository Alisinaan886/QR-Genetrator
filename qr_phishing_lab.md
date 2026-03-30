# QR Code Phishing Lab - Cybersecurity Education Project

## ⚠️ ETHICAL USE ONLY
This lab is designed for **educational purposes only** in controlled environments. Unauthorized phishing attacks are illegal and unethical.

## Lab Overview
Learn how QR code phishing attacks work and how to defend against them through hands-on experience in a safe, controlled environment.

---

## Part 1: Understanding QR Code Phishing

### What is QR Code Phishing (Quishing)?
QR code phishing involves embedding malicious URLs in QR codes to:
- Redirect users to fake login pages
- Deliver malware
- Steal credentials
- Bypass traditional email security filters

### Why QR Codes are Effective for Phishing
1. **URL Obfuscation**: Users can't preview the destination
2. **Mobile Bypass**: Mobile devices often have weaker security
3. **Trust Factor**: QR codes appear modern and legitimate
4. **Email Filter Evasion**: Images bypass text-based security scans

---

## Part 2: Lab Setup

### Required Tools
```bash
# 1. QR Code Generator
pip install qrcode[pil]
pip install pillow

# 2. Local Web Server (for testing)
# Python 3 built-in server (no installation needed)

# 3. Optional: Advanced tools
pip install segno  # Alternative QR generator
```

### Lab Environment Setup
```bash
# Create project directory
mkdir qr_phishing_lab
cd qr_phishing_lab

# Create subdirectories
mkdir legitimate_page
mkdir phishing_page
mkdir qr_codes
mkdir logs
```

---

## Part 3: Creating Demonstration Pages

### 3.1 Legitimate Login Page (Control)
Save as `legitimate_page/index.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Secure Login - Legitimate Site</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            max-width: 400px;
        }
        .legitimate-badge {
            background: #10b981;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            display: inline-block;
            margin-bottom: 20px;
        }
        h2 { color: #333; }
        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .security-info {
            margin-top: 20px;
            padding: 15px;
            background: #f0fdf4;
            border-left: 4px solid #10b981;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="legitimate-badge">✓ LEGITIMATE SITE</div>
        <h2>Secure Login</h2>
        <form onsubmit="handleLegitimateLogin(event)">
            <input type="email" placeholder="Email" required>
            <input type="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <div class="security-info">
            <strong>Security Indicators:</strong><br>
            ✓ HTTPS connection (check URL bar)<br>
            ✓ Valid SSL certificate<br>
            ✓ Correct domain name<br>
            ✓ No spelling errors
        </div>
    </div>
    <script>
        function handleLegitimateLogin(e) {
            e.preventDefault();
            alert('This is the LEGITIMATE page.\n\nIn a real scenario, this would securely process your credentials.');
        }
    </script>
</body>
</html>
```

### 3.2 Phishing Page (Demonstration)
Save as `phishing_page/index.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Secure Login - Educational Demo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            max-width: 400px;
        }
        .warning-badge {
            background: #ef4444;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            display: inline-block;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        h2 { color: #333; }
        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .captured-data {
            margin-top: 20px;
            padding: 15px;
            background: #fef2f2;
            border-left: 4px solid #ef4444;
            font-size: 14px;
            display: none;
        }
        .warning-info {
            margin-top: 20px;
            padding: 15px;
            background: #fef2f2;
            border-left: 4px solid #ef4444;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="warning-badge">⚠️ PHISHING DEMONSTRATION</div>
        <h2>Secure Login</h2>
        <form onsubmit="handlePhishingAttempt(event)">
            <input type="email" id="email" placeholder="Email" required>
            <input type="password" id="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <div class="captured-data" id="capturedData"></div>
        <div class="warning-info">
            <strong>Red Flags (Look for these):</strong><br>
            ⚠️ Check the URL carefully<br>
            ⚠️ Verify domain spelling<br>
            ⚠️ Look for HTTPS/SSL indicators<br>
            ⚠️ Be cautious of QR codes from unknown sources
        </div>
    </div>
    <script>
        function handlePhishingAttempt(e) {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
            // EDUCATIONAL DEMO: Show what was captured
            const capturedDiv = document.getElementById('capturedData');
            capturedDiv.innerHTML = `
                <strong>⚠️ CREDENTIALS CAPTURED (Educational Demo)</strong><br><br>
                <strong>Email:</strong> ${email}<br>
                <strong>Password:</strong> ${'•'.repeat(password.length)}<br><br>
                <strong>What an attacker would also collect:</strong><br>
                • IP Address: ${window.location.hostname}<br>
                • User Agent: ${navigator.userAgent.substring(0, 50)}...<br>
                • Timestamp: ${new Date().toLocaleString()}<br>
                • Referrer: ${document.referrer || 'Direct access'}<br><br>
                <em>In a real attack, this data would be sent to the attacker's server!</em>
            `;
            capturedDiv.style.display = 'block';
            
            // Log to console (educational purposes)
            console.log('DEMO: Credentials captured', {
                email: email,
                password: password,
                timestamp: new Date(),
                userAgent: navigator.userAgent
            });
        }
    </script>
</body>
</html>
```

---

## Part 4: QR Code Generation Scripts

### 4.1 Basic QR Code Generator
Save as `generate_qr.py`:

```python
#!/usr/bin/env python3
"""
QR Code Generator for Phishing Lab
Educational purposes only
"""

import qrcode
from PIL import Image
import os

def generate_qr_code(url, filename, logo_path=None):
    """
    Generate a QR code with optional logo overlay
    
    Args:
        url: The URL to encode
        filename: Output filename
        logo_path: Optional path to logo image
    """
    # Create QR code instance
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_H,
        box_size=10,
        border=4,
    )
    
    # Add data
    qr.add_data(url)
    qr.make(fit=True)
    
    # Create image
    img = qr.make_image(fill_color="black", back_color="white")
    
    # Add logo if provided
    if logo_path and os.path.exists(logo_path):
        logo = Image.open(logo_path)
        
        # Calculate logo size (should be ~1/5 of QR code)
        qr_width, qr_height = img.size
        logo_size = qr_width // 5
        
        # Resize logo
        logo = logo.resize((logo_size, logo_size), Image.LANCZOS)
        
        # Calculate position (center)
        logo_pos = ((qr_width - logo_size) // 2, (qr_height - logo_size) // 2)
        
        # Paste logo
        img.paste(logo, logo_pos)
    
    # Save
    img.save(filename)
    print(f"QR code saved to: {filename}")

def main():
    # Create output directory
    os.makedirs('qr_codes', exist_ok=True)
    
    # Example 1: Legitimate QR code
    legitimate_url = "http://localhost:8000/legitimate_page/"
    generate_qr_code(
        legitimate_url,
        "qr_codes/legitimate_login.png"
    )
    
    # Example 2: Phishing QR code (demo)
    phishing_url = "http://localhost:8001/phishing_page/"
    generate_qr_code(
        phishing_url,
        "qr_codes/phishing_demo.png"
    )
    
    # Example 3: URL shortener disguise
    # In real attacks, attackers use bit.ly, tinyurl, etc.
    shortened_url = "http://localhost:8001/phishing_page/"
    generate_qr_code(
        shortened_url,
        "qr_codes/disguised_link.png"
    )
    
    print("\n✓ QR codes generated successfully!")
    print("\nTo test:")
    print("1. Start servers:")
    print("   cd legitimate_page && python3 -m http.server 8000")
    print("   cd phishing_page && python3 -m http.server 8001")
    print("2. Scan QR codes with your phone")
    print("3. Compare the experiences")

if __name__ == "__main__":
    main()
```

### 4.2 Advanced QR Code with Customization
Save as `generate_custom_qr.py`:

```python
#!/usr/bin/env python3
"""
Advanced QR Code Generator with Visual Disguises
Educational demonstration of phishing techniques
"""

import qrcode
from PIL import Image, ImageDraw, ImageFont
import os

def create_branded_qr(url, filename, brand_name="PayPal", color="#003087"):
    """
    Create a QR code that appears to be from a trusted brand
    This demonstrates how attackers disguise malicious QR codes
    """
    # Generate QR code
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_H,
        box_size=10,
        border=4,
    )
    qr.add_data(url)
    qr.make(fit=True)
    
    # Create base image
    qr_img = qr.make_image(fill_color=color, back_color="white")
    
    # Create larger canvas for branding
    width, height = qr_img.size
    canvas = Image.new('RGB', (width, height + 100), 'white')
    
    # Paste QR code
    canvas.paste(qr_img, (0, 50))
    
    # Add text
    draw = ImageDraw.Draw(canvas)
    
    # Try to use a nice font, fallback to default
    try:
        font_large = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 30)
        font_small = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 16)
    except:
        font_large = ImageFont.load_default()
        font_small = ImageFont.load_default()
    
    # Title
    title = f"Scan to Login - {brand_name}"
    draw.text((width//2, 25), title, fill=color, font=font_small, anchor="mm")
    
    # Footer
    footer = "Secure Payment Portal"
    draw.text((width//2, height + 75), footer, fill="#666666", font=font_small, anchor="mm")
    
    canvas.save(filename)
    print(f"Branded QR code saved: {filename}")

def create_parking_ticket_qr(url, filename):
    """
    Simulate a parking ticket QR code - common phishing vector
    """
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_M,
        box_size=8,
        border=3,
    )
    qr.add_data(url)
    qr.make(fit=True)
    
    qr_img = qr.make_image(fill_color="black", back_color="white")
    width, height = qr_img.size
    
    # Create ticket-like background
    canvas = Image.new('RGB', (width + 40, height + 120), '#FFF8DC')
    draw = ImageDraw.Draw(canvas)
    
    # Border
    draw.rectangle([(5, 5), (width + 35, height + 115)], outline="black", width=3)
    
    # Title
    try:
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 20)
    except:
        font = ImageFont.load_default()
    
    draw.text((width//2 + 20, 25), "PARKING VIOLATION", fill="red", font=font, anchor="mm")
    draw.text((width//2 + 20, 50), "Scan to Pay Fine", fill="black", font=font, anchor="mm")
    
    # Paste QR code
    canvas.paste(qr_img, (20, 70))
    
    canvas.save(filename)
    print(f"Parking ticket QR saved: {filename}")

def main():
    os.makedirs('qr_codes', exist_ok=True)
    
    # Demo URLs (replace with your test servers)
    demo_url = "http://localhost:8001/phishing_page/"
    
    # Generate various disguised QR codes
    create_branded_qr(demo_url, "qr_codes/fake_paypal.png", "PayPal", "#003087")
    create_branded_qr(demo_url, "qr_codes/fake_microsoft.png", "Microsoft", "#0078D4")
    create_parking_ticket_qr(demo_url, "qr_codes/fake_parking_ticket.png")
    
    print("\n✓ Custom QR codes generated!")
    print("\nThese demonstrate common phishing disguises:")
    print("• Branded payment portals")
    print("• Parking tickets")
    print("• Package delivery notices")

if __name__ == "__main__":
    main()
```

---

## Part 5: Running the Lab

### Step 1: Generate QR Codes
```bash
python3 generate_qr.py
python3 generate_custom_qr.py
```

### Step 2: Start Test Servers
```bash
# Terminal 1 - Legitimate site
cd legitimate_page
python3 -m http.server 8000

# Terminal 2 - Phishing demo site
cd phishing_page
python3 -m http.server 8001
```

### Step 3: Test the QR Codes
1. Print or display QR codes from `qr_codes/` directory
2. Scan with mobile device
3. Observe the differences between legitimate and phishing pages
4. Note what credentials are captured on the demo phishing page

---

## Part 6: Detection and Defense Techniques

### For Users
1. **Check the URL** before entering credentials
2. **Verify the domain** matches the expected site
3. **Look for HTTPS** and valid certificates
4. **Be suspicious** of unsolicited QR codes
5. **Use QR scanner apps** that preview URLs before opening

### For Organizations
```python
# Example: QR Code Validator Script
import qrcode
from pyzbar.pyzbar import decode
from PIL import Image
import re

def validate_qr_url(image_path, whitelist_domains):
    """
    Validate QR code URL against whitelist
    """
    # Decode QR code
    img = Image.open(image_path)
    decoded_objects = decode(img)
    
    for obj in decoded_objects:
        url = obj.data.decode('utf-8')
        
        # Check against whitelist
        is_valid = any(domain in url for domain in whitelist_domains)
        
        # Check for suspicious patterns
        suspicious_patterns = [
            r'bit\.ly', r'tinyurl', r'goo\.gl',  # URL shorteners
            r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}',  # IP addresses
            r'login.*urgent', r'verify.*account'  # Phishing keywords
        ]
        
        has_suspicious = any(re.search(pattern, url, re.I) for pattern in suspicious_patterns)
        
        return {
            'url': url,
            'is_whitelisted': is_valid,
            'has_suspicious_patterns': has_suspicious,
            'safe': is_valid and not has_suspicious
        }
    
    return None

# Example usage
whitelist = ['yourcompany.com', 'trustedpartner.com']
result = validate_qr_url('qr_codes/suspicious.png', whitelist)
print(f"URL Safety: {result}")
```

---

## Part 7: Lab Exercises

### Exercise 1: Identify Phishing Indicators
Compare legitimate vs. phishing QR codes and list 5 red flags

### Exercise 2: Create Detection Rules
Write rules to detect malicious QR codes based on URL patterns

### Exercise 3: User Awareness Campaign
Design a poster explaining QR code safety for your organization

### Exercise 4: Incident Response
Create a response plan for a QR code phishing incident

---

## Part 8: Cleanup and Security

### After Lab Completion:
```bash
# Stop all servers
# Press Ctrl+C in each terminal

# Remove generated files
rm -rf qr_codes/
rm -rf logs/

# Clear browser history/cache from test devices
```

### Important Reminders:
- ✓ Never use these techniques outside controlled environments
- ✓ Always get written permission before security testing
- ✓ Document all activities in the lab
- ✓ Report vulnerabilities responsibly
- ✓ Follow your institution's ethical guidelines

---

## Additional Resources

### Recommended Reading:
- OWASP Phishing Guide
- NIST Cybersecurity Framework
- CISA Phishing Awareness Materials

### Tools for Further Study:
- **Gophish**: Open-source phishing framework
- **SET (Social Engineer Toolkit)**: Security testing platform
- **ZAP/Burp Suite**: Web security testing

### Reporting Real Phishing:
- **reportphishing@apwg.org**: Anti-Phishing Working Group
- **phishing@us-cert.gov**: US-CERT
- Report to the impersonated organization

---

## Lab Report Template

```markdown
# QR Code Phishing Lab Report

**Student Name:** ___________________
**Date:** ___________________
**Course:** ___________________

## Objectives
- Understand QR code phishing mechanics
- Identify phishing indicators
- Develop defensive strategies

## Methodology
[Describe your lab setup and procedures]

## Findings
[Document what you learned]

## Attack Vectors Observed
1. 
2. 
3. 

## Defense Mechanisms Tested
1. 
2. 
3. 

## Recommendations
[Provide security recommendations based on your findings]

## Conclusion
[Summarize key learnings]

## Ethics Statement
I confirm that all activities were conducted in a controlled environment
for educational purposes only.

Signature: ___________________
```

---

## License and Disclaimer

This educational material is provided for cybersecurity training purposes only.
Unauthorized use of these techniques is illegal and unethical.

**Remember:** The goal is to defend, not attack.

---

*Lab created for educational cybersecurity training - Use responsibly*
