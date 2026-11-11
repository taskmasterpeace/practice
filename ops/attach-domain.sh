#!/usr/bin/env bash
# Runs every 15 min (Windows task "practice-attach-domain"). When practice.machinekinglabs.com
# points at GitHub, attach it as the Pages custom domain, then remove the task.
LOG=D:/git/practice/ops/attach-domain.log
if nslookup -type=CNAME practice.machinekinglabs.com 1.1.1.1 2>/dev/null | grep -qi "github.io"; then
  gh api -X PUT repos/taskmasterpeace/practice/pages -f cname=practice.machinekinglabs.com >>"$LOG" 2>&1 \
    && echo "$(date) attached domain" >>"$LOG" \
    && schtasks //Delete //TN practice-attach-domain //F >>"$LOG" 2>&1
  # turn on https once GitHub has the cert (retry later runs if not yet)
else
  echo "$(date) dns not ready" >>"$LOG"
fi
