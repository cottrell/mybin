#!/bin/bash

################################################################################
# System & Docker Cleanup Script
################################################################################
#
# This script safely clears disk space by removing:
# - Package manager caches (apt)
# - Unused dependencies
# - Old journal logs
# - Temporary files
# - Unused Docker images and containers
#
# USAGE:
#   chmod +x clean_up.sh
#   ./clean_up.sh
#
# SAFETY:
#   - Prompts for confirmation before destructive operations
#   - Logs all operations to $HOME/logs/cleanup_*.log
#   - Uses filters to preserve recent data (7+ days)
#
################################################################################

set -euo pipefail

# Create logs directory
mkdir -p "$HOME/logs"
TIMESTAMP=$(/bin/date +%Y-%m-%dT%H:%M:%S)
LOG_FILE="$HOME/logs/cleanup_${TIMESTAMP}.log"

{
  echo "================================"
  echo "System & Docker Cleanup Started"
  echo "Timestamp: $TIMESTAMP"
  echo "================================"
  echo ""

  # Function to prompt user
  prompt_user() {
    local question="$1"
    local response
    read -p "$question (y/n) " -n 1 -r response
    echo ""
    [[ $response =~ ^[Yy]$ ]]
  }

  # ============================================================================
  # APT PACKAGE MANAGER CLEANUP
  # ============================================================================
  echo "[1/5] Package Manager Cleanup..."
  if prompt_user "Clear apt package cache?"; then
    echo "  → Running: apt clean"
    sudo apt clean
    echo "  → Running: apt autoclean"
    sudo apt autoclean
    echo "  ✓ Apt cache cleared"
  else
    echo "  ✗ Skipped apt cache cleanup"
  fi
  echo ""

  # ============================================================================
  # REMOVE UNUSED DEPENDENCIES
  # ============================================================================
  echo "[2/5] Removing Unused Dependencies..."
  if prompt_user "Remove unused dependencies (apt autoremove)?"; then
    echo "  → Running: apt autoremove"
    sudo apt autoremove -y
    echo "  ✓ Unused dependencies removed"
  else
    echo "  ✗ Skipped dependency removal"
  fi
  echo ""

  # ============================================================================
  # JOURNAL LOG CLEANUP
  # ============================================================================
  echo "[3/5] Cleaning Journal Logs..."
  if prompt_user "Clear journal logs older than 30 days?"; then
    echo "  → Running: journalctl --vacuum-time=30d"
    sudo journalctl --vacuum-time=30d
    echo "  ✓ Old logs cleaned"
  else
    echo "  ✗ Skipped journal cleanup"
  fi
  echo ""

  # ============================================================================
  # TEMPORARY FILES CLEANUP
  # ============================================================================
  echo "[4/5] Cleaning Temporary Files..."
  if prompt_user "Clear temporary files (/tmp and /var/tmp)?"; then
    echo "  → Clearing /tmp/*"
    sudo rm -rf /tmp/*
    echo "  → Clearing /var/tmp/*"
    sudo rm -rf /var/tmp/*
    echo "  ✓ Temporary files cleared"
  else
    echo "  ✗ Skipped temp file cleanup"
  fi
  echo ""

  # ============================================================================
  # DOCKER CLEANUP
  # ============================================================================
  if command -v docker &> /dev/null; then
    echo "[5/5] Docker Cleanup..."

    # Prune containers older than 7 days (168 hours)
    if prompt_user "Prune Docker containers unused for 7+ days?"; then
      echo "  → Running: docker container prune (168h+ unused)"
      /usr/bin/docker container prune --filter "until=168h" -f | tee -a "$LOG_FILE"
      echo "  ✓ Old containers pruned"
    else
      echo "  ✗ Skipped container prune"
    fi
    echo ""

    # Prune unused images
    if prompt_user "Prune unused Docker images (including dangling)?"; then
      echo "  → Running: docker image prune (all unused, 168h+ old)"
      /usr/bin/docker image prune -a --filter "until=168h" -f | tee -a "$LOG_FILE"
      echo "  ✓ Unused images pruned"
    else
      echo "  ✗ Skipped image prune"
    fi
    echo ""
  else
    echo "[5/5] Docker Cleanup..."
    echo "  ⚠ Docker not installed, skipping"
    echo ""
  fi

  # ============================================================================
  # SUMMARY
  # ============================================================================
  echo "================================"
  echo "Cleanup Completed!"
  echo "Log saved to: $LOG_FILE"
  echo "================================"
  echo ""
  echo "To check freed space, run:"
  echo "  df -h"

} 2>&1 | tee -a "$LOG_FILE"
