![Dark Mode](https://github.com/HishamAHai/dotfiles/blob/master/.screenshots/Screenshot-2021-10-08-20-21.png)
# Awesome Window Mangaer
After using the git version for over a year, I've decided to revert it and go to the stable version.\
I split my rc.lua into various .lua modules for ease of track and modification

# Salat (Prayer) Widget
This widget retrive the times using `curl`, `systemd` and a bash script located at ~/.local/bin
* Make sure that you have a bin directory inside the .local directory and the script prayerTimes.sh is stored there!
* Also make sure that the bin directory is added to your path.
* Edit the coordinates, city, country, method and adjustment in the prayerTimes.sh to suite your current location.
* Create a directory inside the .config and name it systemd, and inside it another directory called user.
* Create two files inside .config/systemd/user, prayerTimes.service and prayerTimes.timer. These two files are stored in this repository, so you can copy and paste theme directly.
* Edit the username in the ExecStart line from *hisham* to your username in the file prayerTimes.service and save it.
* Enable the service and timer using the following commands:
* `systemctl --user enable --now prayerTimes.service`
* `systemctl --user enable --now prayerTimes.timer`
* The timer will update automatically each 8 hours


May Allah adds this small work to my good deeds!
