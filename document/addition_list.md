# FML Addition List

## Functions

### add_mod_path $path

This function defines path for the mod loader to find some mods when you don't want to write the absolute path for some modules in the same directory.

### load_mod $file_name_or_path

This function will load the file from given absolute path. If you pass a file name instead of path, it will search in the path you added by `add_mod_path $path`. And if all paths are searched and no file found, loader will give a warning and start to find next mod.

### mod_is_installed $file_name_or_path

This function will check whether the given mod is installed. If the loader find the mod, it will display the path, else it will return `1`.

### define_mod $name

See [FML Mod Developing](document/mod_develop.md)

### set_mod_version $name

See [FML Mod Developing](document/mod_develop.md)

### require_mod $name

See [FML Mod Developing](document/mod_develop.md)

## Abbreviations

## loaded_mods

`echo $mod_loader_loaded_name`

## Inside functions

The functions below are not recommended to use in normal shell environment.

### mod_loader_source_mod

Sources file and does some external operations like add count.

### mod_loader_append_mod_name

Appends name and version into $mod_loader_loaded_name

### mod_loader_append_mod_path

Appends a path into $mod_loader_loaded

### mod_loader_warn

Simply display a yellow "Warning" in the console.

## Envs

### $mod_loader_count

The count of loaded mods.
> In version 1.0, the mod loader is treated as a mod too, while in version 1.1 it is not a mod.

### $mod_loader_loaded

A list of loaded mods' path.

### $mod_loader_loaded_name

A list of loaded mods' name and version.
> Split by `,`

### $mod_loader_finders

A list of path added by `add_mod_path`. You can override this like `set mod_loader_finders $HOME/.shell $HOME/.config/mods` when you have many paths to add.
> Remember to do this before loading mods.

### $mod_loader_version

The version of Fish Mod Loader.