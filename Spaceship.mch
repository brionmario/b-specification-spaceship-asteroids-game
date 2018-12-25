/* Spaceship
* Author: Brion Silva
* Creation date: 21/12/2018
*/
MACHINE
    Spaceship
    
SEES
    Space
    
SETS
    REPORT = { MOVEMENT_SUCCESSFUL, MOVEMENT_FAILED, MOVEMENT_FAILED_OUT_OF_BOUND,  MOVEMENT_FAILED_ASTEROID_COLLISION,  MOVEMENT_FAILED_INSUFFICIENT_POWER, WARP_DRIVE_SUCCESSFUL, WARP_DRIVE_FAILED_OUT_OF_BOUND,  WARP_DRIVE_FAILED_ASTEROID_COLLISION, WARP_DRIVE_FAILED_INSUFFICIENT_POWER, UNABLE_TO_DIRECTLY_WARP_TO_STARBASE, STARSHIP_DOCKED, GAME_WON, GAME_LOST, GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME  } ;
    MOVEMENTS = { Upward, Downward, Backward, Forward, WarpDrive };
    STATUS = { GameWon, GameLost, GameNotOver }
    
DEFINITIONS
    isSpaceshipInsideGrid( xx, yy ) == ( ( xx |-> yy ) : Grid ) ;
    isAsteroidCollision( xx, yy ) == ( ( xx |-> yy ) : Asteroids )
    
CONSTANTS
    NormalMovePowerConsumption,
    WarpDrivePowerConsumption,
    AsteroidCollisionPowerConsumption
    
PROPERTIES    
    NormalMovePowerConsumption : NAT1  &
    NormalMovePowerConsumption = 5 &
    WarpDrivePowerConsumption : NAT1  &
    WarpDrivePowerConsumption = 20 &
    AsteroidCollisionPowerConsumption : NAT1  &
    AsteroidCollisionPowerConsumption = 10
    
    
VARIABLES
    spaceshipX,
    spaceshipY,
    spaceshipPower,
    visitedRegions,
    noOfMovements,
    spaceshipCurrentPosition,
    spaceshipRoute,
    spaceshipMovements,
    gameStatus
    
INVARIANT
    spaceshipX : GridXRange &
    spaceshipY : GridYRange &
    spaceshipPower : NAT &
    visitedRegions <: Grid &
    noOfMovements : NAT &
    spaceshipCurrentPosition : Grid &
    spaceshipRoute : seq( Grid ) &
    spaceshipMovements : seq( MOVEMENTS ) &
    gameStatus <: STATUS
    
INITIALISATION
    spaceshipX := 1
    || spaceshipY := 1
    || spaceshipPower := 80
    || visitedRegions := {}
    || noOfMovements := 0
    || spaceshipCurrentPosition := ( 1 |-> 1 ) 
    || spaceshipRoute := [ ( 1 |-> 1 ) ] 
    || spaceshipMovements := []
    || gameStatus := { GameNotOver }
    
