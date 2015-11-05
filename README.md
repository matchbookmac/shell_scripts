## Shell Scripts

<a href="APP LINK IF APPLICABLE" target="#"><APP LINK NAME></a>

By Ian MacDonald (<a href="https://github.com/matchbookmac" target="#">GitHub</a>)

@ Epicodus Programming School, Portland, OR

GNU General Public License, version 3 (see below). Copyright (c) 2015 Ian C. MacDonald.

### Description

**Shell Scripts**

Bash scripts for automating remote work setup with familiar settings.

`setup.sh` will download and setup the local `.bash_profile`, `vim.rc` for vim editor, Atom editor preferences, Chrome, and scaffolding scripts for JS and Ruby. Once the setup is complete, you can run the following commands:

```console
> jsproj [project name]
```
Will setup a JavaScript project in either the `Sites` directory or the `Desktop` directory if you are signed in as 'Guest'

```console
> rsproj [project name]
```
Will do the same thing as above, but for a Ruby project using Sinatra.

`.bash_profile` also contains a number of aliases for git shortcuts and other commonly used commands. Please read through the <a href="https://github.com/matchbookmac/dotfiles/blob/master/.bash_profile" target="#">`.bash_profile`</a> itself to see what they do, as their use is fairly straightforward.

### Author(s)

Ian MacDonald

### Setup

This app was written in `shell`.

```console
mkdir -p ~/code/
git clone https://github.com/matchbookmac/shell_scripts.git ~/code/shell_scripts
chmod +x ~/code/setup.sh
~/code/setup.sh
source ~/.bash_profile
```
OR
```console
> curl https://raw.githubusercontent.com/matchbookmac/shell_scripts/master/setup.sh > ~/setup.sh && chmod +x ~/setup.sh &&  ~/setup.sh && source ~/.bash_profile
```


Clone These Scripts:

```console
> git clone https://github.com/matchbookmac/shell_scripts.git

```
To also get the dotfiles that `setup.sh` uses,
```console
> git clone https://github.com/matchbookmac/dotfiles.git

```

### License ###
Copyright  (C)  2015  Ian C. MacDonald

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
