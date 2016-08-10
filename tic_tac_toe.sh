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
    grid_data=( 'z' 'z' 'z' 'z' 'z' 'z' 'z' 'z' 'z' )    
    turn=0
    symbol_turn=0
    someone_won=0
    next_move_by=$whostarted
    
    while [ $someone_won -eq 0 ]
    do
        # Move
        get_move=1
        while [ $get_move -eq 1 ]
        do
            if [ $next_move_by = 'player' ]
            then player_move
            else NPC_move
            fi
            move=$?
            let i=$move-1
            if [ ${grid_data[$i]} = 'z' ]
            then
                get_move=0
                if [ $next_move_by = 'player' ]
                then next_move_by='NPC'
                else next_move_by='player'
                fi  
            fi
        done
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
        
        # Identify winning conditions
        if [ $turn -gt 4 ]
        then
            n_case=1
            i=( {0..8} 0 3 6 1 4 7 2 5 8 0 4 8 2 4 6 )
            j=( {0..2} )
            while [ $n_case -lt 9 ]
            do
                chain=$( echo "${grid_data[${i[${j[0]}]}]}${grid_data[${i[${j[1]}]}]}${grid_data[${i[${j[2]}]}]}" )
                if [ $chain = 'xxx' ] || [ $chain = 'ooo' ]
                then
                    someone_won=1
                    break
                else
                    for val in {0..2}
                    do let j[$val]=${j[$val]}+3
                    done
                    let n_case++
                fi
            done
            
            # Identify who won
            if [ $someone_won -eq 1 ]
            then
                let whosturn=$turn%2
                if [ $next_move_by = 'NPC' ]
                then echo "You won!"
                else echo "You lose"
                fi
            else
                if [ $turn -eq 9 ]
                then
                    someone_won=1
                    echo "Tie"
                fi
            fi  
        fi
        
        # Printing
        i=0
        while [ $i -lt 9 ]
        do
            print_grid[$i]=${grid_data[$i]}
            if [ ${print_grid[$i]} = 'z' ]
            then print_grid[$i]=' '
            fi
            let i++
        done
        
        echo " ${print_grid[0]} | ${print_grid[1]} | ${print_grid[2]} "
        echo '———+———+———'
        echo " ${print_grid[3]} | ${print_grid[4]} | ${print_grid[5]} "
        echo '———+———+———'
        echo " ${print_grid[6]} | ${print_grid[7]} | ${print_grid[8]} "
        
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
        whostarted='player'
    else
        whostarted='NPC'
    fi
    game_match
fi