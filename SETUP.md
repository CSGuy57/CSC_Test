# Repo starter — what's in here and how to install it

Drop these files into the root of your capstone repository, commit, and push.
Everything else in this file takes about ten minutes, once, in Sprint 0.

## Files

```
.github/
  ISSUE_TEMPLATE/
    01-feature.yml     Feature issues, with Definition of Ready built in
    02-bug.yml         Bug reports
    03-spike.yml       Time-boxed research
    04-sprint.yml      One per sprint: planning, checkpoint, review, retro
    config.yml         Turns off blank issues; edit the two links inside
  pull_request_template.md   Definition of Done, as a checklist
devlog/
  README.md
  _TEMPLATE-sprint.md  Copy per sprint, commit daily
docs/
  _TEMPLATE-spike-memo.md
scripts/
  setup-repo.sh        Creates all labels and milestones for you
README.md              Fill this in; it's graded at every milestone gate
```

## Install

1. Copy all of the above into your repo, commit, push.
2. Edit `.github/ISSUE_TEMPLATE/config.yml` — replace `USER/REPO` with your repo path.
3. Edit the dates in `scripts/setup-repo.sh` to match the school calendar.
4. Install the [GitHub CLI](https://cli.github.com), then run `gh auth login`.
5. From inside your repo: `bash scripts/setup-repo.sh`

That creates 16 labels and 7 milestones.

## Five things the script can't do

Do these in the GitHub web UI:

1. **Protect `main`.** Settings → Branches → Add rule → `main` → require a pull request.
   This is what forces you to use branches even though you're working alone.
2. **Create the project board.** Projects → New project → Board.
   Columns: Backlog / Ready / In Progress / In Review / Done.
3. **Add board fields.** Sprint (iteration, 2-week, repeating), Estimate (number),
   Type (single select), Priority (single select).
4. **Link the project** to this repository so issues land on it automatically.
5. **Add your instructor** as a collaborator.

## Using it

- Day 1 of a sprint: open a **Sprint** issue. Fill in the goal and the committed issues.
- Any new work: open a **Feature**, **Bug**, or **Spike** issue. Never work off an
  unwritten task.
- Day 5: fill in the Checkpoint section of the Sprint issue.
- Every change: branch → commit → pull request → read your own diff → merge → delete branch.
- Day 10: fill in Review and Retro, close the Sprint issue, open the next one.
- At each milestone: tag a release and attach a build.

If you keep the Sprint issue current, you never have to look anything up. That's the point.
