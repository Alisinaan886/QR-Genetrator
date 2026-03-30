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
