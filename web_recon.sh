#!/bin/bash

TARGET="victim.com"
FULL_URL="https://$TARGET"
OUTPUT_DIR="recon-$TARGET"

mkdir -p $OUTPUT_DIR/{whois,dns,subdomains,tech,dirs,endpoints,params,nuclei}

echo "[+] Starting recon on $TARGET 🔍"

# --- Passive Recon ---
echo "[*] Running WHOIS..."
whois $TARGET > $OUTPUT_DIR/whois/whois.txt

echo "[*] Collecting DNS info..."
dig $TARGET any > $OUTPUT_DIR/dns/dig.txt
host -a $TARGET > $OUTPUT_DIR/dns/host.txt
nslookup $TARGET > $OUTPUT_DIR/dns/nslookup.txt

echo "[*] Getting subdomains (passive)..."
subfinder -d $TARGET -silent > $OUTPUT_DIR/subdomains/subfinder.txt
assetfinder --subs-only $TARGET >> $OUTPUT_DIR/subdomains/assetfinder.txt
sort -u $OUTPUT_DIR/subdomains/*.txt > $OUTPUT_DIR/subdomains/all.txt

echo "[*] Collecting URLs from Wayback Machine & GAU..."
waybackurls $TARGET > $OUTPUT_DIR/endpoints/waybackurls.txt
gau $TARGET > $OUTPUT_DIR/endpoints/gau.txt
sort -u $OUTPUT_DIR/endpoints/*.txt > $OUTPUT_DIR/endpoints/all_endpoints.txt

# --- Active Recon ---
echo "[*] Probing with httpx..."
httpx -u $FULL_URL -title -tech-detect -status-code -ip -cdn > $OUTPUT_DIR/tech/httpx.txt

echo "[*] Scanning tech stack..."
whatweb $FULL_URL > $OUTPUT_DIR/tech/whatweb.txt

echo "[*] Directory brute force..."
gobuster dir -u $FULL_URL -w /usr/share/wordlists/dirb/common.txt -t 50 -o $OUTPUT_DIR/dirs/gobuster.txt

echo "[*] Crawling endpoints..."
katana -u $FULL_URL -silent > $OUTPUT_DIR/endpoints/katana.txt
hakrawler -url $FULL_URL -depth 2 > $OUTPUT_DIR/endpoints/hakrawler.txt
sort -u $OUTPUT_DIR/endpoints/*.txt > $OUTPUT_DIR/endpoints/combined.txt

echo "[*] Parameter discovery..."
arjun -u $FULL_URL --output $OUTPUT_DIR/params/arjun.txt

echo "[*] Running nuclei on target..."
nuclei -u $FULL_URL -o $OUTPUT_DIR/nuclei/nuclei.txt

echo "[+] Recon finished. All results saved in: $OUTPUT_DIR 🎯"
