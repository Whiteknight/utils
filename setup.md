# Setup a new Computer
Steps listed so I don't forget anything

1. Install a proper browser
2. Create ~/bin directory, add it to %PATH%
3. Install Chocolatey
   1. Install Notepad++
      1. Add solarized (Dark) theme if not already available
      2. Change settings (Don't keep previous editors open, etc)
   2. Install ag ("silver surfer")
   3. Install Ruby
   4. Install Python
   5. Install nodejs
   6. Install ConsoleZ
   7. Install Windows Terminal
      1. import settings
   8. Install jq
   9.  Install 7zip
   10. Install git/bash
   11. Install nuget (dotnet nuget doesn't have all the features)
4. Setup Git/Bash (can probably install with choco)
   1. Clone this utils repo
   2. Copy over ~/.bashrc
   3. Copy over ~/.gitconfig
   4. Create new SSH key and insert into github
   5. Install git-num
   6. Add git-bash to ConsoleZ
   7. Make sure the thing doesn't use vim
   8. Make sure we have curl (otherwise install it separately)
5. Install VisualStudio
   1. Install resharper (if available)
   2. import settings
   3. Make sure all necessary versions of the .NET SDK are installed
   4. Install Productivity powertools
   5. Install Guidelines
6. Install Visual Studio Code
   1. Add C#, Markdown extensions, plus any other recommendations
7. Install SSMS
8. Enable Hyper-V (if not already enabled)
9.  Install Docker Desktop (Linux Containers)
   1.  Consider setting up nuget-klondike, rabbitmq, redis, elasticsearch, sqlserver, postgres, etc. Whatever is needed
10. 