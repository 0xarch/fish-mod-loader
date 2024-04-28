# FML Addition List

## Functions

### add_mod_path $path

This function defines path for the mod loader to find some mods when you don't want to write the absolute path for some modules in the same directory.

### load_mod $file_name_or_path

This function will load the file from given absolute path. If you pass a file name instead of path, it will search in the path you added by `add_mod_path $path`. And if all paths are searched and no file found, loader will give a warning and start to find next mod.

### mod_is_loaded $file_name_or_path

> This function optionally requires GNU coreutils.
> When coreutils is not installed, you must pass absolute path as $file_name_or_path.

This function will check whether the given mod is installed. If the loader find the mod, it will display the path, else it will return `1`.

### define_mod $name

See [FML Mod Developing](document/mod_develop.md)

### set_mod_version $mod_version

See [FML Mod Developing](document/mod_develop.md)

### require_mod $name

See [FML Mod Developing](document/mod_develop.md)

## Aliases

## fml_loaded_mods

`echo $__fml_val_source`

## Envs

### $mod_loader_count

The count of loaded mods.
> In version 1.0, the mod loader is treated as a mod too, while in version 1.1 it is not a mod.

### $mod_loader_finders

A list of path added by `add_mod_path`. You can override this like `set mod_loader_finders $HOME/.shell $HOME/.config/mods` when you have many paths to add.
> Remember to do this before loading mods.

### $mod_loader_version

The version of Fish Mod Loader.