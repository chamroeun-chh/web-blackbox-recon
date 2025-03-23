# Web Blackbox Recon Script
A one-shot script to perform passive and active reconnaissance on web targets. Perfect for blackbox penetration testing, bug bounty, or general info gathering.

## Features
- WHOIS, DNS, and Subdomain enumeration
- Directory brute-forcing
- Passive URL & endpoint collection
- Tech stack detection
- Parameter fuzzing
- Nuclei vulnerability detection

## Requirements
Install these tools before running:
```bash
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/tomnomnom/assetfinder@latest
go install github.com/tomnomnom/gau@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/hakluke/hakrawler@latest
sudo apt install whatweb gobuster arjun -y

## Usage
TARGET="dashlane.com"
chmod +x web_recon.sh
./web_recon.sh

## Output
All recon data is saved in structured folders under recon-[target].

