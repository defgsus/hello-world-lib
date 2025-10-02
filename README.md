# Test repo for releasing a unix package

[![.github/workflows/create-release.yml](https://github.com/defgsus/hello-world-lib/actions/workflows/create-release.yml/badge.svg?branch=main)](https://github.com/defgsus/hello-world-lib/actions/workflows/run-tests.yml)
[![.github/workflows/run-tests.yml](https://github.com/defgsus/hello-world-lib/actions/workflows/run-tests.yml/badge.svg?branch=development)](https://github.com/defgsus/hello-world-lib/actions/workflows/run-tests.yml)

[defgsus.github.io/hello-world-lib/](https://defgsus.github.io/hello-world-lib/)

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

- [ ] After merge to `main` branch, the [create-release.yml](.github/workflows/create-release.yml) workflow runs and ...
  - [x] Uses the latest `git tag` for versioning.
    - Merging to `main` without a new `tag` will fail at the `gh create release` stage.
  - [x] Builds a manpage via [pandoc](https://pandoc.org/)
  - [ ] Builds rpm & dpm package
  - [ ] Builds a Mac OS package
  - [x] Publishes release files using the github cli: `gh create release "<tag>"`. 
  - [ ] Publishes documentation on github pages ([defgsus.github.io/hello-world-lib/](https://defgsus.github.io/hello-world-lib/))
    - by committing the `docs/` directory
- [x] On any `pull request` update, the [run-tests.yml](.github/workflows/run-tests.yml) workflow will ...
  - [x] Run tests ([run-tests.sh](run-tests.sh))
  - [x] Test package and doc building ([build-packages.sh](build-packages.sh))
- [ ] Supply chain security
  - [ ] Check through https://docs.github.com/en/actions/reference/security/secure-use
  - [ ] Check through https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions
  - [x] Use commit sha for pinning third-party actions
    - Enforce with `Settings > Actions > General > Actions permissions > Require actions to be pinned to a full-length commit SHA`
  - [x] Make sure, nobody triggers github actions from outside (like with https://nx.dev/blog/s1ngularity-postmortem#the-vulnerability)
    - Set `Settings > Actions > General > Approval for running fork pull request workflows from contributors` to `Require approval for all external contributors`
  - [x] Least privilege 
    - Leave `Settings > Actions > General > Workflow permissions` at `Read repository contents and packages permissions`
    - Use [`permissions`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#permissions) option in specific workflows as needed 
  - [x] Protect all branches from force-pushing (it just messes things up)


## What maintainers do ...

### To create a new release

```shell
git checkout development
git pull

# ... develop stuff ...
# git add / git commit / git push ...
# create a pull-request on github to run the test CI 
# ... git add / git commit / git push ...

# eventually
git commit
# create annotated tag with new version (check `git tag -l` to see previous tags) 
git tag -a v1.2.3

git push && git push --tags

# create pull-request `development -> main` on github, review, merge  
```

For security reasons, it's probably best to **not** use the github client and not 
have a github token on your dev machine and instead manage pull-requests in the browser. 
