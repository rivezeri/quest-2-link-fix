﻿# quest-2-link-fix

A case study/solution Meta Quest Link shortcomings. Play Link the right way!

Oculus Link shares great fault in communication between a native Windows system and its Android operating system. Such faults include:

* Crashing on startup
* Not providing sound between either client
* Abruptly ending the session between either system
* Crashing the Quest 2's entire operating system, thus causing a reboot
* Link breaking on restart, causing unplugging and replugging the cable back in.
etc. etc.

### This is an issue in the Quest 2's guardian system.

Traditionally, the Quest 2 will load each service, which is then immediately interrupted by the Guardian utility. A simple way to notate and check such fault is through use of ADB/Android Developer tools. Such information can be enabled by becoming a developer over your device. With such tool connected, run:

```adb shell 'dumpsys activity | grep mCurrentUser'```

Repeatedly running this will show the exact point of execution in such device, therefore showcasing the fault in this headset.

In order for this script to work, the following dependencies must be met:
* AutoHotKey
* ADB
* Developer options on the Quest (and marking your desktop as a trusted device to send commands)
* Replacing the serial := variable with your unique devices serial number. This is found by listing adb devices.
* Grep
* Disabling Guardian (unfortunately. Use OVR Advanced Settings to alleviate any issue)

AutoHotKey script communicates from the point of the acting client. Sending commands to the headset, following with such checks and edge cases. The headset first starts by rebooting and restarting the Oculus software. Cutting down communication fuss and waiting until each service is respectively loaded. There is a means for restarting the service through AutoHotKey, however running such process requires UAC. This is a less invasive measure.

Do note the F23 keybind. To use this script on clicking the script, simply remove the F21:: {} brackets.

After reboot, the headset will launch the Link activity repeatedly until Dash is loaded and the service finishes. This effectively removes so many headaches. Oculus on Boot is an example of this (and outdated).

### Also recommended: [Oculus Killer](https://github.com/LibreQuest/OculusKiller).
This tool goes even further and going right to SteamVR. Saving heaps worth in performance.
