# EmlRipper

EmlRipper is a ruby script that allows you to extract attachments from .eml files. It utilizes the Mail gem, a library that provides a simple and elegant way to read, write, and send emails. I created this while playing [Malware_Traffic_analysis_5 challenge](https://cyberdefenders.org/blueteam-ctf-challenges/58) in CyberDefenders after some available tools failed me.

To use the script, you must have Ruby installed on your computer and the Mail gem.Run the script by navigating to the directory where the script is located in your command line and run the command:

`chmod +x EmlRipper.rb`

`sudo ./EmlRipper.rb [OPTIONS]`

The script accepts the following options:

* -s, --source PATH: The directory containing the .eml files to extract attachments. Default is the current working directory.
* -r, --recursive: Allows recursive search for .eml files under the SOURCE directory.
* -f, --files FILE: Specifies a .eml file or a list of .eml files to extract attachments.
* -d, --destination PATH: The directory to extract attachments to. Default is the current working directory.

## Examples:

Extract attachments from all .eml files in the current working directory and save them to the current working directory:

```sudo ./EmlRipper.rb```

Extract attachments from all .eml files in the specified directory and save them to the specified directory:

```sudo ./EmlRipper.rb -s /path/to/eml/files -d /path/to/save/attachments```

Extract attachments from a specific .eml file and save them to the current working directory:

```sudo ./EmlRipper.rb -f /path/to/eml/file.eml```

Extract attachments from all .eml files in the specified directory and its subdirectories and save them to the specified directory:

```sudo ./EmlRipper.rb -s /path/to/eml/files -r -d /path/to/save/attachments```

I have included some [eml files](https://github.com/mystickev/My-DFIR-toolset/tree/main/EmlRipper/test-eml) from a challenge in CyberDefenders to play around with.

*NOTE:* This script was created by [Mystik](https://twitter.com/Mystik_kev) for personal use and is not officially supported. Use at your own risk.
