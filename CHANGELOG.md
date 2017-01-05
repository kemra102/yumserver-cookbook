## 2017-01-05 - Release 2.1.0
### Summary
Additional features for custom resources.

#### Features
- Added a `timeout` option for both `yumserver_mirror` & `yumserver_rsync_mirror`.
- Added an `options` option for `yumserver_mirror` allowing you to add additional options to the reposync command.

## 2016-02-14
### Summary
Minor bug fix.

#### Bugfixes
- Fixed a bug that meant the `node['yumserver']['basepath']` attribute wasn't honoured by the `yumserver_mirror` & `yumserver_rsync_mirror` resources.

## 2016-02-11
### Summary
Minor bug fix after a fault was found in production with this cookbook.

#### Bugfixes
- The path defined by the `yumserver_mirror` resource was incorrect. This was causing the `zap` feature to fail on runs after the first. Fixing the defined path in this resource fixed the error with `zap`.

## 2016-02-09
### Summary
Major release with additional features/bug fixes that may break backwards compatibility.

### Features
- Now using `mixlib-shellout` instead of exec resources for `yumserver_mirrror` resources.
- The `createrepo` command ran as part of `yumserver_mirror` resources are now multi-threaded.
- Add `zap` support for `/etc/resposync.repos.d`.
- Now uses the `nginx_server` cookbook to provide the web server.

### Bugfixes
- Fixed a typo in the `yumserver_mirror` resource that prevented the reposync config from beign remove on a `:delete` action.

## 2015-12-02
### Summary
Small bugfix update to make the delete action work properly across custom resources.

#### Bugfixes
- In the mirror resource make sure the reposync file gets deleted by switching the resource type to file instead of template.
- In both resources make sure the base path is deleted recursively (otherwise it will fail as there are packages in them).

## 2015-11-25 1.3.0
### Summary
Large bugix release to ensure mirrored repos are properly updated after the 1st sync.

#### Bugfixes
- Made `reposync` in the `mirror` resource use alternate yum.conf & repo directory to allow them all to be enabled (enabling updates) whithout interfering with the system's yum.
- Made the metadata on `reposync` in the `mirror` resource expire immedietly so package changes are synced more often than every 6 hours.

## 2015-11-22 - Release 1.2.0
### Summary
General improvements to mirror resources.

#### Features
- Optionally (`true` by default) create a `yum_repository` to allow the yumserver to use it's mirrored repos.
- The `yumserver_mirror` resource now correctly removes packages no longer in the upstream repo.
- The `yumserver_mirror` should complete quicker when no packages are updated.

#### Bugfixes
- Disable mirrored repos to avoid issues such as mirroring the same repo for two versions of the same distro and causing update issues on the yumserver.

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
