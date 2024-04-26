set mod_loader_count 0
set mod_loader_version '1.2'
set mod_loader_loaded
set mod_loader_loaded_name
set mod_loader_name_onload
set mod_loader_version_onload 'unknown'
set mod_loader_finders

function mod_loader_warn
    set_color yellow
    echo -n "Warning "
    set_color normal
end

function add_mod_path -a preload_path
    set mod_loader_finders $preload_path $mod_loader_finders
end

function define_mod -a mod_name
    set mod_loader_name_onload $mod_name
end

function set_mod_version -a mod_version
    set mod_loader_version_onload $mod_version
end

function mod_is_installed -a mod_path
    if test -e "$mod_path"
        echo -n $mod_path
        return 0
    else
        for path in (string split ' ' $mod_loader_finders)
            if test -e $path/$mod_path
                echo -n "$path/$mod_path"
                return 0
            end
        end # for
    end
    return 1
end

function load_mod -a mod_path
    if test "$mod_path" = ''
        return 1
    end
    if string match -e $mod_path $mod_loader_loaded >/dev/null
        return
    end
    mod_loader_source_mod $mod_path
    mod_loader_append_mod_path $mod_path
    mod_loader_append_mod_name $mod_loader_name_onload $mod_loader_version_onload
    set mod_loader_name_onload ''
    set mod_loader_version_onload 'unknown'
end

function require_mod -a mod_path
    if test "$mod_path" = ''
        return 1
    end
    if string match -e $mod_path $mod_loader_loaded >/dev/null
        return
    end
    if ! mod_is_installed $mod_path >/dev/null
        mod_loader_warn; echo "The mod <$mod_loader_name_onload> requires mod <$mod_path>, which is not installed or cannot be loaded."
        return 1
    end
    set mod_name_before $mod_loader_name_onload
    set mod_version_before $mod_loader_version_onload
    mod_loader_source_mod $mod_path
    mod_loader_append_mod_path $mod_path
    mod_loader_append_mod_name $mod_loader_name_onload $mod_loader_version_onload
    set mod_loader_name_onload $mod_name_before
    set mod_loader_version_onload $mod_version_before
end

### Do not use this function outside mod-loader!
function mod_loader_source_mod -a mod_path
    set mod_path_detect (mod_is_installed $mod_path)
    if test $status = 1
        return
    end
    set count_before $mod_loader_count
    source $mod_path_detect
    if ! string match -e $mod_path $mod_loader_loaded >/dev/null
        set mod_loader_count (math $count_before+1)
    else
        set mod_loader_count $count_before
    end
end

### Do not use this function outside mod-loader!
function mod_loader_append_mod_name -a mod_name -a mod_version
    if test "$mod_loader_loaded_name" = ''
        set mod_loader_loaded_name "$mod_name [$mod_version]"
    else
        set mod_loader_loaded_name "$mod_loader_loaded_name, $mod_name [$mod_version]"
    end
end

### Do not use this function outside mod-loader!
function mod_loader_append_mod_path -a mod_path
    set mod_loader_loaded $mod_loader_loaded $mod_path
end

### Abbreviations

abbr loaded_mods 'echo $mod_loader_loaded_name'