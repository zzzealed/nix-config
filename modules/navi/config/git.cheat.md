% git, merge
# Pull and merge
git pull --no-rebase

% git, squash
# Squash latest commit
git reset --soft HEAD~1
git commit -m "squash"
git push --force
