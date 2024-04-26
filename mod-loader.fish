set mod_count 1
set loaded_mods ''
set loaded_mods_name ''
set mod_name_on_loading
set preload_list

function add_mod_path -a preload_path
	set preload_list $preload_path $preload_list
end

function define_mod -a mod_name
	set mod_name_on_loading $mod_name
end

function mod_is_installed -a mod_path
	if test -e "$mod_path"
		echo -n $mod_path
		return 0
	else 
		for path in (string split ' ' $preload_list)
			if test -e $path/$mod_path
				echo -n "$path/$mod_path"
				return 0
			end
		end
	end
	return 1
end

function warn
	set_color yellow
	echo -n "Warning "
	set_color normal
end

function load_mod -a mod_path
	if test "$mod_path" = ''
		return 1
	end
	if string match -e $mod_path $loaded_mods > /dev/null
		return
	end
	
	set mod_path_detect (mod_is_installed $mod_path)
	if test $status = 1
		warn; echo mod not found: $mod_path
		return
	end
	
	# Some modules may do mod_count++ by themselves, we need to prevent it.
	set count_before $mod_count
	source "$mod_path_detect"
	set loaded_mods $loaded_mods $mod_path
	if test $loaded_mods_name = ''
		set loaded_mods_name $mod_name_on_loading
	else
		set loaded_mods_name $loaded_mods_name, $mod_name_on_loading
	end	
	set mod_count (math $count_before+1)
	set mod_name_on_loading ''
end

function require_mod -a mod_path
	if test "$mod_path" = ''
		return 1
	end
	if ! mod_is_installed $mod_path > /dev/null
		warn
		echo "The mod <$mod_name_on_loading> requires a mod in <$mod_path>, which is not installed or cannot be loaded."
		return 1
	end
	load_mod $mod_path
	return 0
end