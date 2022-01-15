<div id="top"></div>
<br />
<div align="center">
  <h1 align="center">SteamCMD Linux Game Server Updater</h3>
</div>

<!-- ABOUT THE PROJECT -->

## About The Project / Bash file

Update your dedicated steam game server on linux - automatically.

1. Download
2. Modify
3. Verify
4. Schedule
5. Done

You will be done in ~15 minutes or less.

<!-- GETTING STARTED -->

## Getting Started

### Prerequisites

- A steam account
- A steam game server installed on Linux

### Installation

1. SSH into your server and go to your game directory

   ```sh
   cd <YOUR GAME SERVER DIRECTORY>
   ```

2. Fetch a copy of the bash file
   ```sh
   curl https://raw.githubusercontent.com/gitsoft/SteamCMD-Linux-Game-Server-Updater/main/checkandupdate.sh --output checkandupdate.sh
   ```
3. Make the bash file executable

   ```sh
   chmod +x checkandupdate.sh
   ```

4. Open the bashfile with a text editor

   Replace \<STEAM APPID GOES HERE\> with a steam appid. No quotes, just the number.

   ```sh
   appid=<STEAM APPID GOES HERE>
   ```

   example for a Project Zomboid Server

   ```sh
   appid=380870
   ```

   You find the steam app id googling your game and visiting the games steam website. The appid is visible in the url.

5. Go to the bottom of the bashfile.

   Replace the template text with real commands to updating and restaring your server.

   ```sh
   if [ $updateserver == true ]; then
    echo "Run server update command"
    <INSERT SERVER UPDATE COMMAND>
    <INSERT SERVER RESTART COMMAND>
   fi
   ```

   below is an example where a project Zomboid server is updated:

   - the game install folder /home/pzuser/pz
   - the server start script came with the installation is named start-server.sh

   ```sh
   if [ $updateserver == true ]; then
    echo "Run server update command"
    ./steamcmd.sh +@sSteamCmdForcePlatformType linux +login anonymous +force_install_dir /home/pzuser/pz +app_update 380870 validate +quit
    ./start-server.sh
   fi
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->

## Usage

### Test the script

```sh
 ./checkupanddate.sh
```

Expected output the first time - (The version will be different for you. That's ok.)

```sh
previous version detected: 0
new version detected: 7913379
```

Expected output after the first time

```sh
previous version detected: 7913379
new version detected: 7913379
```

<p align="right">(<a href="#top">back to top</a>)</p>

## Schedule the script

The bashfile is intended to run from time to time. Please use a reasonable interval of 60 minutes or more. Perhaps just once per day. Every time the script runs a request is sent to api.steamcmd.net. We do not wont to overload this api. That service is provided for free and we should be mindful to put too much pressure on it.

To schedule the script I would use crontab, or a screen/tmux session using watch. Whichever you find best.

### Scheduling example with crontab

open crontab

```sh
sudo crontab -e
```

Add a line for your cron job. Have a look at [crontab-generator.org](https://crontab-generator.org) for examples and syntax help.

Below is an example where the script is executed 0400 each night.

```text
* 4 * * * /home/zomboiduser/pz/checkandupdate.sh >/dev/null 2>&1
```

<p align="right">(<a href="#top">back to top</a>)</p>

### Scheduling example with tmux and a watch statement

If you don't know what screen and tmux is then I suggest you use the crontab method above.

With tmux installed and logged in with your dedicated game user account, start a new session.

```sh
tmux new -s project-zomboid-session
```

In your tmux (or screen) session

```sh
watch -n 86400 /home/zomboiduser/pz/checkandupdate.sh >/dev/null 2>&1
```

(86400 second per day)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## Wait, I dont understand how this works.

Here is an overview that might help you.

![server-update-flow.svg](https://raw.githubusercontent.com/gitsoft/SteamCMD-Linux-Game-Server-Updater/master/server-update-flow.svg)

## Contributing

**You don't.** 🙂 I lack time and enthusiasm for debating with stranger over issues, pull requests and additional ideas that would make this simple script into a bloated project with all sorts of dependencies. You are probably a nice person - but please fuck off. 🕊️

<p align="right">(<a href="#top">back to top</a>)</p>

## It doesn't work on my computer

It sucks to be you. 🤷‍♂️ This script does not come with technical or emotional support. :broken_heart:

<p align="right">(<a href="#top">back to top</a>)</p>

## Why not use python/go/js/rust/fsharp/COBOL/[Chicken](https://esolangs.org/wiki/Chicken)?

Because most people just want to solve a problem real quick and move on with their lives.

Bash and crontab comes preinstalled on Linux. Why not [KISS](https://en.wikipedia.org/wiki/KISS_principle)? :smile:

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

TLDR; Do _whatever_ you want.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments :heart:

- [api.steamcmd.net](https://api.steamcmd.net) - that provides an excellent steamcmd api for free
- [Othneil Drew](https://github.com/othneildrew/Best-README-Template) - from whom I proudly stole a README template :wink:

Go over to [steamcmd.net](https://www.steamcmd.net/) or [jona.io](https://www.jona.io/) and give Jona Koudijs some :heart: - He have obviously put some work into sharing something great with everyone for free. No fee and no account registration required. Just what people might want and no BS.

Thank you Jona! :pray:

And unlike me Jona seems to enjoy intercating with people. So help him out if you can.
