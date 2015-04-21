iPhreak (aka WozBox) can be used to play [DTMF](http://en.wikipedia.org/wiki/Dual-tone_multi-frequency) telephone tones. These tones can be used for both legit and not-so-legit purposes. I advise against any unethical use of this software because you most likely will only achieve getting yourself in trouble.

This project was mostly started as a demo. The idea of having a clone of the Blue Boxes that were sold by Steve Wozniak to fund the Apple I to would be AT&T phone phreakers, would complete the circle by having it on the Apple iPhone, partnered with AT&T.

# WARNNG #
**Do not play these tones into a land line phone receiver if you value your freedom!**
Maybe that's an over statement, but still, don't say I didn't warn you.

# Progress #
The app currently looks like the screen shot below. It is capable of DTMF tones in operator "Blue Box" and standard carrier "Silver Box" flavors. It also has "Red Box" coin insertion tones. The "Blue Box" is skinned after Steve Wozniaks' [blue box](http://en.wikipedia.org/wiki/Image:Blue_Box_in_museum.jpg) design.

# TODO #
  * **Update for iPhone 2.0** - In progress
  * Add about box
  * Implement preferences
  * Localize [Red Box](http://en.wikipedia.org/wiki/Red_box_(phreaking)) (pay phone change tones)
  * Add tone queuing with option to disable
  * Fix intermittent stuttering audio
  * Create LCD or figure out TPLCDTextView if possible
  * Fix play/pause length timer. May need to pre-render samples
  * Maybe add scrolling view optional to the ButtonBar setup
  * Build ButtonBar dynamically
    * ButtonBarView class needs to be changed as well
  * Add localization support to KeyPad class

![http://www.joemattiello.com/iphreak/images/sc1.jpg](http://www.joemattiello.com/iphreak/images/sc1.jpg)
![http://www.joemattiello.com/iphreak/images/sc2.jpg](http://www.joemattiello.com/iphreak/images/sc2.jpg)
![http://www.joemattiello.com/iphreak/images/sc3.jpg](http://www.joemattiello.com/iphreak/images/sc3.jpg)
![http://www.joemattiello.com/iphreak/images/sc4.jpg](http://www.joemattiello.com/iphreak/images/sc4.jpg)
![http://www.joemattiello.com/iphreak/images/sc5.jpg](http://www.joemattiello.com/iphreak/images/sc5.jpg)

# To Build #
  * Download with SVN using the instructions on the Source page.
  * On your build machine, copy ~/.ssh/id\_rsa.pub to ~/.ssh/authorized\_keys on the iPhone (this sets up non-username login)
    * scp ~/.ssh/id\_rsa.pub root@iphone:~/.ssh/authorized\_keys
  * Change the permissions on the iPhone like so:
```
chmod 755 /var/root
chmod 700 /var/root/.ssh
chmod 644 /var/root/.ssh/authorized_keys
```
  * Uncomment and change IPHONE\_IP in the Makefile, or set an env variable of the same name.
  * For automatic springboard restart, please install Erica Sadun's iPhone tools.

# Disclaimer #

Phone phreaking is illegal in probably most parts of the world that I know of. In fact, in the US there aren't any systems left that respond to 2600 Hz. Don't attempt to actually use these on a live phone circuit, except the Silver Box. If you do something stupid it's not my problem. You've been warned.

If you're wondering why I made this app then, it's for nostalgia and practice honestly. Oh, and the irony. I never phreaked a phone system before in my life so I don't even know if this app would even work. I'll only test the Silver Box function bcs that may actually be useful for something. Maybe an analog dial plugin for AddressBook.

# Credit #
Designed and coded by Joe Mattiello.
Tone generation code used with permission from Sean Heber (iApp-a-Day)
