function __fzf_docker_armyknife_things_you_want_to_do -d '<keys>'
    for key in $argv
        echo $key
    end
end

function fzf_docker_armyknife -d 'fzf source of the swiss army knife for docker operation'
    set -l k
    set -l v

    # =========================================================================
    set k $k 'I want to remove all images without tag'
    set v $v "docker rmi (docker images | grep '<none>' | awk '{print$3}')"
    # =========================================================================
    set k $k 'I want to remove all stopped containers'
    set v $v 'docker rm (docker ps -a -q)'
    # =========================================================================

    __fzf_docker_armyknife_things_you_want_to_do $k | fzf | read thing_you_want_to_do

    if test -n "$thing_you_want_to_do"
        if set -l index (contains -i -- "$thing_you_want_to_do" $k)
            commandline $v[$index]
        end
    end
end
