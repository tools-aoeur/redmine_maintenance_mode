Redmine Maintenance Mode plugin
========================

Plugin to prevent users from using Redmine while system operations are being done.

Only already logged-in administrators have access to the redmine system during maintenance time whereas a configurable maintenance notice is shown to "normal" users.

You can also **schedule maintenance windows.** Users will then be notified in advance with a configurable banner message. If maintenance time has come, system will be put in maintenance mode automatically!

**Be aware that this plugin only blocks non-admin users from the system, while the redmine rails stack is still running!**


License
-------

*redmine_maintenance_mode* plugin is released under the MIT License.
