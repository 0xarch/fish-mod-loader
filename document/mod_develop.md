# FML Mod Developing

## Provided functions

### define_mod $name

It tells the loader the mod's name for human read, e.g. `Less Greeting`.

### set_mod_version $name

It tells the loader the mod's version. The default version string is `unknown`

### require_mod $name

The loader will try to load the mod as `load_mod` do.

When the mod is not found, it will return `1`.

## Rules

Although it's optional, every mod should have `define_mod` and `set_mod_version`.

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
define_mod 'Less Greeting'
set_mod_version '1.0'

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
define_mod 'Required mod'
set_mod_version '1.0'

function required_function
    echo 'Using required function.'
end
```

`mod-requires-another@example.fish`  
```fish
define_mod 'Mod that requires another mod'
set_mod_version '1.0'

if ! require_mod 'required-mod@example.fish'
    # The mod loader will automatically warn the user when a required mod is not loaded.
    return
end

# use functions provided by required mod
required_function
```

If you load `mod-requires-another@example.fish`, you will see `Using required function.` before the greeting.