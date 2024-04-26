set mod_count 0
set mod_loader_version '1.1'
set loaded_mods
set loaded_mods_name
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
        end # for
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
    if string match -e $mod_path $loaded_mods >/dev/null
        return
    end
    mod_loader_source_mod $mod_path
    mod_loader_append_mod_path $mod_path
    mod_loader_append_mod_name $mod_name_on_loading
    set mod_name_on_loading ''
end

function require_mod -a mod_path
    if test "$mod_path" = ''
        return 1
    end
    if string match -e $mod_path $loaded_mods >/dev/null
        return
    end
    if ! mod_is_installed $mod_path >/dev/null
        warn
        echo "The mod <$mod_name_on_loading> requires mod <$mod_path>, which is not installed or cannot be loaded."
        return 1
    end
    set mod_name_before $mod_name_on_loading
    mod_loader_source_mod $mod_path
    mod_loader_append_mod_path $mod_path
    mod_loader_append_mod_name $mod_name_on_loading
    set mod_name_on_loading $mod_name_before
end

### Do not use this function outside mod-loader!
function mod_loader_source_mod -a mod_path
    set mod_path_detect (mod_is_installed $mod_path)
    if test $status = 1
        return
    end
    set count_before $mod_count
    source $mod_path_detect
    if ! string match -e $mod_path $loaded_mods >/dev/null
        set mod_count (math $count_before+1)
    else
        set mod_count $count_before
    end
end

### Do not use this function outside mod-loader!
function mod_loader_append_mod_name -a mod_name
    if test "$loaded_mods_name" = ''
        set loaded_mods_name $mod_name
    else
        set loaded_mods_name "$loaded_mods_name, $mod_name"
    end
end

### Do not use this function outside mod-loader!
function mod_loader_append_mod_path -a mod_path
    set loaded_mods $loaded_mods $mod_path
end
