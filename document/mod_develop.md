# FML Mod Developing

## Provided functions

### mod.name $name

It tells the loader the mod's name for human read, e.g. `Less Greeting`.

### mod.version $mod_version

It tells the loader the mod's version.  
The default version string is `unknown`.

### mod.require $name $type?

The loader will try to load the mod as `load_mod` do.

When the mod is not found, it will give a warning to user and return `1`.

When the $type is 'optional', it will only return `1` and give no warning.

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

`fml-greeting@soloev.fish`
```fish
mod.name 'FML Greeting'
mod.version '2.0'

function fish_greeting
	set_color green
	echo "Fish Shell $version"
	echo "Fish Mod Loader $mod_loader_version"
	set_color brgreen
	if test "$mod_loader_count" = 1
		echo "1 mod loaded."
	else if test "$mod_loader_count" = 0
		set_color white
		echo "No mod loaded."
	else
		echo "$mod_loader_count mods loaded."
	end
	set_color normal
end
``` 
> This mod is in the examples directory. add the example directory to finder and load `fml-greeting@soloev.fish`

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

set ___mra_e_flag_opt_require 1

if ! mod.require 'required-mod@example.fish'
    # The mod loader will automatically warn the user when a required mod is not loaded.
    return
end

if ! mod.require 'optional-mod@example.fish' optional
    # Some fallback operations, like set flag.
    set ___mra_e_flag_opt_require 0
end

# use functions provided by required mod
required_function

function some_function
    if test "$___mra_e_flag_opt_require" = 1
        optional_function
    end
    ...
end

```

If you load `mod-requires-another@example.fish`, you will see `Using required function.` before the greeting.