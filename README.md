# quest-2-link-fix

A case study/solution Meta Quest Link shortcomings. This is not a summative fix. This is a proposal and a workaround to the inherent fundamental issues with the Meta Quest 2's wired linking system.

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
* Quest link is already installed, service running
* AutoHotKey
* ADB
* Developer options on the Quest (and marking your desktop as a trusted device to send commands)
* Replacing the serial := variable with your unique devices serial number. This is found by listing adb devices.
* Grep
~~* Disabling Guardian (unfortunately. Use OVR Advanced Settings to alleviate any issue)~~ No longer necessary. Link launches now while Guardian sits in the background.

AutoHotKey script communicates from the point of the acting client. Sending commands to the headset, following with such checks and edge cases. The headset first starts by rebooting and restarting the Oculus software. Cutting down communication fuss and waiting until each service is respectively loaded. There is a means for restarting the service through AutoHotKey, however running such process requires UAC. This is a less invasive measure.

Do note the F23 keybind. To use this script on clicking the script, simply remove the F21:: {} brackets and this will run automatically.

After reboot, the headset will launch the Link activity repeatedly until Dash is loaded and the service finishes. This effectively removes so many headaches. Oculus on Boot is an example of this (and outdated).

### Also recommended: [Oculus Killer](https://github.com/LibreQuest/OculusKiller).
This tool goes even further and going right to SteamVR. Saving heaps worth in performance.


### With that information out of the way, let's achieve the desired result.
- Register your Quest for Developer settings (This changes so often, it's best to follow Meta's documentation). [Developer account](https://developer.oculus.com/sign-up/)
This allows modification (ADB commands) to be sent to the headset. This is required to hijack MainActivity, set timeouts, and restart the headset.
- Enable developer mode on the Meta Horizon app. (This also changes so often, I'd recommend following documentation).
- Install [chocolatey](https://chocolatey.org/), the Windows package manager.

From choco, we can satisfy the needed dependencies with:
```
choco install grep adb autohotkey
```

- Run 'adb devices'. Extract the serial number string from the headset's listing.

Example output:
```
PS C:\Users\Rhys> adb devices
List of devices attached
(extracted serial #)  device
```
From running this command, you'll receive a screen on the Quest that requests authorization. Mark always accept and move on.

Take (extracted serial #), and replace the "serial" inside the code block. ie
```serial := "(extracted serial #)" ```
- Simply double click, the headset will have restart sent to it, all Oculus services will restart, wait for the process to populate, launch Link, and everything will work without a hitch.
