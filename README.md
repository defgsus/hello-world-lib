# Test repo for releasing a unix package

[![.github/workflows/create-release.yml](https://github.com/defgsus/hello-world-lib/actions/workflows/create-release.yml/badge.svg?branch=main)](https://github.com/defgsus/hello-world-lib/actions/workflows/run-tests.yml)
[![.github/workflows/run-tests.yml](https://github.com/defgsus/hello-world-lib/actions/workflows/run-tests.yml/badge.svg?branch=development)](https://github.com/defgsus/hello-world-lib/actions/workflows/run-tests.yml)

[https://defgsus.github.io/hello-world-lib](https://defgsus.github.io/hello-world-lib)

---

The actual script is 

```shell
./hello-world
```

which prints "Hello World!"

Tests are run like this:

```shell
./run-tests.sh
```

Previewing the man page:

```shell
./preview-mangage.sh
```


## TODO

- [ ] Trigger releases via tags
- [ ] Build package (via github actions)
- [ ] Build a manpage (via github actions)
- [ ] Publish documentation on github pages (via github actions)
- [ ] Supply chain security
  - [ ] Check through https://docs.github.com/en/actions/reference/security/secure-use
  - [ ] Check through https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions
  - [x] Use commit sha for pinning third-party actions
    - Enforce with `Settings > Actions > General > Actions permissions > Require actions to be pinned to a full-length commit SHA`
  - [x] Make sure, nobody triggers github actions from outside (like with https://nx.dev/blog/s1ngularity-postmortem#the-vulnerability)
    - Set `Settings > Actions > General > Approval for running fork pull request workflows from contributors` to `Require approval for all external contributors`
  - [x] Least privilege 
    - Leave `Settings > Actions > General > Workflow permissions` at `Read repository contents and packages permissions`
    - Use `permissions` option in specific workflows as needed 
  - [x] Protect all branches from force-pushing (it just messes things up)


## What maintainers do ...

### To create a new release

```shell
git checkout development
git pull

# ... develop stuff ...
# git add / git commit / git push ...

git commit
# create annotated tag with new version (check `git tag -l` to see previous tags) 
git tag -a v1.2.3

git push && git push --tags

# create pull-request `development -> main` on github ... and merge  
```
