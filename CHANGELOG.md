## 2015-11-12 - Release 1.1.1
### Summary
Let Yum repo servers use their own rsync mirrors as repos.

#### Features
- For each `yumserver_rsync_mirror` create a `yum_repository` so the Yum server can use that repo if it needs it.

## 2015-11-10 - Release 1.1.0
### Summary
Added the ability to mirror a repo that is available via rsync.

#### Features
- Mirror yum repos that provide rsync as an option.

#### Bugfixes
- Add regression test.

## 2015-11-10 - Release 1.0.2
### Summary
Fix NGINX config.

#### Bugfixes
- [NGINX recipe does not configure basepath](https://github.com/kemra102/yumserver-cookbook/issues/1)

## 2015-10-11 - Release 1.0.1
### Summary
Minor doc updates.

## 2015-10-11 - Release 1.0.0
### Summary
Initial release. Includes basic functionality.

#### Features
- Mirrors Yum repos.
- Serves Yum repos via NGINX.

