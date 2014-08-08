Redmine Maintenance Mode plugin
========================

Plugin to prevent users from using Redmine while system operations are being done.

Only already logged-in administrators have access to the redmine system during maintenance time whereas a configurable maintenance notice is shown to "normal" users.

You can also **schedule maintenance windows.** Users will then be notified in advance with a configurable banner message. If maintenance time has come, system will be put in maintenance mode automatically!

**Be aware that this plugin only blocks non-admin users from the system, while the redmine rails stack is still running!**

This plugin is tested with Redmine v2.4.x and v2.5.x


Installation
------------

* Clone or download this repo into your **redmine_root/plugins/** folder
```
$ git clone https://github.com/tofi86/redmine_maintenance_mode.git
```
* You have to run the plugin rake task to provide the assets (from the Redmine root directory):
```
$ rake redmine:plugins:migrate RAILS_ENV=production
```
* Restart redmine


License
-------

*redmine_maintenance_mode* plugin is released under the MIT License.
