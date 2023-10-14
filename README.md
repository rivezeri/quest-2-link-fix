# quest-2-link-fix

A case study for Meta's Link utilities shortcomings.

Oculus Link shares great fault in communication between a native Windows system and its Android operating system. Such faults include:

* Crashing on startup
* Not providing sound between either client
* Abruptly ending the session between either system
* Crashing the Quest 2's entire operating system, thus causing a reboot
etc. etc.

### This is an issue in the Quest 2's guardian system.

Traditionally, the Quest 2 will load each service, which is then immediately interrupted by the Guardian utility. A simple way to notate and check such fault is through use of ADB/Android Developer tools. Such information can be enabled by becoming a developer over your device. With such tool connected, run:

code(adb shell 'dumpsys activity | grep mCurrentUser')

Repeatedly running this will show the exact point of execution in such device, therefore showcasing the fault in this headset.

In order for this script to work, the following dependencies must be met:
* ADB
* Developer options on the Quest
* Replacing the serial := variable with your unique devices serial number. This is found by listing adb devices.
* Grep

AutoHotKey script communicates from the point of the acting client. Sending commands to the headset, following with such checks and edge cases. The headset first starts by rebooting and restarting the Oculus software. Cutting down communication fuss and waiting until each service is respectively loaded. There is a means for restarting the service through AutoHotKey, however running such process requires UAC. This is a less invasive measure.

After reboot, the headset will launch the Link activity repeatedly until Dash is loaded and the service finishes. This effectively removes so many headaches.
