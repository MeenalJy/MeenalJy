#!/bin/bash

# Enforce strict error handling
set -e

# Define variables
REPO_DIR=$(pwd)
BRANCH="main" # Or 'master' depending on your repo setup
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

echo "🚀 Initiating deployment from Mac4 at $TIMESTAMP..."

# Check if we are in a git directory
if [ ! -d ".git" ]; then
  echo "❌ Error: Not a valid Git repository."
  exit 1
fi

# Check for uncommitted changes
if [ -z "$(git status --porcelain)" ]; then
  echo "No changes detected. Working tree is clean."
  exit 0
fi

echo "Staging changes..."
git add .

echo "Committing changes..."
# Accept an optional commit message as a script argument, otherwise use default
COMMIT_MSG=${1:-"Automated deployment from Mac4: $TIMESTAMP"}
git commit -m "$COMMIT_MSG"

echo "Pushing to GitHub via secure SSH..."
git push origin "$BRANCH"

echo "Deployment successful!"