ChangeLog
---------

### v2.1.0
*(2017-07-27)*

* Support for Redmine 3.4
* Add "Maintenance Mode" as a separate entry in admin menu
* New locale *Simplified Chinese* `zh` (PR #11, Thanks to @archonwang)
* New locale *Czech* `cs` (PR #9, Thanks to @tuten69)


### v2.0.1
*(2015-02-10)*

* support for the "redmine_sudo" plugin
  * https://github.com/jbbarth/redmine_sudo


### v2.0.0
*(2015-02-10)*

* maintenance messages support text formatting in textile or markdown style
  * depending on the global redmine setting
* block ALL public pages and redirect to login
* display additional hint in the login window -> admin only during maintenance
* use 'deface' gem/plugin for views
  * make sure to install this redmine plugin first: Redmine Base Deface (https://github.com/jbbarth/redmine_base_deface)


### v1.1.0
*(2014-08-08)*

* This fixes issues for accidentally logged out admin users which couldn't log in anymore during maintenance time


### v1.0.1
*(2014-07-15)*

* Bugfix release


### v1.0.0
*(2014-07-14)*

* initial release of 'redmine_maintenance_mode'
