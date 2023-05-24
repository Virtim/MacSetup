# Infinite Loop Bash Script with macOS Startup

This repository contains instructions on how to create a bash script that runs a command every 10 minutes. Additionally, it includes steps to make the script run automatically at macOS startup.

## Creating the Bash Script

1. Create a bash script file, say `myscript.sh`, with the following contents:

    ```bash
    #!/bin/bash
    while true
    do
        # Your command here
        echo "Running command..." # replace this with your actual command
        sleep 600 # 600 seconds or 10 minutes
    done
    ```

2. Make the script executable by running this command in the terminal:

    ```bash
    chmod +x myscript.sh
    ```

## Automating the Script on macOS Startup

To have your script run every time your macOS starts up, you will use `launchd`, a service management framework in macOS.

1. Create a plist file, named `com.yourname.myscript.plist`, under `~/Library/LaunchAgents` with the following contents:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.yourname.myscript</string>
        <key>ProgramArguments</key>
        <array>
            <string>/path/to/your/myscript.sh</string> <!-- Replace with your actual script path -->
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
    </dict>
    </plist>
    ```

2. Load your script into the launch control service using the `launchctl load` command:

    ```bash
    launchctl load ~/Library/LaunchAgents/com.yourname.myscript.plist
    ```

**Note:** Be sure to replace "yourname" with your actual username, and "/path/to/your/myscript.sh" with the actual path to your bash script.

Now, your script will run your command every 10 minutes and will start automatically every time your macOS boots up.
