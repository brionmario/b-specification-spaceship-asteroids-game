/* Spaceship
* Author: Brion Silva
* Creation date: 21/12/2018
*/
MACHINE
    Spaceship

SEES
    Space

SETS
    REPORT = { MOVEMENT_SUCCESSFUL , MOVEMENT_FAILED , MOVEMENT_FAILED_OUT_OF_BOUND , MOVEMENT_FAILED_ASTEROID_COLLISION , MOVEMENT_FAILED_INSUFFICIENT_POWER , WARP_DRIVE_SUCCESSFUL , WARP_DRIVE_FAILED , WARP_DRIVE_FAILED_OUT_OF_BOUND , WARP_DRIVE_FAILED_ASTEROID_COLLISION , WARP_DRIVE_FAILED_INSUFFICIENT_POWER , UNABLE_TO_DIRECTLY_WARP_TO_STARBASE , STARSHIP_DOCKED , GAME_WON , GAME_LOST , GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME } ;
    MOVEMENTS = { Upward , Downward , Backward , Forward , WarpDrive } ;
    STATUS = { GameWon , GameLost , GameNotOver }

DEFINITIONS
    isSpaceshipInsideGrid ( xx , yy ) == ( ( xx |-> yy ) : Grid ) ;
    isAsteroidCollision ( xx , yy ) == ( ( xx |-> yy ) : Asteroids )

CONCRETE_CONSTANTS
    NormalMovePowerConsumption ,
    WarpDrivePowerConsumption ,
    AsteroidCollisionPowerConsumption

PROPERTIES
    NormalMovePowerConsumption : NAT1  &
    NormalMovePowerConsumption = 5 &
    WarpDrivePowerConsumption : NAT1  &
    WarpDrivePowerConsumption = 20 &
    AsteroidCollisionPowerConsumption : NAT1  &
    AsteroidCollisionPowerConsumption = 10


ABSTRACT_VARIABLES
    spaceshipX ,
    spaceshipY ,
    spaceshipPower ,
    visitedRegions ,
    noOfMovements ,
    noOfAsteroidCollisions ,
    spaceshipCurrentPosition ,
    spaceshipRoute ,
    spaceshipMovements ,
    gameStatus

INVARIANT
    spaceshipX : GridXRange &
    spaceshipY : GridYRange &
    spaceshipPower : NAT &
    visitedRegions <: Grid &
    noOfMovements : NAT &
    noOfAsteroidCollisions : NAT &
    spaceshipCurrentPosition : Grid &
    spaceshipRoute : seq ( Grid ) &
    spaceshipMovements : seq ( MOVEMENTS ) &
    gameStatus <: STATUS

