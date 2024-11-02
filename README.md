# Dotfiles

To my future self,

## for macOS

In the machine to be set upped, first install command line tools with `xcode-select --install`.

Set the machine name in the settings and restart.
- in German go to Systemeinstellungen > Freigaben > Gerätename
- in English go to System Preferences > Sharing > Computer Name

Sign in App Store (to allow app installation with `mas` in Homebrew).

Clone this repository with
`git clone https://gitlab.com/pereBohigas/.dotfiles.git`

Run the initialization [script](./bootstrap.sh) with `./bootstrap.sh`.

And later on follow the steps in the [list](./macOS_configuration_steps.md)

Greetings from the past

## for Raspberry Pi

- Install git `sudo apt install git -y`

- Clone this repository with
`git clone https://gitlab.com/pereBohigas/.dotfiles.git`

- Run the initialization [script](./bootstrap_raspotify.sh) with `./bootstrap_raspotify.sh`.

