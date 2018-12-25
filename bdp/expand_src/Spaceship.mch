/* Spaceship
 * Author: Brion Silva
 * Creation date: 21/12/2018
 */
MACHINE
    Spaceship

SEES
    Space

SETS
    REPORT           = { Movement_Successful , Movement_failed_out_of_bound , Movement_Failed_Asteroid_Collision , Movement_Failed_Insufficient_Power , Warp_Drive_Successful , Warp_Drive_Failed_Out_Of_Bound , Warp_Drive_Failed_Asteroid_Collision , Warp_Drive_Failed_Insufficient_Power , Can_Not_Warp_To_Starbase , Starship_Docked , Game_Won , Game_Lost , Game_Not_Over } ;
    MOVEMENTS  = { Up , Down , Left , Right , WarpDrive }

DEFINITIONS
    isSpaceshipInsideGrid ( xx , yy ) == ( ( xx |-> yy ) : Grid ) ;
    isAsteroidCollision ( xx , yy )     == ( ( xx |-> yy ) : Asteroids )

ABSTRACT_VARIABLES
    spaceshipX ,
    spaceshipY ,
    spaceshipPower ,
    visitedRegions ,
    noOfMovements ,
    spaceshipCurrentPosition ,
    spaceshipRoute ,
    spaceshipMovements

INVARIANT
    spaceshipX                        : GridXRange &
    spaceshipY                        : GridYRange &
    spaceshipPower                : NAT &
    visitedRegions                 <: Grid &
    noOfMovements                : NAT &
    spaceshipCurrentPosition : Grid &
    spaceshipRoute                : seq ( Grid ) &
    spaceshipMovements       : seq ( MOVEMENTS )

INITIALISATION
    spaceshipX                           := 1
    || spaceshipY                        := 1
    || spaceshipPower                := 30
    || visitedRegions                   := {}
    || noOfMovements                := 0
    || spaceshipCurrentPosition := ( 1 |-> 1 )
    || spaceshipRoute                := [ ( 1 |-> 1 ) ]
    || spaceshipMovements       := []

OPERATIONS
    /*
     * Operation to move upwards when the corresponding key is pressed.
     * Normal movement and costs 5 units of power.
     * Requires no arguments and outputs a reporting message.
     */
    report <-- MoveUpwards =
    PRE
        report : REPORT

    THEN
        IF
            ( isSpaceshipInsideGrid ( spaceshipX , succ ( spaceshipY ) ) & not ( isAsteroidCollision ( spaceshipX , succ ( spaceshipY ) ) ) )
        THEN
            spaceshipX , spaceshipY := spaceshipX , succ ( spaceshipY )
            || spaceshipCurrentPosition := ( spaceshipX |-> spaceshipY )
            || noOfMovements := noOfMovements + 1
            || visitedRegions := visitedRegions \/ { ( spaceshipX |-> succ ( spaceshipY ) ) }
            || spaceshipRoute := spaceshipRoute ^ [ spaceshipX |-> succ ( spaceshipY ) ]
            || spaceshipMovements := spaceshipMovements ^ [ Up ]
            || report := Movement_Successful

        ELSIF
            ( isAsteroidCollision ( spaceshipX , succ ( spaceshipY ) ) )

        THEN
            spaceshipPower  := spaceshipPower - 10
            || report := Movement_Failed_Asteroid_Collision

        ELSIF
            ( not ( isSpaceshipInsideGrid ( spaceshipX , succ ( spaceshipY ) ) ) )

        THEN
            report := Movement_failed_out_of_bound

        END

    END

END
