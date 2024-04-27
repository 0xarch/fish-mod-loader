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