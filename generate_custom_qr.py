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
