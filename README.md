# Fish Mod Loader

This is a simple mod loader for my own shell. I use this to manage my fish scripts.

## Usage

You need to first clone this repository.

Then, source the `mod_loader.fish` in your fish configuration file.

You can now use the functions provided by the mod loader.

## Functions

### add_mod_path $path

This function defines path for the mod loader to find some mods when you don't want to write the absolute path for some modules in the same directory.

### load_mod $file_name_or_path

This function will load the file from given absolute path. If you pass a file name instead of path, it will search in the path you added by `add_mod_path $path`. And if all paths are searched and no file found, loader will give a warning and start to find next mod.

### mod_is_installed $file_name_or_path

This function will check whether the given mod is installed. If the loader find the mod, it will display the path, else it will return `1`.

### define_mod $name

This function is used in mod file. It tells the loader the mod's name for human read, e.g. `Advanced Prompt`.

### require_mod $name

This function is used in mod file. The loader will try to load the mod as `load_mod` do.

When the mod is not found, it will return `1`.

## Envs

### $mod_count

The count of loaded mods.

### $loaded_mods

A list of loaded mods' path.

Note

### $loaded_mods_name

A list of loaded mods' name.

### $preload_list

A list of path added by `add_mod_path`. You can override this like `set preload_path $HOME/.shell $HOME/.config/mods` when you have many paths to add.