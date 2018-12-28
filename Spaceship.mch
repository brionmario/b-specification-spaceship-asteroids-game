/* ******************************************************************************
** 6SENG001W Reasoning About Programs Coursework (2018/19)
** Component : Spaceship
** Author : Brion Silva
** Created : 21/12/2018
** Modified : 27/12/2018
******************************************************************************* */

/* Operations:

    MoveUp: 
    This operation moves the spaceship one step up the grid (y+1).
    The movement consumes 5 units of the spaceship's power.

    MoveDown: 
    This operation moves the spaceship one step down the grid (y-1).
    The movement consumes 5 units of the spaceship's power.

    MoveForward: 
    This operation moves the spaceship one step forward on the grid (x+1).
    The movement consumes 5 units of the spaceship's power.

    MoveBackward: 
    This operation moves the spaceship one step backward on the grid (x-1).
    The movement consumes 5 units of the spaceship's power.

    EngageWarpDrive( xx, yy ):
    This operation moves the spaceship to any region of space (i.e. grid co-ordinates).
    Engaging the warp-drive uses up 20 units of the spaceship's power. It is not
    permitted to jump straight from homebase to starbase.
    
    MissionStatus: 
    This enquiry operation reports the current status of the spaceship:
        1. Its current location,
        2. Its current power,
        3. How many asteroid collisions it has had.

    MissionRoute:
    This enquiry operation reports the route (regions of space) that the spaceship
    has travelled through in order.

    DockedAtStarbase:
    This enquiry operation reports whether the Spaceship is docked at the Starbase,
    i.e. its current location is the Starbase.

    GameStatus:
    This enquiry operation reports:
        1. Game WON, if the game is over & has been won
        2. Game LOST, if over & has been lost and
        3. Game Not Over, if its not over.
*/

MACHINE
    Spaceship
    
SEES
    Space
    
SETS
    REPORT = { MOVEMENT_SUCCESSFUL, MOVEMENT_FAILED, MOVEMENT_FAILED_OUT_OF_BOUND,  MOVEMENT_FAILED_ASTEROID_COLLISION,  MOVEMENT_FAILED_INSUFFICIENT_POWER, WARP_DRIVE_SUCCESSFUL, WARP_DRIVE_FAILED, WARP_DRIVE_FAILED_OUT_OF_BOUND,  WARP_DRIVE_FAILED_ASTEROID_COLLISION, WARP_DRIVE_FAILED_INSUFFICIENT_POWER, UNABLE_TO_DIRECTLY_WARP_TO_STARBASE, STARSHIP_IS_DOCKED_AT_STARBASE, STARSHIP_IS_NOT_AT_STARBASE, GAME_WON, GAME_LOST, GAME_NOT_OVER, GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME  } ;
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
    noOfAsteroidCollisions,
    spaceshipCurrentPosition,
    spaceshipRoute,
    gameStatus
    
INVARIANT
    spaceshipX : GridXRange &
    spaceshipY : GridYRange &
    spaceshipPower : INTEGER &
    noOfAsteroidCollisions : NAT &
    spaceshipCurrentPosition : Grid &
    spaceshipRoute : seq( Grid ) &
    gameStatus <: STATUS
    
INITIALISATION
    spaceshipX := 1
    || spaceshipY := 1
    || spaceshipPower := 120
    || noOfAsteroidCollisions := 0
    || spaceshipCurrentPosition := ( 1 |-> 1 ) 
    || spaceshipRoute := [ ( 1 |-> 1 ) ] 
    || gameStatus := { GameNotOver }
    
