tag := "0.6.0"

push:
    git push --force
    git tag -d "{{tag}}" || true
    git push --delete origin "{{tag}}" || true
    git tag "{{tag}}"
    git push origin "{{tag}}"
