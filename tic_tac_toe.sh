#!/bin/bash
# Tic-tac-toe game

start_game=0
whostarted='NPC'
cross='x'
nough='o'

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
            start_game=1
            ;;
        $quit_char)
            echo 'Bye bye'
            ;;
        *)
            echo 'Not a valid option'
            ###–clear
            menu
            ;;
    esac
    
}

function print_example_grid {
    echo ' 1 | 2 | 3 '
    echo '———+———+———'
    echo ' 4 | 5 | 6 '
    echo '———+———+———'
    echo ' 7 | 8 | 9 '
}

function rules_expl {
    echo 'Make three in a row in any direction'
    echo 'To select a space in the grid just type in the number'
    echo
    print_example_grid
}

function game_match {
    grid_data=( ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' )    
    turn=0
    symbol_turn=0
    next_move_by=$whostarted
    
    while [ 1 ]
    do
        # Move
        if [ $next_move_by = 'player' ]
        then
            next_move_by='NPC'
            player_move
        else
            next_move_by='player'
            NPC_move
        fi
        move=$?
        let turn++
        
        # Idetify if cross or nough and saves to grid
        let symbol_turn=$turn%2
        let i=$move-1
        if [ $symbol_turn -eq 1 ]
        then
            grid_data[$i]=$cross
        else
            grid_data[$i]=$nough
        fi
        
        echo " ${grid_data[0]} | ${grid_data[1]} | ${grid_data[2]} "
        echo '———+———+———'
        echo " ${grid_data[3]} | ${grid_data[4]} | ${grid_data[5]} "
        echo '———+———+———'
        echo " ${grid_data[6]} | ${grid_data[7]} | ${grid_data[8]} "
    done
}

function whostarts {
    let a=$RANDOM%2
    if [ $a -eq 1 ]
    then
        # Player
        return 90
    else
        # NPC
        return 91
    fi
}

function player_move {
    player_turn=1
    echo 'Your turn'
    
    while [ $player_turn -eq 1 ]
    do
        read user_turn
        if [ $user_turn -gt 0 ] && [ $user_turn -lt 10 ]
        then
            player_turn=0
            return $user_turn
        else
            echo 'Invalid option'
        fi
    done

}

function NPC_move {
    t=32767; n=0
    let x=$RANDOM*9
    n=$( ./ceiling.sh $x $t )
    return $n
}

# ===== Main =====

splash
menu
if [ $start_game -eq 1 ]
then
    start_game=0
    ###–clear
    rules_expl
    echo 'Ok?'; read ok
    ###–clear
    whostarts
    if [ $? -eq 90 ]
    then
        whostarted="player"
    else
        whostarted="NPC"
    fi
    game_match
fi