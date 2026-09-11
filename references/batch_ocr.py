import fitz
import subprocess
import os

pdf_path = "/Users/antoniomachuca/Downloads/Five New Results on Conway's 99-Graph Problem.pdf"
doc = fitz.open(pdf_path)

output_lines = []
for i in range(len(doc)):
    page = doc[i]
    pix = page.get_pixmap(dpi=150)
    img_name = f"temp_page_{i+1}.png"
    pix.save(img_name)
    
    # Run swift ocr
    res = subprocess.run(["swift", "ocr.swift", img_name], capture_output=True, text=True)
    output_lines.append(f"\n\n=== PAGE {i+1} ===\n\n" + res.stdout)
    if os.path.exists(img_name):
        os.remove(img_name)

with open("paper_elmar_guseinov.txt", "w") as f:
    f.writelines(output_lines)

print("Batch OCR completed. Total pages processed:", len(doc))
