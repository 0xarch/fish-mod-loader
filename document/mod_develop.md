# FML Mod Developing

## Provided functions

### mod.name $name

It tells the loader the mod's name for human read, e.g. `Less Greeting`.

### mod.version $mod_version

It tells the loader the mod's version.  
The default version string is `unknown`.

### mod.require $name

The loader will try to load the mod as `load_mod` do.

When the mod is not found, it will return `1`.

## Rules

Although it's optional, every mod should have `mod.name` and `mod.version`.

Mods should not override mod loader's functions. **THIS MIGHT CAUSE SECURITY PROBLEM.**
> However, we have no such hard-limit.

Mod's file name should follow this format: `$mod_name@$mod_author.fish`

## Examples

Here are some examples for developing a mod.

### Example: Override fish_greeting

A simple mod that changes the default greeting text.

Thanks to Soloev.

`less-greeting@soloev.fish`
```fish
# Mod: Less Greeting
# Author: Soloev
mod.name 'Less Greeting'
mod.version '1.0'

function fish_greeting
    set_color green # Fish's Color setter function
    echo "Fish Shell $FISH_VERSION"
    echo "Fish Mod Loader $mod_loader_version"
    set_color brgreen # brgreen -> Bright green
    if test "$mod_loader_count" = '1'
        echo "1 mod loaded."
    else if test "$mod_loader_count" = '0'
        echo "No mod loaded."
    else
        echo "$mod_loader_count mods loaded."
    end
    set_color normal
end
``` 
> Copy this into your local file and load it

### Example: Mod requiring

This example shows how to require a mod.

`required-mod@example.fish`  
```fish
mod.name 'Required mod'
mod.version '1.0'

function required_function
    echo 'Using required function.'
end
```

`mod-requires-another@example.fish`  
```fish
mod.name 'Mod that requires another mod'
mod.version '1.0'

if ! mod.require 'required-mod@example.fish'
    # The mod loader will automatically warn the user when a required mod is not loaded.
    return
end

# use functions provided by required mod
required_function
```

If you load `mod-requires-another@example.fish`, you will see `Using required function.` before the greeting.