OPERATIONS
    
    report <-- MoveUp = 
    PRE
        report : REPORT
    THEN
        IF
            ( GameNotOver : gameStatus ) /* Checks if the game is over */
        THEN
            IF
                ( spaceshipPower >= NormalMovePowerConsumption ) /* Checks if the power is enough for a normal move */
            THEN
                IF
                    ( isSpaceshipInsideGrid( spaceshipX, succ( spaceshipY ) ) & not( isAsteroidCollision( spaceshipX, succ( spaceshipY ) ) ) ) /* Checks if the spaceship is inside the grid and has not hit an asteroid */ 
                THEN
                    IF
                        ( ( spaceshipX |-> succ( spaceshipY) ) : Starbase ) /* Checks if the current move results in the game winning */
                    THEN
                        spaceshipX, spaceshipY := spaceshipX, succ( spaceshipY )
                        || spaceshipCurrentPosition := ( spaceshipX |-> succ( spaceshipY ) ) 
                        || noOfMovements := noOfMovements + 1
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || visitedRegions := visitedRegions \/ { ( spaceshipX |-> succ( spaceshipY ) ) }
                        || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ( spaceshipY ) ]
                        || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        IF
                            ( (spaceshipPower - NormalMovePowerConsumption) >= NormalMovePowerConsumption ) /* Checks if power will be enough to continue with the game after the current move */
                        THEN
                            spaceshipX, spaceshipY := spaceshipX, succ( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> succ( spaceshipY ) ) 
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( spaceshipX |-> succ( spaceshipY ) ) }
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ( spaceshipY ) ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX, spaceshipY := spaceshipX, succ( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> succ( spaceshipY ) ) 
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( spaceshipX |-> succ( spaceshipY ) ) }
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ( spaceshipY ) ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                ELSIF
                    ( isAsteroidCollision( spaceshipX, succ( spaceshipY ) ) ) /* Checks if the spaceship has hit an asteroid */
                THEN
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )    /* Checks if the power will be enough to continue the game after the collision penalty */
                    THEN
                        gameStatus := { GameNotOver }
                         || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                         || report := MOVEMENT_FAILED_ASTEROID_COLLISION
                     ELSE
                         gameStatus := { GameLost }
                         || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                         || report := GAME_LOST
                     END
                ELSIF
                    ( not( isSpaceshipInsideGrid( spaceshipX, succ( spaceshipY ) ) ) ) /* Checks if the spaceship is not inside the grid */
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE /* Default movement error */
                    report := MOVEMENT_FAILED
                END
            ELSE /* If the power is not enough, sets the game status to lost and displays an insufficient power message */
                gameStatus := { GameLost }
                || report := MOVEMENT_FAILED_INSUFFICIENT_POWER
            END
        ELSIF /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END;
    
    
    report <-- MoveDown = 
    PRE
        report : REPORT    
    THEN
        IF
            ( GameNotOver : gameStatus ) /* Checks if the game is over */
        THEN
            IF
                ( spaceshipPower >= NormalMovePowerConsumption ) /* Checks if the power is enough for a normal move */
            THEN
                IF
                    ( isSpaceshipInsideGrid( spaceshipX, pred( spaceshipY ) ) & not( isAsteroidCollision( spaceshipX, pred( spaceshipY ) ) ) ) /* Checks if the spaceship is inside the grid and has not hit an asteroid */ 
                THEN
                    IF
                        ( ( spaceshipX |-> pred( spaceshipY) ) : Starbase ) /* Checks if the current move results in the game winning */
                    THEN
                        spaceshipX, spaceshipY := spaceshipX, pred( spaceshipY )
                        || spaceshipCurrentPosition := ( spaceshipX |-> pred( spaceshipY ) ) 
                        || noOfMovements := noOfMovements + 1
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || visitedRegions := visitedRegions \/ { ( spaceshipX |-> pred( spaceshipY ) ) }
                        || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> pred( spaceshipY ) ]
                        || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        IF
                            ( (spaceshipPower - NormalMovePowerConsumption) >= NormalMovePowerConsumption ) /* Checks if power will be enough to continue with the game after the current move */
                        THEN
                            spaceshipX, spaceshipY := spaceshipX, pred( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> pred( spaceshipY ) ) 
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( spaceshipX |-> pred( spaceshipY ) ) }
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> pred( spaceshipY ) ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX, spaceshipY := spaceshipX, pred( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> pred( spaceshipY ) ) 
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( spaceshipX |-> pred( spaceshipY ) ) }
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> pred( spaceshipY ) ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                ELSIF
                    ( isAsteroidCollision( spaceshipX, pred( spaceshipY ) ) ) /* Checks if the spaceship has hit an asteroid */
                THEN
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )    /* Checks if the power will be enough to continue the game after the collision penalty */
                    THEN
                        gameStatus := { GameNotOver }
                         || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                         || report := MOVEMENT_FAILED_ASTEROID_COLLISION
                     ELSE
                         gameStatus := { GameLost }
                         || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                         || report := GAME_LOST
                     END
                ELSIF
                    ( not( isSpaceshipInsideGrid( spaceshipX, pred( spaceshipY ) ) ) ) /* Checks if the spaceship is not inside the grid */
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE /* Default movement error */
                    report := MOVEMENT_FAILED
                END
            ELSE /* If the power is not enough, sets the game status to lost and displays an insufficient power message */
                gameStatus := { GameLost }
                || report := MOVEMENT_FAILED_INSUFFICIENT_POWER
            END
        ELSIF /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END;
    
    report <-- MoveBackward = 
    PRE
        report : REPORT  
    THEN
        IF
            ( GameNotOver : gameStatus ) /* Checks if the game is over */
        THEN
            IF
                ( spaceshipPower >= NormalMovePowerConsumption ) /* Checks if the power is enough for a normal move */
            THEN
                IF
                    ( isSpaceshipInsideGrid( pred( spaceshipX ), spaceshipY ) & not( isAsteroidCollision( pred( spaceshipX ), spaceshipY ) ) ) /* Checks if the spaceship is inside the grid and has not hit an asteroid */ 
                THEN
                    IF
                        ( ( pred( spaceshipX ) |-> spaceshipY ) : Starbase ) /* Checks if the current move results in the game winning */
                    THEN
                        spaceshipX, spaceshipY := pred( spaceshipX ), spaceshipY
                        || spaceshipCurrentPosition := ( pred( spaceshipX ) |-> spaceshipY ) 
                        || noOfMovements := noOfMovements + 1
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || visitedRegions := visitedRegions \/ { ( pred( spaceshipX ) |-> spaceshipY ) }
                        || spaceshipRoute := spaceshipRoute ^ [ pred( spaceshipX ) |-> spaceshipY ]
                        || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        IF
                            ( (spaceshipPower - NormalMovePowerConsumption) >= NormalMovePowerConsumption ) /* Checks if power will be enough to continue with the game after the current move */
                        THEN
                            spaceshipX, spaceshipY := pred( spaceshipX ), spaceshipY
                            || spaceshipCurrentPosition := ( pred( spaceshipX ) |-> spaceshipY ) 
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( pred( spaceshipX ) |-> spaceshipY ) }
                            || spaceshipRoute := spaceshipRoute ^ [ pred( spaceshipX ) |-> spaceshipY ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX, spaceshipY := pred( spaceshipX ), spaceshipY
                            || spaceshipCurrentPosition := ( pred( spaceshipX ) |-> spaceshipY ) 
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( pred( spaceshipX ) |-> spaceshipY ) }
                            || spaceshipRoute := spaceshipRoute ^ [ pred( spaceshipX ) |-> spaceshipY ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                ELSIF
                    ( isAsteroidCollision( pred( spaceshipX ), spaceshipY ) ) /* Checks if the spaceship has hit an asteroid */
                THEN
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )    /* Checks if the power will be enough to continue the game after the collision penalty */
                    THEN
                        gameStatus := { GameNotOver }
                         || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                         || report := MOVEMENT_FAILED_ASTEROID_COLLISION
                     ELSE
                         gameStatus := { GameLost }
                         || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                         || report := GAME_LOST
                     END
                ELSIF
                    ( not( isSpaceshipInsideGrid( pred( spaceshipX ), spaceshipY ) ) ) /* Checks if the spaceship is not inside the grid */
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE /* Default movement error */
                    report := MOVEMENT_FAILED
                END
            ELSE /* If the power is not enough, sets the game status to lost and displays an insufficient power message */
                gameStatus := { GameLost }
                || report := MOVEMENT_FAILED_INSUFFICIENT_POWER
            END
        ELSIF /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END;
    
    report <-- MoveForward = 
    PRE
        report : REPORT  
    THEN
        IF
            ( GameNotOver : gameStatus ) /* Checks if the game is over */
        THEN
            IF
                ( spaceshipPower >= NormalMovePowerConsumption ) /* Checks if the power is enough for a normal move */
            THEN
                IF
                    ( isSpaceshipInsideGrid( succ( spaceshipX ), spaceshipY ) & not( isAsteroidCollision( succ( spaceshipX ), spaceshipY ) ) ) /* Checks if the spaceship is inside the grid and has not hit an asteroid */ 
                THEN
                    IF
                        ( ( succ( spaceshipX ) |-> spaceshipY ) : Starbase ) /* Checks if the current move results in the game winning */
                    THEN
                        spaceshipX, spaceshipY := succ( spaceshipX ), spaceshipY
                        || spaceshipCurrentPosition := ( succ( spaceshipX ) |-> spaceshipY ) 
                        || noOfMovements := noOfMovements + 1
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || visitedRegions := visitedRegions \/ { ( succ( spaceshipX ) |-> spaceshipY ) }
                        || spaceshipRoute := spaceshipRoute ^ [ succ( spaceshipX ) |-> spaceshipY ]
                        || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        IF
                            ( (spaceshipPower - NormalMovePowerConsumption) >= NormalMovePowerConsumption ) /* Checks if power will be enough to continue with the game after the current move */
                        THEN
                            spaceshipX, spaceshipY := succ( spaceshipX ), spaceshipY
                            || spaceshipCurrentPosition := ( succ( spaceshipX ) |-> spaceshipY ) 
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( succ( spaceshipX ) |-> spaceshipY ) }
                            || spaceshipRoute := spaceshipRoute ^ [ succ( spaceshipX ) |-> spaceshipY ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX, spaceshipY := succ( spaceshipX ), spaceshipY
                            || spaceshipCurrentPosition := ( succ( spaceshipX ) |-> spaceshipY ) 
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( succ( spaceshipX ) |-> spaceshipY ) }
                            || spaceshipRoute := spaceshipRoute ^ [ succ( spaceshipX ) |-> spaceshipY ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                ELSIF
                    ( isAsteroidCollision( succ( spaceshipX ), spaceshipY ) ) /* Checks if the spaceship has hit an asteroid */
                THEN
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )    /* Checks if the power will be enough to continue the game after the collision penalty */
                    THEN
                        gameStatus := { GameNotOver }
                         || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                         || report := MOVEMENT_FAILED_ASTEROID_COLLISION
                     ELSE
                         gameStatus := { GameLost }
                         || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                         || report := GAME_LOST
                     END
                ELSIF
                    ( not( isSpaceshipInsideGrid( succ( spaceshipX ), spaceshipY ) ) ) /* Checks if the spaceship is not inside the grid */
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE /* Default movement error */
                    report := MOVEMENT_FAILED
                END
            ELSE /* If the power is not enough, sets the game status to lost and displays an insufficient power message */
                gameStatus := { GameLost }
                || report := MOVEMENT_FAILED_INSUFFICIENT_POWER
            END
        ELSIF /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END;
    
    report <-- EngageWarpDrive ( xx, yy ) = 
    PRE
        report : REPORT & xx : NAT1 & yy : NAT1
    THEN
        IF
            ( isSpaceshipInsideGrid( xx, yy) & ( xx |-> yy ) : Starbase ) 
        THEN 
            report := UNABLE_TO_DIRECTLY_WARP_TO_STARBASE
        ELSIF
            ( isSpaceshipInsideGrid( xx, yy ) & not( isAsteroidCollision( xx, yy ) ) )
        THEN
            spaceshipX, spaceshipY := xx, yy
            || spaceshipCurrentPosition := ( xx |-> yy )
            || noOfMovements := noOfMovements + 1
            || spaceshipPower := spaceshipPower - 20
            || visitedRegions := visitedRegions \/ { (  xx |-> yy ) }
            || spaceshipRoute := spaceshipRoute ^ [ xx |-> yy ]
            || spaceshipMovements := spaceshipMovements ^ [ WarpDrive ]
            || report := WARP_DRIVE_SUCCESSFUL
        ELSIF
            ( isAsteroidCollision( xx, yy ) )
        THEN
            report := WARP_DRIVE_FAILED_ASTEROID_COLLISION
        ELSIF
            ( not( isSpaceshipInsideGrid( xx, yy ) ) )
        THEN
            report := WARP_DRIVE_FAILED_OUT_OF_BOUND
        END
    END
    
END
