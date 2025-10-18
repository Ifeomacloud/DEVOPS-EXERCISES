#!/bin/bash

set -euo pipefail


# Configurable threshold (percent)
THRESHOLD=80

DATE="$(date '+%Y-%m-%d %H:%M:%S %Z')"

{
  echo "===== Disk report - $DATE ====="
  echo

  # Show human-readable disk usage
  df -h
  echo

  # Use df -P (POSIX) for stable columns. We'll read fields: filesystem size used avail pcent mountpoint
  warn=0

  # Print header for partitions that exceed threshold (will appear before final message)
  echo "Partitions exceeding ${THRESHOLD}% (if any):"

  # Parse df output
  while read -r filesystem size used avail pcent mountpoint; do
    # remove trailing '%' from percentage
    pnum="${pcent%\%}"

    # ensure it's numeric
    if ! [[ $pnum =~ ^[0-9]+$ ]]; then
      continue
    fi

    if (( pnum > THRESHOLD )); then
      warn=1
      printf "  - %s (%s) mounted on %s: %s used\n" "$filesystem" "$size" "$mountpoint" "$pcent"
    fi
  done < <(df -P | awk 'NR>1 {print $1,$2,$3,$4,$5,$6}')

  echo

  if (( warn )); then
    echo "Disk space running low check system"
  else
    echo "Disk space is healthy."
  fi

  echo
  echo "Report saved to disk_report.txt"
} | tee disk_report.txt
