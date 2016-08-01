#!/bin/bash
# Tic-tac-toe game

function print_example_grid {
    echo ' 1 | 2 | 3 '
    echo '———+———+———'
    echo ' 4 | 5 | 6 '
    echo '———+———+———'
    echo ' 7 | 8 | 9'
}

function splash {
    echo '=== Tic-tac-toe game ==='
    echo '————————————————————————'
    echo
}

function menu {
    play_char='p'
    quit_char='q'
    
    echo 'Type p to play'
    echo 'Type q to exit'
    
    read u_in_menu
    
    case $u_in_menu in
        $play_char)
            echo 'Start game'
            ;;
        $quit_char)
            echo 'Bye bye'
            ;;
        *)
            echo 'Not a valid option'
            menu
            ;;
    esac
    
}

splash
menu