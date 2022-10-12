Redmine Maintenance Mode plugin
===============================

Plugin to prevent users from using Redmine while system operations are being done.

Only administrators have access to the redmine system during maintenance time whereas a configurable maintenance notice is shown to other users. Also, login for normal users is blocked!

You can also **schedule maintenance windows.** Users will then be notified in advance with a configurable banner message. If maintenance time has come, system will be put in maintenance mode automatically. This will log out non-admin users and prevent them from logging back in.

**Be aware that this plugin only blocks non-admin users from the system, while the redmine rails stack is still running! It will NOT shut down redmine!**

* This plugin is tested with Redmine v3.0 - v3.4, v4.0, v5.0
* This plugin is listed in the [redmine.org plugin repository](http://www.redmine.org/plugins/redmine_maintenance_mode)

Installation
------------

* Clone or [download](https://github.com/tofi86/redmine_maintenance_mode/releases) this repo into your **redmine_root/plugins/** folder

```bash
git clone https://github.com/tofi86/redmine_maintenance_mode.git
```

* You have to run the plugin rake task to provide the assets (from the Redmine root directory):

```bash
rake redmine:plugins:migrate RAILS_ENV=production
```

* Restart redmine

Upgrade from plugin version 1.x
-------------------------------

* change to the plugin directory in `redmine_root/plugins/redmine_maintenance_mode`
* update the git repository by running

```bash
git pull
```

* change back to the plugins directory `redmine_root/plugins/`
* change to your redmine root directory and run the following commands:

```bash
bundle install
rake redmine:plugins:migrate RAILS_ENV=production
```

* Restart redmine

License
-------

*redmine_maintenance_mode* plugin is released under the MIT License.
