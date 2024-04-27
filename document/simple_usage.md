# FML Usage

## Dependencies

* Fish shell (runtime)
* GNU coreutils _[optional]_ (for `mod_is_loaded` to auto detect path)

## Enable FML

First clone this repository.

Then, source `mod-loader.fish` in your fish configuration file.(default `$XDG_CONFIG_HOME/fish/config.fish`)

You can now use the functions provided by the mod loader.

## Base functions that you need to use

### add_mod_path $path

This function defines path for the mod loader to find some mods when you don't want to write the absolute path for some modules in the same directory.

> This function is actually an abbreviation for `set mod_loader_finders $path $mod_loader_finders`

### load_mod $file_name_or_path

This function will load the file from given absolute path. If you pass a file name instead of path, it will search in the path you added by `add_mod_path $path`. And if all paths are searched and no file found, loader will give a warning and start to find next mod.

### ...

For more functions, see [FML Addition List](addition_list.md)