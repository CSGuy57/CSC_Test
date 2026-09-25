#!/usr/bin/env bash
# Capstone repo setup: labels and milestones.
#
# Run this ONCE, from inside your cloned repo, after installing the GitHub CLI
# (https://cli.github.com) and running `gh auth login`.
#
#   bash scripts/setup-repo.sh
#
# Safe to re-run: labels use --force, and existing milestones are skipped.

set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI not found. Install it from https://cli.github.com then run 'gh auth login'."
  exit 1
fi

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
echo "Setting up $REPO"
echo

# ---------------------------------------------------------------- labels ----
label() { gh label create "$1" --color "$2" --description "$3" --force >/dev/null; echo "  label: $1"; }

echo "Creating labels..."
# type
label "feature"    "1D76DB" "Adds or changes something in the project"
label "bug"        "D73A4A" "Something is broken"
label "spike"      "6F42C1" "Time-boxed research; deliverable is knowledge"
label "sprint"     "0E8A16" "Sprint tracking issue"
label "art"        "E99695" "Models, textures, audio, visual design"
label "docs"       "0075CA" "README, proposal, write-ups, comments"
label "tech-debt"  "FBCA04" "Works, but will cost you later"
label "chore"      "CFD3D7" "Tooling, build, housekeeping"
# state
label "blocked"    "B60205" "Cannot proceed; says why in the issue"
label "needs-info" "D4C5F9" "Not Ready until more is written down"
# priority
label "p0-now"     "B60205" "Drop everything"
label "p1-high"    "D93F0B" "This sprint"
label "p2-normal"  "FBCA04" "Soon"
label "p3-later"   "C2E0C6" "Someday, maybe never"
# outcome
label "wontfix"    "FFFFFF" "Deliberately not doing this; reason in the issue"
label "cut-scope"  "5319E7" "Removed from scope; recorded, not hidden"

echo

# ------------------------------------------------------------ milestones ----
# EDIT THESE DATES to match your school calendar before running.
create_milestone() {
  local title="$1" due="$2" desc="$3"
  if gh api "repos/$REPO/milestones?state=all" -q '.[].title' | grep -qx "$title"; then
    echo "  milestone exists, skipping: $title"
  else
    gh api "repos/$REPO/milestones" -X POST \
      -f title="$title" -f due_on="${due}T23:59:59Z" -f description="$desc" >/dev/null
    echo "  milestone: $title ($due)"
  fi
}

echo "Creating milestones..."
create_milestone "M0 Proposal approved"      "2026-10-02" \
  "Proposal submitted and defended. Repo and board live."
create_milestone "M1 Core tech proven"       "2026-10-30" \
  "Toolchain builds from source. Technical demo runs. Export runs on a second machine."
create_milestone "M2 Vertical slice"         "2026-12-18" \
  "One complete pass through the core loop, start to finish."
create_milestone "M3 Legible and playable"   "2027-02-13" \
  "A first-time user understands the core interaction. Playtest report written."
create_milestone "M4 Content complete"       "2027-04-09" \
  "All planned content present. Feature freeze begins."
create_milestone "M5 Release candidate"      "2027-05-07" \
  "Bugs triaged, build published, documentation complete."
create_milestone "M6 Defense and postmortem" "2027-05-22" \
  "Public demonstration, final presentation, written postmortem."

echo
echo "Done."
echo
echo "Still to do by hand (two minutes, in the web UI):"
echo "  1. Settings > Branches > add a rule protecting 'main' (no direct pushes)."
echo "  2. Projects > New project > Board. Add columns:"
echo "     Backlog / Ready / In Progress / In Review / Done"
echo "  3. In the project, add fields:"
echo "     Sprint (iteration, 2 weeks, repeating), Estimate (number), Type (single select)"
echo "  4. Link the project to this repository."
echo "  5. Add your instructor as a collaborator."
