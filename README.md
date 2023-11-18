# Assetto Corsa: A7-Impulse Trigger Vibration App

[![Version](https://img.shields.io/badge/Version-0.0_(Experimental)-blue.svg)](https://github.com/Akeyroid7/a7-impulse/releases)
[![Compatibility](https://img.shields.io/badge/CSP-0.2.0-green.svg)](https://acstuff.ru/patch/#0.2.0)

[![Banner](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Xbox-One-Console-wController-FL.jpg/2560px-Xbox-One-Console-wController-FL.jpg)](https://ja.wikipedia.org/wiki/Xbox_One#/media/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB:Xbox-One-Console-wController-FL.jpg)

## Assetto Corsa finally met the "Impulse Trigger"

The Xbox One controller, released on 22 November 2013,[^1] features a new "Impulse Trigger" with a rumble motor on each of the left and right triggers.
This feature has been carried over to the current Xbox Series and is also available on Windows PCs.
(It is limited to wired connections. It appears to be available with a [Xbox Wireless Adapter for Windows](https://www.xbox.com/accessories/adapters/wireless-adapter-windows), but not with a Bluetooth connection.)

However, PC software that supports this feature is extremely rare, and I have only seen it working on [Forza Horizon 4 Demo in Microsoft Store](https://www.xbox.com/games/store/forza-horizon-4/9p8cp1l72jxs).

Assetto Corsa is no exception, and since its release in the Steam Early Access program on 8 November 2013,[^2] this feature has not been available until now.
But that Custom Shaders Patch has revolutionized things again.[^3] In v0.2.0, rumble triggers can now be controlled from Lua.

The "Impulse Trigger" and "Assetto Corsa" were born in the same year, and after 10 years, they have met in a miraculous way.

[^1]:https://wikipedia.org/wiki/Xbox_One
[^2]:https://wikipedia.org/wiki/Assetto_Corsa
[^3]:The first revolution for me was [Gamepad FX](https://www.racedepartment.com/downloads/a7-assist-gamepad-fx.53941/), but as you all know, CSP revolutionized AC in many ways.

## What is this app?

This application vibrates the trigger based on tire slip conditions.
It works in gamepad mode only if the controller has an impulse trigger and Steam Input is disabled.

There is no GUI as this is an experimental app in the process of production.
Just install it in the "apps\lua" folder and it will be activated by itself.
If you want to disable it, please click "Disable" in the "CONTENTS" section of CM, or move it to the "apps\lua-off" folder.

Depending on the response, I plan to add the ability to make adjustments via INI file or GUI.

## Installation

This mod requires [**Content Manager**](https://assettocorsa.club/content-manager.html) and [**Custom Shaders Patch**](https://acstuff.ru/patch/) to be installed!

+ Download the latest version from [Releases](https://github.com/Akeyroid7/a7-impulse/releases).
+ Open the "assettocorsa" folder in the downloaded ZIP, and copy the "apps" folder.
+ Paste the folder into your main "assettocorsa" folder.

## Supporting

I am not a programmer in my day job, so I am not sure if I have a preferred writing style. This is my first time using GitHub.

If you have any feedback, please feel free to comment on [Twitter](https://twitter.com/Akeyroid7), [X.com](https://x.com/Akeyroid7) DM, or [our Discord server](https://discord.gg/dgsVUdEyVA).

And, also accepting donations via [PayPal.me](https://paypal.me/Akeyroid7).
If funds are raised, I will purchase DualSense and create a "Adaptive Triggers" app!

---

&copy; 2023 Akeyroid7 &bull; [MIT License](https://gh.io/mit)
