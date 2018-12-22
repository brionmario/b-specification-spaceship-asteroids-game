/* Spaceship
 * Author: Brion Silva
 * Creation date: 21/12/2018
 */
MACHINE
    Spaceship
    
SEES
    Space
    
SETS
    REPORT           = { Movement_Successful, Movement_failed_out_of_bound,  Movement_Failed_Asteroid_Collision,  Movement_Failed_Insufficient_Power, Warp_Drive_Successful, Warp_Drive_Failed_Out_Of_Bound,  Warp_Drive_Failed_Asteroid_Collision, Warp_Drive_Failed_Insufficient_Power, Can_Not_Warp_To_Starbase, Starship_Docked, Game_Won, Game_Lost, Game_Not_Over  } ;
    CURSOR_KEY = { Up_Key, Down_Key, Left_Key, Right_Key, Warp_Drive_Key } ;
    
DEFINITIONS
    isSpaceshipInsideGrid( xx, yy ) == ( ( xx |-> yy ) : Grid ) ;
    isAsteroidCollision( xx, yy )       == ( ( xx |-> yy ) : Asteroids ) ;

VARIABLES
    spaceshipX,
    spaceshipY,
    spaceshipPower,
    visitedRegions,
    noOfMovements,
    spaceshipCurrentPosition,
    spaceshipRoute,
    spaceshipMovements
    
INVARIANT
    spaceshipX                        : GridXRange &
    spaceshipY                        : GridYRange &
    spaceshipPower                : NAT &
    visitedRegions                 <: Grid &
    noOfMovements                : NAT &
    spaceshipCurrentPosition : Grid &
    spaceshipRoute                : seq( Grid ) &
    spaceshipMovements       : seq( CURSOR_KEY )
   
INITIALISATION
    spaceshipX                           := 1
    || spaceshipY                        := 1
    || spaceshipPower                := 30
    || visitedRegions                   := { }
    || noOfMovements                := 0
    || spaceshipCurrentPosition := ( 1 |-> 1 ) 
    || spaceshipRoute                := [ ( 1 |-> 1 ) ] 
    || spaceshipMovements       := [ ]
    
END
