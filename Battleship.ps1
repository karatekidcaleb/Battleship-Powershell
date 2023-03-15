
"
                                                                                                                                            
BBBBBBBBBBBBBBBBB                       ffffffffffffffff                     SSSSSSSSSSSSSSS hhhhhhh               iiii                     
B::::::::::::::::B                     f::::::::::::::::f                  SS:::::::::::::::Sh:::::h              i::::i                    
B::::::BBBBBB:::::B                   f::::::::::::::::::f                S:::::SSSSSS::::::Sh:::::h               iiii                     
BB:::::B     B:::::B                  f::::::fffffff:::::f                S:::::S     SSSSSSSh:::::h                                        
  B::::B     B:::::B   ooooooooooo    f:::::f       ffffffaaaaaaaaaaaaa   S:::::S             h::::h hhhhh       iiiiiiippppp   ppppppppp   
  B::::B     B:::::B oo:::::::::::oo  f:::::f             a::::::::::::a  S:::::S             h::::hh:::::hhh    i:::::ip::::ppp:::::::::p  
  B::::BBBBBB:::::B o:::::::::::::::of:::::::ffffff       aaaaaaaaa:::::a  S::::SSSS          h::::::::::::::hh   i::::ip:::::::::::::::::p 
  B:::::::::::::BB  o:::::ooooo:::::of::::::::::::f                a::::a   SS::::::SSSSS     h:::::::hhh::::::h  i::::ipp::::::ppppp::::::p
  B::::BBBBBB:::::B o::::o     o::::of::::::::::::f         aaaaaaa:::::a     SSS::::::::SS   h::::::h   h::::::h i::::i p:::::p     p:::::p
  B::::B     B:::::Bo::::o     o::::of:::::::ffffff       aa::::::::::::a        SSSSSS::::S  h:::::h     h:::::h i::::i p:::::p     p:::::p
  B::::B     B:::::Bo::::o     o::::o f:::::f            a::::aaaa::::::a             S:::::S h:::::h     h:::::h i::::i p:::::p     p:::::p
  B::::B     B:::::Bo::::o     o::::o f:::::f           a::::a    a:::::a             S:::::S h:::::h     h:::::h i::::i p:::::p    p::::::p
BB:::::BBBBBB::::::Bo:::::ooooo:::::of:::::::f          a::::a    a:::::a SSSSSSS     S:::::S h:::::h     h:::::hi::::::ip:::::ppppp:::::::p
B:::::::::::::::::B o:::::::::::::::of:::::::f          a:::::aaaa::::::a S::::::SSSSSS:::::S h:::::h     h:::::hi::::::ip::::::::::::::::p 
B::::::::::::::::B   oo:::::::::::oo f:::::::f           a::::::::::aa:::aS:::::::::::::::SS  h:::::h     h:::::hi::::::ip::::::::::::::pp  
BBBBBBBBBBBBBBBBB      ooooooooooo   fffffffff            aaaaaaaaaa  aaaa SSSSSSSSSSSSSSS    hhhhhhh     hhhhhhhiiiiiiiip::::::pppppppp    
                                                                                                                         p:::::p            
                                                                                                                         p:::::p            
                                                                                                                        p:::::::p           
                                                                                                                        p:::::::p           
                                                                                                                        p:::::::p           
                                                                                                                        ppppppppp           





"



$exit= $False #main game loop
$ships = New-Object 'boolean[,,]' 2,10,10 #player, row, column
$hits = New-Object 'boolean[,,]' 2,10,10 #player, row, column (tracks previous guesses)
$playerID = 0

function multiplayer
{
    placeShips
    guess
    Write-Host "The winner is Player " ($playerID+1) "!!!"
}

function displayBoard($player)
{
    Write-Host " " (1..10)
    for($i=0; $i -lt 10; $i++)
    {
        $row = [String]($i+1)
        if($i -eq 9)
        {
            $row = "T"
        }
        for($j=0; $j -lt 10; $j++)
        {
            if($ships[($player-1), $i, $j])
            {
                $row += " O"
            }
            else
            {
                $row += " -"
            }
            
        }
        Write-Host $row
    }

}

function displayGuesses
{
    Write-Host " " (1..10)
    for($i=0; $i -lt 10; $i++)
    {
        $row = [String]($i+1)
        if($i -eq 9)
        {
            $row = "T"
        }
        for($j=0; $j -lt 10; $j++)
        {
            if($hits[($playerID-1), $i, $j] -and $ships[(2 - $playerID), $i, $j])
            {
                $row += " @"
            }
            elseif($hits[($playerID-1), $i, $j])
            {
                $row += " w"
            }
            else
            {
                $row += " ."
            }
            
        }
        Write-Host $row
    }

}