INITIALISATION
    spaceshipX := 1
    || spaceshipY := 1
    || spaceshipPower := 80
    || visitedRegions := {}
    || noOfMovements := 0
    || noOfAsteroidCollisions := 0
    || spaceshipCurrentPosition := ( 1 |-> 1 )
    || spaceshipRoute := [ ( 1 |-> 1 ) ]
    || spaceshipMovements := []
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
                    ( isSpaceshipInsideGrid ( spaceshipX , succ ( spaceshipY ) ) & not ( isAsteroidCollision ( spaceshipX , succ ( spaceshipY ) ) ) )
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( spaceshipX |-> succ ( spaceshipY ) ) : Starbase )
                    THEN
                        spaceshipX , spaceshipY := spaceshipX , succ ( spaceshipY )
                        || spaceshipCurrentPosition := ( spaceshipX |-> succ ( spaceshipY ) )
                        || noOfMovements := noOfMovements + 1
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || visitedRegions := visitedRegions \/ { ( spaceshipX |-> succ ( spaceshipY ) ) }
                        || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ ( spaceshipY ) ]
                        || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( ( spaceshipPower - NormalMovePowerConsumption ) >= NormalMovePowerConsumption )
                        THEN
                            spaceshipX , spaceshipY := spaceshipX , succ ( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> succ ( spaceshipY ) )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( spaceshipX |-> succ ( spaceshipY ) ) }
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ ( spaceshipY ) ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX , spaceshipY := spaceshipX , succ ( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> succ ( spaceshipY ) )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( spaceshipX |-> succ ( spaceshipY ) ) }
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ ( spaceshipY ) ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                    /* Checks if the spaceship has hit an asteroid */
                ELSIF
                    ( isAsteroidCollision ( spaceshipX , succ ( spaceshipY ) ) )
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
                    ( not ( isSpaceshipInsideGrid ( spaceshipX , succ ( spaceshipY ) ) ) )
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE /* Default movement error */
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
    END ;


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
                    ( isSpaceshipInsideGrid ( spaceshipX , pred ( spaceshipY ) ) & not ( isAsteroidCollision ( spaceshipX , pred ( spaceshipY ) ) ) )
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( spaceshipX |-> pred ( spaceshipY ) ) : Starbase )
                    THEN
                        spaceshipX , spaceshipY := spaceshipX , pred ( spaceshipY )
                        || spaceshipCurrentPosition := ( spaceshipX |-> pred ( spaceshipY ) )
                        || noOfMovements := noOfMovements + 1
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || visitedRegions := visitedRegions \/ { ( spaceshipX |-> pred ( spaceshipY ) ) }
                        || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> pred ( spaceshipY ) ]
                        || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( ( spaceshipPower - NormalMovePowerConsumption ) >= NormalMovePowerConsumption )
                        THEN
                            spaceshipX , spaceshipY := spaceshipX , pred ( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> pred ( spaceshipY ) )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( spaceshipX |-> pred ( spaceshipY ) ) }
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> pred ( spaceshipY ) ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX , spaceshipY := spaceshipX , pred ( spaceshipY )
                            || spaceshipCurrentPosition := ( spaceshipX |-> pred ( spaceshipY ) )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( spaceshipX |-> pred ( spaceshipY ) ) }
                            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> pred ( spaceshipY ) ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                    /* Checks if the spaceship has hit an asteroid */
                ELSIF
                    ( isAsteroidCollision ( spaceshipX , pred ( spaceshipY ) ) )
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
                    ( not ( isSpaceshipInsideGrid ( spaceshipX , pred ( spaceshipY ) ) ) )
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE /* Default movement error */
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
    END ;

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
                    ( isSpaceshipInsideGrid ( pred ( spaceshipX ) , spaceshipY ) & not ( isAsteroidCollision ( pred ( spaceshipX ) , spaceshipY ) ) )
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( pred ( spaceshipX ) |-> spaceshipY ) : Starbase )
                    THEN
                        spaceshipX , spaceshipY := pred ( spaceshipX ) , spaceshipY
                        || spaceshipCurrentPosition := ( pred ( spaceshipX ) |-> spaceshipY )
                        || noOfMovements := noOfMovements + 1
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || visitedRegions := visitedRegions \/ { ( pred ( spaceshipX ) |-> spaceshipY ) }
                        || spaceshipRoute := spaceshipRoute ^ [ pred ( spaceshipX ) |-> spaceshipY ]
                        || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( ( spaceshipPower - NormalMovePowerConsumption ) >= NormalMovePowerConsumption )
                        THEN
                            spaceshipX , spaceshipY := pred ( spaceshipX ) , spaceshipY
                            || spaceshipCurrentPosition := ( pred ( spaceshipX ) |-> spaceshipY )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( pred ( spaceshipX ) |-> spaceshipY ) }
                            || spaceshipRoute := spaceshipRoute ^ [ pred ( spaceshipX ) |-> spaceshipY ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX , spaceshipY := pred ( spaceshipX ) , spaceshipY
                            || spaceshipCurrentPosition := ( pred ( spaceshipX ) |-> spaceshipY )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( pred ( spaceshipX ) |-> spaceshipY ) }
                            || spaceshipRoute := spaceshipRoute ^ [ pred ( spaceshipX ) |-> spaceshipY ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                    /* Checks if the spaceship has hit an asteroid */
                ELSIF
                    ( isAsteroidCollision ( pred ( spaceshipX ) , spaceshipY ) )
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
                    ( not ( isSpaceshipInsideGrid ( pred ( spaceshipX ) , spaceshipY ) ) )
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE /* Default movement error */
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
    END ;

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
                    ( isSpaceshipInsideGrid ( succ ( spaceshipX ) , spaceshipY ) & not ( isAsteroidCollision ( succ ( spaceshipX ) , spaceshipY ) ) )
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( succ ( spaceshipX ) |-> spaceshipY ) : Starbase )
                    THEN
                        spaceshipX , spaceshipY := succ ( spaceshipX ) , spaceshipY
                        || spaceshipCurrentPosition := ( succ ( spaceshipX ) |-> spaceshipY )
                        || noOfMovements := noOfMovements + 1
                        || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                        || visitedRegions := visitedRegions \/ { ( succ ( spaceshipX ) |-> spaceshipY ) }
                        || spaceshipRoute := spaceshipRoute ^ [ succ ( spaceshipX ) |-> spaceshipY ]
                        || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( ( spaceshipPower - NormalMovePowerConsumption ) >= NormalMovePowerConsumption )
                        THEN
                            spaceshipX , spaceshipY := succ ( spaceshipX ) , spaceshipY
                            || spaceshipCurrentPosition := ( succ ( spaceshipX ) |-> spaceshipY )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( succ ( spaceshipX ) |-> spaceshipY ) }
                            || spaceshipRoute := spaceshipRoute ^ [ succ ( spaceshipX ) |-> spaceshipY ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX , spaceshipY := succ ( spaceshipX ) , spaceshipY
                            || spaceshipCurrentPosition := ( succ ( spaceshipX ) |-> spaceshipY )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - NormalMovePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( succ ( spaceshipX ) |-> spaceshipY ) }
                            || spaceshipRoute := spaceshipRoute ^ [ succ ( spaceshipX ) |-> spaceshipY ]
                            || spaceshipMovements := spaceshipMovements ^ [ Upward ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                    /* Checks if the spaceship has hit an asteroid */
                ELSIF
                    ( isAsteroidCollision ( succ ( spaceshipX ) , spaceshipY ) )
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
                    ( not ( isSpaceshipInsideGrid ( succ ( spaceshipX ) , spaceshipY ) ) )
                THEN
                    report := MOVEMENT_FAILED_OUT_OF_BOUND
                ELSE /* Default movement error */
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
    END ;

    report <-- EngageWarpDrive ( xx , yy ) =
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
                    ( isSpaceshipInsideGrid ( xx , yy ) & not ( isAsteroidCollision ( xx , yy ) ) )
                THEN
                    /* Checks if the current move results in the game winning */
                    IF
                        ( ( xx |-> yy ) : Starbase )
                    THEN
                        spaceshipX , spaceshipY := xx , yy
                        || spaceshipCurrentPosition := ( xx |-> yy )
                        || noOfMovements := noOfMovements + 1
                        || spaceshipPower := spaceshipPower - WarpDrivePowerConsumption
                        || visitedRegions := visitedRegions \/ { ( xx |-> yy ) }
                        || spaceshipRoute := spaceshipRoute ^ [ xx |-> yy ]
                        || spaceshipMovements := spaceshipMovements ^ [ WarpDrive ]
                        || gameStatus := { GameWon }
                        || report := GAME_WON
                    ELSE
                        /* Checks if power will be enough to continue with the game after the current move */
                        IF
                            ( ( spaceshipPower - WarpDrivePowerConsumption ) >= NormalMovePowerConsumption )
                        THEN
                            spaceshipX , spaceshipY := xx , yy
                            || spaceshipCurrentPosition := ( xx |-> yy )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - WarpDrivePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( xx |-> yy ) }
                            || spaceshipRoute := spaceshipRoute ^ [ xx |-> yy ]
                            || spaceshipMovements := spaceshipMovements ^ [ WarpDrive ]
                            || gameStatus := { GameNotOver }
                            || report := MOVEMENT_SUCCESSFUL
                        ELSE
                            spaceshipX , spaceshipY := xx , yy
                            || spaceshipCurrentPosition := ( xx |-> yy )
                            || noOfMovements := noOfMovements + 1
                            || spaceshipPower := spaceshipPower - WarpDrivePowerConsumption
                            || visitedRegions := visitedRegions \/ { ( xx |-> yy ) }
                            || spaceshipRoute := spaceshipRoute ^ [ xx |-> yy ]
                            || spaceshipMovements := spaceshipMovements ^ [ WarpDrive ]
                            || gameStatus := { GameLost }
                            || report := GAME_LOST
                        END
                    END
                    /* Checks if the spaceship has hit an asteroid */
                ELSIF
                    ( isAsteroidCollision ( xx , yy ) )
                THEN
                    /* Checks if the power will be enough to continue the game after the collision penalty */
                    IF
                        ( ( spaceshipPower - AsteroidCollisionPowerConsumption ) >= NormalMovePowerConsumption )
                    THEN
                        gameStatus := { GameNotOver }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := WARP_DRIVE_FAILED_ASTEROID_COLLISION
                    ELSE
                        gameStatus := { GameLost }
                        || noOfAsteroidCollisions := noOfAsteroidCollisions + 1
                        || spaceshipPower  := spaceshipPower - AsteroidCollisionPowerConsumption
                        || report := GAME_LOST
                    END
                    /* Checks if the spaceship is not inside the grid */
                ELSIF
                    ( not ( isSpaceshipInsideGrid ( xx , yy ) ) )
                THEN
                    report := WARP_DRIVE_FAILED_OUT_OF_BOUND
                ELSE /* Default warp drive error */
                    report := WARP_DRIVE_FAILED
                END
            /* If the power is not enough, sets the game status to lost and displays an insufficient power message */
            ELSE
                gameStatus := { GameLost }
                || report := WARP_DRIVE_FAILED_INSUFFICIENT_POWER
            END
         /* If the game is either already won or lost, a message will be displayed and the user will not be able to make any more moves */
        ELSIF
            ( GameWon : gameStatus or GameLost :  gameStatus )
        THEN
            report := GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME
        END
    END

END
