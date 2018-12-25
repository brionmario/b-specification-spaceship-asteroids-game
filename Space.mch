/* Space
 * Author: Brion Silva
 * Creation date: 21/12/2018
 */
MACHINE 
    Space

CONSTANTS
    GridXRange,
    GridYRange,
    Grid,
    Homebase,
    Starbase,
    Asteroids
    
PROPERTIES
    GridXRange <: NAT1 &
    GridXRange = 1..12 &
    GridYRange <: NAT1 &
    GridYRange =  1..7 &
    Grid : GRID &
    Grid =  GridXRange * GridYRange &
    Asteroids : GRID &
    Asteroids = { ( 7 |-> 1 ), ( 3 |-> 2 ), ( 11 |-> 2 ), ( 8 |-> 3 ), ( 5 |-> 4 ), ( 3 |-> 5 ), ( 7 |-> 5 ), ( 12 |-> 5 ), ( 10 |-> 6 ), ( 6 |-> 7 ), ( 7 |-> 7 ) } &
    Homebase : GRID &
    Homebase = { ( 1 |-> 1 ) } &
    Starbase : GRID &
    Starbase = { ( 6 |-> 4 ) }
    
DEFINITIONS
    GRID == POW( NAT1 * NAT1 )
END
