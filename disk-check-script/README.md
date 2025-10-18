# Disk-Check

## Overview
`disk-check` is a simple yet powerful **Bash script** that monitors your system’s disk usage.  
It prints the **current date and time**, displays a summary of all mounted file systems, and checks if any partition is above a configurable threshold (default: 80%).

If any partition exceeds the threshold, the script warns the user with  
`"Disk space running low check system"`.  
Otherwise, it reports `"Disk space is healthy."`.

All results are saved to an output file named **`disk_report.txt`** for reference or logging.

---

##  Features
- Displays **current date and time** in the report header.
- Shows **human-readable disk usage** (`df -h`).
- Automatically checks for **high disk usage** above a defined threshold (default 80%).
- Prints a **clear status message** for system health.
- **Logs** the full report into `disk_report.txt`.
- Easy to configure, lightweight, and requires no dependencies.

---

## Requirements
- Linux or macOS system with **Bash** (version 4+ recommended)
- Standard core utilities: `df`, `awk`, `date`, and `tee`

No external packages or root privileges are required.

---

## Installation

1. Clone or download this repository:
   ```bash
   git clone https://github.com/Ifeomacloud/disk-check-script.git
   cd disk-check-script

2. Make the script executable: 
   chmod +x disk-check.sh

## Usage

Run the script from your terminal:. /disk-check.sh

## Example output:

===== Disk report - 2025-10-16 09:35:22 UTC =====

Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   40G   10G  80% /
tmpfs           1.9G  200M  1.7G  11% /run
...

Partitions exceeding 80% (if any):
  - /dev/sda1 (50G) mounted on /: 80% used

Disk space running low check system

## Report saved to disk_report.txt


# Output File

Each time you run the script, the full output is saved (and overwritten) in:

disk_report.txt


