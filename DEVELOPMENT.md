# Overview

* Code is held on github.com
* Releases are:
  * Numbered with [semantic versioning](https://semantic-versioning.org)
  * Automated with github actions (publish to npm etc.) - _**TODO**_: Workflow is disabled ATM, until people are comfy with it
* [Alpha status]: npm packages are held on npmjs.com
* _**TODO**_: Describe other steps performed during a release cycle (David?)

# npm Cheatsheet

* You may need to login to npmjs initially: `npm login` (don't worry, if you _**do**_ need to login, any other npm commands will let you know!)
* `npm version pre(major|minor|patch) --preid=(alpha|beta)` to create a testing version of your next release
* `npm version prerelease` to increment the version of the testing release
* `npm version (major|minor|patch)` to increment the version for the production release

# Release Steps

Notes:
* At this stage of development, `MMC-SERVER` is releasing on `minor` versions (`0.19.0` -> `0.20.0` etc.)
* Alpha releases are not usually issued for testing, only beta (though alpha can easily be incorporated)
* Decide upon what release you're going to perform (major, minor or patch), as this will affect the `npm version pre...` command you'll execute
  * e.g. If your current `version` is `0.19.3`, and you're preparing for a new `major` release, the `version` will now be `1.0.0-beta.0`
  * e.g. If your current `version` is `0.19.3`, and you're preparing for a new `minor` release, the `version` will now be `0.20.0-beta.0`
  * e.g. If your current `version` is `0.19.3`, and you're preparing for a new `patch` release, the `version` will now be `0.19.4-beta.0`

## Publish (alpha or beta) release for testing

Notes:
* If no testing packages are to be released, you can jump straight to the [Production release section](#production-release)
* All testing is performed on a development (feature/release) branch

1. Develop a feature for the release (with commits on a separate feature branch?)
1. Once the feature is ready for testing, automatically increment the version in `package.json`, and tag the git repository:
    1. If this is the _**first**_ version increment for this testing release: `npm version preminor --preid=beta` (this will change the version from, say `0.19.0` to `0.20.0-beta.0`)
    1. Else: `npm version prerelease` (this will increment the version to e.g. `0.20.0-beta.1`)
1. _**IF**_ automation is enabled (_**TODO**_ only once people are happy), this will now automatically publish an npm package with the `next` tag
1. _**ELSE**_ perform manual steps:
    1. `git push`
    1. `git push origin [TAG-NAME]` (where TAG_NAME is the version value in `package.json`)
    1. `npm publish --tag next`
1. Once the package has been published, beta testers can update with `[sudo] npm install -g @jimmythedog/mmc-server@next` _**TODO**_ name will change
1. Continue the above steps i.e. development, testing & version increments until ready for release
1. Once the features are ready for release, move onto the next section

## Production release

Note: All production releases are performed from the `main` branch
1. Rebase/merge the `Changes-...` branch to the main branch: `git rebase [DEV_BRANCH_NAME]`
1. Increment the production release version, and tag the `git` repository, with: `npm version [patch|minor|major]` (this will increment the version in `package.json` e.g. from `0.19.0` to `0.20.0`, and tag the git repository)
1. _**IF**_ automation is enabled (_**TODO**_ only once people are happy), this will now automatically publish an npm package with the `latest` tag
1. _**ELSE**_ perform manual steps:
    1. `git push`
    1. `git push origin [TAG-NAME]` (where TAG_NAME is the version value in `package.json`)
    1. `npm publish` (Note: If you do not specify the tag with `--tag ...`, the package ia automatically tagged with `latest`)
    1. `npm dist-tag rm @jimmythedog/mmc-server next` to cleanup the published prerelease versions: _TODO_ Change `@jimmythedog`
1. Once that package has been published, end-users can update with `[sudo] npm install -g @jimmythedog/mmc-server` _**TODO**_ name will change in the future