OPERATIONS
    
    report <-- MoveUp = 
    PRE
        report : REPORT   
    THEN
        /* Checks if the game is over */
        IF
            ( GameNotOver : gameStatus )
        THEN
            /* Checks if the power is enough for a normal move */
            IF
                ( spaceshipPower >= NormalMovePowerConsumption )
            THEN
                /* Checks if the spaceship is inside the grid and has not hit an asteroid */ 
                IF
                    ( isSpaceshipInsideGrid( spaceshipX, succ( spaceshipY ) ) & not( isAsteroidCollision( spaceshipX, succ( spaceshipY ) ) ) )
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( spaceshipX |-> succ( spaceshipY) ) : Starbase )
                    THEN
                        spaceshipX, spaceshipY := spaceshipX, succ( spaceshipY )
                        || spaceshipCurrentPosition := ( spaceshipX |-> succ( spaceshipY ) ) 
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ( spaceshipY ) ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( (spaceshipPower - NormalMovePowerConsumption) >= NormalMovePowerConsumption )
                        THEN
                            spaceshipX, spaceshipY := spaceshipX, succ( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> succ( spaceshipY ) )
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ( spaceshipY ) ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX, spaceshipY := spaceshipX, succ( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> succ( spaceshipY ) )
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ( spaceshipY ) ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                    /* Checks if the spaceship has hit an asteroid */
                ELSIF
                    ( isAsteroidCollision( spaceshipX, succ( spaceshipY ) ) )
                THEN
                    /* Checks if the power will be enough to continue the game after the collision penalty */
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )
                    THEN
                        gameStatus := { GameNotOver }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := MOVEMENT_FAILED_ASTEROID_COLLISION
                    ELSE
                        gameStatus := { GameLost }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := GAME_LOST
                    END
                    /* Checks if the spaceship is not inside the grid */     
                ELSIF
                    ( not( isSpaceshipInsideGrid( spaceshipX, succ( spaceshipY ) ) ) )
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE
                    report := MOVEMENT_FAILED
                END
                /* If the power is not enough, sets the game status to lost and displays an insufficient power message */    
            ELSE
                gameStatus := { GameLost }
                || report := MOVEMENT_FAILED_INSUFFICIENT_POWER
            END
            /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */    
        ELSIF 
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END;
    
    
    report <-- MoveDown = 
    PRE
        report : REPORT    
    THEN
        /* Checks if the game is over */
        IF
            ( GameNotOver : gameStatus )
        THEN
            /* Checks if the power is enough for a normal move */
            IF
                ( spaceshipPower >= NormalMovePowerConsumption )
            THEN
                /* Checks if the spaceship is inside the grid and has not hit an asteroid */ 
                IF
                    ( isSpaceshipInsideGrid( spaceshipX, pred( spaceshipY ) ) & not( isAsteroidCollision( spaceshipX, pred( spaceshipY ) ) ) )
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( spaceshipX |-> pred( spaceshipY) ) : Starbase )
                    THEN
                        spaceshipX, spaceshipY := spaceshipX, pred( spaceshipY )
                        || spaceshipCurrentPosition := ( spaceshipX |-> pred( spaceshipY ) )
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> pred( spaceshipY ) ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( (spaceshipPower - NormalMovePowerConsumption) >= NormalMovePowerConsumption )
                        THEN
                            spaceshipX, spaceshipY := spaceshipX, pred( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> pred( spaceshipY ) )
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> pred( spaceshipY ) ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX, spaceshipY := spaceshipX, pred( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> pred( spaceshipY ) )
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> pred( spaceshipY ) ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                    /* Checks if the spaceship has hit an asteroid */    
                ELSIF
                    ( isAsteroidCollision( spaceshipX, pred( spaceshipY ) ) )
                THEN
                    /* Checks if the power will be enough to continue the game after the collision penalty */
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )
                    THEN
                        gameStatus := { GameNotOver }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := MOVEMENT_FAILED_ASTEROID_COLLISION
                    ELSE
                        gameStatus := { GameLost }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := GAME_LOST
                    END
                    /* Checks if the spaceship is not inside the grid */     
                ELSIF
                    ( not( isSpaceshipInsideGrid( spaceshipX, pred( spaceshipY ) ) ) )
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE
                    report := MOVEMENT_FAILED
                END
                /* If the power is not enough, sets the game status to lost and displays an insufficient power message */    
            ELSE
                gameStatus := { GameLost }
                || report := MOVEMENT_FAILED_INSUFFICIENT_POWER
            END
            /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */    
        ELSIF 
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END;
    
    report <-- MoveBackward = 
    PRE
        report : REPORT  
    THEN
        /* Checks if the game is over */
        IF
            ( GameNotOver : gameStatus )
        THEN
            /* Checks if the power is enough for a normal move */
            IF
                ( spaceshipPower >= NormalMovePowerConsumption )
            THEN
                /* Checks if the spaceship is inside the grid and has not hit an asteroid */ 
                IF
                    ( isSpaceshipInsideGrid( pred( spaceshipX ), spaceshipY ) & not( isAsteroidCollision( pred( spaceshipX ), spaceshipY ) ) )
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( pred( spaceshipX ) |-> spaceshipY ) : Starbase )
                    THEN
                        spaceshipX, spaceshipY := pred( spaceshipX ), spaceshipY
                        || spaceshipCurrentPosition := ( pred( spaceshipX ) |-> spaceshipY )
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || spaceshipRoute := spaceshipRoute ^ [ pred( spaceshipX ) |-> spaceshipY ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( (spaceshipPower - NormalMovePowerConsumption) >= NormalMovePowerConsumption )
                        THEN
                            spaceshipX, spaceshipY := pred( spaceshipX ), spaceshipY
                            || spaceshipCurrentPosition := ( pred( spaceshipX ) |-> spaceshipY )
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ pred( spaceshipX ) |-> spaceshipY ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX, spaceshipY := pred( spaceshipX ), spaceshipY
                            || spaceshipCurrentPosition := ( pred( spaceshipX ) |-> spaceshipY )
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ pred( spaceshipX ) |-> spaceshipY ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                    /* Checks if the spaceship has hit an asteroid */
                ELSIF
                    ( isAsteroidCollision( pred( spaceshipX ), spaceshipY ) )
                THEN
                    /* Checks if the power will be enough to continue the game after the collision penalty */
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )
                    THEN
                        gameStatus := { GameNotOver }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := MOVEMENT_FAILED_ASTEROID_COLLISION
                    ELSE
                        gameStatus := { GameLost }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := GAME_LOST
                    END
                    /* Checks if the spaceship is not inside the grid */     
                ELSIF
                    ( not( isSpaceshipInsideGrid( pred( spaceshipX ), spaceshipY ) ) ) 
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE
                    report := MOVEMENT_FAILED
                END
                /* If the power is not enough, sets the game status to lost and displays an insufficient power message */    
            ELSE 
                gameStatus := { GameLost }
                || report := MOVEMENT_FAILED_INSUFFICIENT_POWER
            END
            /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */    
        ELSIF 
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END;
    
    report <-- MoveForward = 
    PRE
        report : REPORT  
    THEN
        /* Checks if the game is over */
        IF
            ( GameNotOver : gameStatus ) 
        THEN
            /* Checks if the power is enough for a normal move */
            IF
                ( spaceshipPower >= NormalMovePowerConsumption )
            THEN
                /* Checks if the spaceship is inside the grid and has not hit an asteroid */ 
                IF
                    ( isSpaceshipInsideGrid( succ( spaceshipX ), spaceshipY ) & not( isAsteroidCollision( succ( spaceshipX ), spaceshipY ) ) ) 
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( succ( spaceshipX ) |-> spaceshipY ) : Starbase ) 
                    THEN
                        spaceshipX, spaceshipY := succ( spaceshipX ), spaceshipY
                        || spaceshipCurrentPosition := ( succ( spaceshipX ) |-> spaceshipY )
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || spaceshipRoute := spaceshipRoute ^ [ succ( spaceshipX ) |-> spaceshipY ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( (spaceshipPower - NormalMovePowerConsumption) >= NormalMovePowerConsumption ) 
                        THEN
                            spaceshipX, spaceshipY := succ( spaceshipX ), spaceshipY
                            || spaceshipCurrentPosition := ( succ( spaceshipX ) |-> spaceshipY )
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ succ( spaceshipX ) |-> spaceshipY ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX, spaceshipY := succ( spaceshipX ), spaceshipY
                            || spaceshipCurrentPosition := ( succ( spaceshipX ) |-> spaceshipY )
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ succ( spaceshipX ) |-> spaceshipY ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                    /* Checks if the spaceship has hit an asteroid */    
                ELSIF
                    ( isAsteroidCollision( succ( spaceshipX ), spaceshipY ) )
                THEN
                    /* Checks if the power will be enough to continue the game after the collision penalty */
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )
                    THEN
                        gameStatus := { GameNotOver }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := MOVEMENT_FAILED_ASTEROID_COLLISION
                    ELSE
                        gameStatus := { GameLost }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := GAME_LOST
                    END
                    /* Checks if the spaceship is not inside the grid */
                ELSIF
                    ( not( isSpaceshipInsideGrid( succ( spaceshipX ), spaceshipY ) ) )
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE
                    report := MOVEMENT_FAILED
                END
                /* If the power is not enough, sets the game status to lost and displays an insufficient power message */    
            ELSE
                gameStatus := { GameLost }
                || report := MOVEMENT_FAILED_INSUFFICIENT_POWER
            END
            /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */    
        ELSIF
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END;
    
    report <-- EngageWarpDrive ( xx, yy ) = 
    PRE
        report : REPORT & xx : NAT1 & yy : NAT1
        THEN
        /* Checks if the game is over */
        IF
            ( GameNotOver : gameStatus ) 
        THEN
            /* Checks if the power is enough for a normal move */
            IF
                ( spaceshipPower >= WarpDrivePowerConsumption )
            THEN
                /* Checks if the spaceship is inside the grid and has not hit an asteroid */ 
                IF
                    ( isSpaceshipInsideGrid( xx, yy ) & not( isAsteroidCollision( xx, yy ) ) & not( spaceshipCurrentPosition : Homebase & ( xx |-> yy ) : Starbase ) ) 
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( xx |-> yy ) : Starbase ) 
                    THEN
                        spaceshipX, spaceshipY := xx, yy
                        || spaceshipCurrentPosition := ( xx |-> yy )
                        || spaceshipPower := spaceshipPower - WarpDrivePowerConsumption
                        || spaceshipRoute := spaceshipRoute ^ [ xx |-> yy ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( ( spaceshipPower - WarpDrivePowerConsumption ) >= NormalMovePowerConsumption ) 
                        THEN
                            spaceshipX, spaceshipY := xx, yy
                            || spaceshipCurrentPosition := ( xx |-> yy )
                            || spaceshipPower := spaceshipPower - WarpDrivePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ xx |-> yy ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX, spaceshipY := xx, yy
                            || spaceshipCurrentPosition := ( xx |-> yy )
                            || spaceshipPower := spaceshipPower - WarpDrivePowerConsumption
                            || spaceshipRoute := spaceshipRoute ^ [ xx |-> yy ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                /* Checks if the user tries to warp directly from home base to star base */
                ELSIF
                    ( spaceshipCurrentPosition : Homebase & ( xx |-> yy ) : Starbase ) 
                THEN
                    report := UNABLE_TO_DIRECTLY_WARP_TO_STARBASE
                /* Checks if the spaceship has hit an asteroid */
                ELSIF
                    ( isAsteroidCollision( xx, yy ) )
                THEN
                    /* Checks if the power will be enough to continue the game after the collision penalty */
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )
                    THEN
                        gameStatus := { GameNotOver }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || report := WARP_DRIVE_FAILED_ASTEROID_COLLISION
                    ELSE
                        gameStatus := { GameLost }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || report := GAME_LOST
                    END
                /* Checks if the spaceship is not inside the grid */
                ELSIF
                    ( not( isSpaceshipInsideGrid( xx, yy ) ) )
                THEN
                    report := WARP_DRIVE_FAILED_OUT_OF_BOUND
                ELSE
                    report := WARP_DRIVE_FAILED
                END
            /* If the power is not enough, sets the game status to lost and displays an insufficient power message */    
            ELSE
                report := WARP_DRIVE_FAILED_INSUFFICIENT_POWER
            END
         /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */    
        ELSIF
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END;
    
    location, power, collisions <-- MissionStatus =
    BEGIN
        location := spaceshipCurrentPosition
        || power := spaceshipPower
        || collisions := noOfAsteroidCollisions
    END;
    
    report <-- MissionRoute =
    BEGIN
        report := spaceshipRoute
    END;
    
    report <-- DockedAtStarbase =
    PRE
        report : REPORT  
    THEN
        IF
            ( spaceshipCurrentPosition : Starbase )
        THEN
            report := STARSHIP_IS_DOCKED_AT_STARBASE
        ELSE
            report := STARSHIP_IS_NOT_AT_STARBASE
        END
    END;
    
    report <-- GameStatus =
    PRE
        report : REPORT  
    THEN
        IF
            ( GameWon : gameStatus )
        THEN
            report := GAME_WON
        ELSIF
            ( GameLost : gameStatus )
        THEN
            report := GAME_LOST
        ELSIF
            ( GameNotOver : gameStatus )
        THEN
            report := GAME_NOT_OVER
        END
    END
    
END
