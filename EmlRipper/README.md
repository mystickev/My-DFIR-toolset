# EmlRipper

EmlRipper is a ruby script that allows you to extract attachments from .eml files. It utilizes the https://github.com/mystickev/My-DFIR-toolset/tree/main/EmlRipperMail gem, a library that provides a simple and elegant way to read, write, and send emails.

To use the script, you must have Ruby installed on your computer and the Mail gem. Once these requirements are met, you can run the script by navigating to the directory where the script is located in your command line and running the command:

`ruby EmlRipper.rb [OPTIONS]`

The script accepts the following options:

-s, --source PATH: The directory containing the .eml files to extract attachments. Default is the current working directory.
-r, --recursive: Allows recursive search for .eml files under the SOURCE directory.
-f, --files FILE: Specifies a .eml file or a list of .eml files to extract attachments.
-d, --destination PATH: The directory to extract attachments to. Default is the current working directory.

## Examples:

Extract attachments from all .eml files in the current working directory and save them to the current working directory:

```ruby EmlRipper.rb```

Extract attachments from all .eml files in the specified directory and save them to the specified directory:

```ruby EmlRipper.rb -s /path/to/eml/files -d /path/to/save/attachments```

Extract attachments from a specific .eml file and save them to the current working directory:

```ruby EmlRipper.rb -f /path/to/eml/file.eml```

Extract attachments from all .eml files in the specified directory and its subdirectories and save them to the specified directory:

```ruby EmlRipper.rb -s /path/to/eml/files -r -d /path/to/save/attachments```

*NOTE:* This script was created by [Mystik](https://twitter.com/Mystik_kev) for personal use and is not officially supported. Use at your own risk.
