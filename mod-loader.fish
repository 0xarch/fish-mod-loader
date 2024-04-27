set mod_loader_count 0
set mod_loader_version '2.0'
set mod_loader_finders

# Map for managing mod
# **NOTE** the index starts at 1 in fish
set __fml_val_source # Source name
set __fml_val_name # Name
set __fml_val_version # Version
set __fml_val_path # Absolute path

set __fml_m_name
set __fml_m_version unknown

function __fml_get_list_by \
    -a pass_type \
    -d "BUILT-IN FUNCTION. DO NOT USE."
    set list
    switch $pass_type
        case source
            set list $__fml_val_source
        case name
            set list $__fml_val_name
        case version
            set list $__fml_val_version
        case path
            set list $__fml_val_path
    end
    printf '%s\n' $list
end

# Query index from string.
# If No results were found, it will echo 0
# **NOTE** The version cannot be used to query
function __fml_get_index_by \
    -a pass_type \
    -a pass_val \
    -d "BUILT-IN FUNCTION. DO NOT USE."
    set i 0
    set list (__fml_get_list_by $pass_type)
    for v in $list
        set i (math $i+1)
        if test "$v" = "$pass_val"
            echo $i
            return
        end
    end # for
    echo 0
end

# Get information.
function __fml_get_val_by \
    -a pass_type \
    -a pass_val \
    -a val_type \
    -d "BUILT-IN FUNCTION."
    set i (__fml_get_index_by $pass_type $pass_val)
    if test $i = 0
        return
    end
    set list (__fml_get_list_by $val_type)
    echo $list[$i]
end

function __fml_push_to_map \
    -a mod_source_name \
    -a mod_name \
    -a mod_version \
    -a mod_ab_path \
    -d "BUILT-IN FUNCTION. DO NOT USE."

    set __fml_val_source $__fml_val_source $mod_source_name
    set __fml_val_name $__fml_val_name $mod_name
    set __fml_val_version $__fml_val_version $mod_version
    set __fml_val_path $__fml_val_path $mod_ab_path
end

# This function replaces mod_is_installed. It is now a built-in function.
# Get absolute path from mod source name.
function __fml_path_find \
    -a mod_source_name \
    -d "BUILT-IN FUNCTION. DO NOT USE."
    if test -e "$mod_source_name"
        echo -n $mod_source_name
        return 0
    else
        for path in (string split ' ' $mod_loader_finders)
            if test -e $path/$mod_source_name
                echo -n "$path/$mod_source_name"
                return 0
            end
        end # for
    end
    echo -n "$mod_source_name"
    return 1
end

function mod_loader_warn
    set_color yellow
    echo -n "Warning "
    set_color normal
end

## User functions

function add_mod_path -a preload_path
    set mod_loader_finders $preload_path $mod_loader_finders
end


function load_mod -a mod_source_name
    set __fml_m_name ''
    set __fml_m_version unknown
    set mod_argv $argv[2..]
    if contains $mod_source_name $__fml_val_source
        return
    end
    if test "$mod_source_name" = ''
        return 1
    end
    set mod_ab_path (__fml_path_find $mod_source_name)
    if test $status = 1
        mod_loader_warn
        echo 'mod not found: '$mod_source_name
        return 1
    end
    source $mod_ab_path
    set mod_loader_count (math $mod_loader_count+1)
    __fml_push_to_map $mod_source_name $__fml_m_name $__fml_m_version $mod_ab_path
end

function mod_is_loaded -a mod_ab_path
    if type --query realpath
        set mod_ab_path (realpath $mod_ab_path)
    end
    if contains $mod_ab_path $__fml_val_path
        return 0
    else
        return 1
    end
end

### Mod functions

function mod.name -a mod_name
    set __fml_m_name $mod_name
end

function mod.version -a mod_version
    set __fml_m_version $mod_version
end

function mod.require -a mod_source_name
    set __fml_m_name ''
    set __fml_m_version unknown
    set mod_argv $argv[2..]
    if contains $mod_source_name $__fml_val_source
        return
    end
    if test "$mod_source_name" = ''
        return 1
    end
    set mod_ab_path (__fml_path_find $mod_source_name)
    if test $status = 1
        mod_loader_warn
        echo "The mod <$__fml_m_name> requires mod <$mod_source_name> that cannot be loaded."
        return 1
    end
    set mod_name_before $__fml_m_name
    set mod_version_before $__fml_m_version
    source $mod_ab_path
    if test (__fml_get_index_by source $mod_ab_path) = 0
        set mod_loader_count (math $mod_loader_count+1)
    end
    __fml_push_to_map $mod_source_name $mod_name_before $mod_version_before $mod_ab_path
end

### Aliases

alias fml_loaded_mods='echo $__fml_val_source'