function guess
{
    $score = (0, 0) #player 1 score, player 2 score
    [Int]$playerID = 1
    while ($True)
    {
        [Int]$colGuess = Read-host "Player $playerID choose a row to guess!"
        $colGuess--
        #display previous guesses
        [Int]$rowGuess = Read-host "Player $playerID choose a column to guess!"
        $rowGuess--
        if($ships[(2 - $playerID), $rowGuess, $colGuess] -and !$hits[($playerId-1), $rowGuess, $colGuess])
        {
            $score[($playerID-1)]++
            Write-Host "HIT!!!!" 
            $hits[($playerID-1), $rowGuess, $colGuess] = $True
        }
        else
        {
            Write-Host "TERRIBLE GUESS, AMMO WASTED, LIVES LOST!!! :("
            $hits[($playerID-1), $rowGuess, $colGuess] = $True
        }
        displayGuesses
        if($score[$playerID] -eq 14)
        {
            return
        }
        $playerID = 3 - $playerID
    }

    #switch player up ayo yuhyuh{
    #ask player 1
    #check player 1 guess against player 2 grid
    #IF TIME PERMITS store/log player 1 guesses
    #ccheck if score = 14
    #}

    #set playerID to winner
}

function readPlacement($length)
{
    $inputInvalid = $True
    while($inputInvalid)
    {

        [int]$c = Read-Host "Please input the column of the leftmost point on the ship (i.e. number)"
        [int]$r = Read-Host "Please input the row of the topmost point on the ship (i.e. number)"
        [String]$o = Read-Host "Please enter the desired orientation for the ship (i.e. v or h)"
        $c--
        $r--
        $inputInvalid = $False
        for($i = 0; $i -lt $length; $i++)
        {
            if($o -eq "v")
            {
                if($ships[$playerID,($r+$i),$c])
                {
                    Write-Host "Your placement runs into another ship at " ($r+$i) ", " $c "!"
                    $inputInvalid = $True
                }
            }
            else
            {
                if($ships[$playerID,$r,($c+$i)])
                {
                    Write-Host "Your placement runs into another ship at " ($r+$i) ", " $c "!"
                    $inputInvalid=$True
                }
            }
        }

        if($o -ne "v" -and $o -ne "h")
        {
            $inputInvalid = $True
            cls
            Write-Host "You must choose a valid orientation"
        }
        elseif($c -lt 0 -or $r -lt 0)
        {
            $inputInvalid = $True
            cls
            Write-Host "Your placement is outside the bounds of the space! It is 10 x 10, please enter a valid location"
        }
        elseif($o -eq "v" -and $r+$length -gt 10)
        {
            $inputInvalid=$True
            cls
            Write-Host "Your placement is outside the bounds of the space! It is 10 x 10, please enter a valid location. Remember, the ships have length!"
        }
        elseif($o -eq "h" -and [Int]$c+$length -gt 10)
        {
            $inputInvalid=$True
            cls
            Write-Host "Your placement is outside the bounds of the space! It is 10 x 10, please enter a valid location"   
        }
        #TODO translate every letter into the associated number
    }
    cls
    Write-Host "Onto the next ship!"

return [String]$c + [String]$r + $o
}

function placeShips
{
    $output = "t"
    for($i=1; $i -lt 3; $i++) #each of the player
    {
        $playerID = $i
        Write-Host "Player $i , place your ships!"
        ""
        for($j=5; $j -gt 1; $j--){ #each of the ships (4 total, length 5 to 2)
            Write-Host "Please place your ship, it is $j bligots long"
            $output = readPlacement($j)
            [Int]$c = $output.Substring(0,1)
            [Int]$r = $output.Substring(1,1)
            $o = $output.Substring(2,1)
            for($k=0; $k -lt $j; $k++)
            {
                if($o -eq "v")
                {
                    $ships[($i-1), ($r+$k), $c] = $True
                }
                else
                {
                    $ships[($i-1), $r, ($c+$k)] = $True
                }
            }
            displayBoard($i)
        }
        cls
    }
}




while(!$exit){
#bool menu()
<#
function to ask player if multiplayer or single
#>
#singleplayer()
#multiplayer()

    #placeShips()

    #guess()

        #checkForWin()

multiplayer
$exit=$True
}

