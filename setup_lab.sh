#!/bin/bash

# QR Code Phishing Lab Setup Script
# Educational purposes only

echo "================================================"
echo "QR Code Phishing Lab - Setup Script"
echo "Educational Cybersecurity Project"
echo "================================================"
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3 first."
    exit 1
fi

echo "✓ Python 3 detected"

# Create directory structure
echo ""
echo "Creating directory structure..."
mkdir -p legitimate_page
mkdir -p phishing_page
mkdir -p qr_codes
mkdir -p logs

echo "✓ Directories created"

# Install Python dependencies
echo ""
echo "Installing Python dependencies..."
pip3 install qrcode[pil] pillow --break-system-packages 2>/dev/null || pip3 install qrcode[pil] pillow

if [ $? -eq 0 ]; then
    echo "✓ Python packages installed"
else
    echo "⚠️  Package installation may have failed. Try manually:"
    echo "   pip3 install qrcode[pil] pillow"
fi

# Create legitimate page
echo ""
echo "Creating legitimate login page..."
cat > legitimate_page/index.html << 'EOF'
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
EOF

echo "✓ Legitimate page created"

# Create phishing demo page
echo ""
echo "Creating phishing demonstration page..."
cat > phishing_page/index.html << 'EOF'
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
EOF

echo "✓ Phishing demo page created"

# Make Python scripts executable
chmod +x generate_qr.py
chmod +x generate_custom_qr.py

echo ""
echo "================================================"
echo "✓ Setup complete!"
echo "================================================"
echo ""
echo "Next steps:"
echo ""
echo "1. Generate QR codes:"
echo "   python3 generate_qr.py"
echo "   python3 generate_custom_qr.py"
echo ""
echo "2. Start test servers (in separate terminals):"
echo "   Terminal 1: cd legitimate_page && python3 -m http.server 8000"
echo "   Terminal 2: cd phishing_page && python3 -m http.server 8001"
echo ""
echo "3. Open the QR codes in qr_codes/ and scan them with your phone"
echo ""
echo "4. Read the full lab guide: qr_phishing_lab.md"
echo ""
echo "⚠️  REMEMBER: Educational purposes only!"
echo "================================================"
