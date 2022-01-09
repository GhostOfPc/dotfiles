![Dark mode](https://github.com/HishamAHai/dotfiles/blob/master/.screenshots/WindowManagerDark.png)
![Dark mode](https://github.com/HishamAHai/dotfiles/blob/master/.screenshots/WindowManagerLight.png)
# Awesome Window Mangaer
After using the git version for over a year, I've decided to revert it and go to the stable version.  
I split my rc.lua into various .lua modules for ease of track and modification  
## Useful Keybindings to get started  
1. Note 1: Keep in mind that the `Right Alt` key works only for the ***Spanish keyborad layout***. For other layouts you should assign a different key
2. Note 2: Its important to use ***kitty terminal*** which is keybinded to the Enter key  
3. Note 3: You can get a list of all keybindings in AwesomeWM by pressing `Super + s`  

|   Key                 |   Function            |
|   ----------          |   ------------        |
|   `Super + Enter`         |   Open Terminal       |
|   `Super + Shift + c`         |   Close any opened window       |
|   `Super + Shift + r`         |   Restart AwesomeWM       |
|   `Super + Shift + q`         |   Kill AwesomeWM       |
|   `Super + p`         |   Open dmenu launcher |
|   `Super + c`         |   Open browser        |
|   `Super + f`         |   Open file manager   |
|   `Right Alt + Esc`   |   Open power menu     |

# Salat (Prayer) Widget
This widget pull the times using `curl`, `systemd`, `mpv` and a bash script located at ~/.local/bin
* Make sure that you have a bin directory inside the .local directory and the script prayerTimes.sh is stored there!
* Also make sure that the bin directory is added to your path.
* Edit the coordinates, city, country, method and adjustment in the prayerTimes.sh to suite your current location.
    * `curl` is used to download the times to a json file.
    * `mpv` is used to play the Azan
    * `systemd` is used to schedule the download time
* Create a directory inside the .config and name it systemd, and inside it another directory called user.
* Create two files inside .config/systemd/user, prayerTimes.service and prayerTimes.timer. These two files are stored in this repository, so you can copy and paste theme directly.
* Edit the username in the ExecStart line from *hisham* to your username in the file prayerTimes.service and save it.
* Enable the service and timer using the following commands:
* `systemctl --user enable --now prayerTimes.service`
* `systemctl --user enable --now prayerTimes.timer`
* The timer will update automatically each 8 hours


May Allah adds this small work to my good deeds!
