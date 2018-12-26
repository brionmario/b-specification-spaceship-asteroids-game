/* Space
 * Author: Brion Silva
 * Creation date: 21/12/2018
 */
MACHINE
    Space

CONCRETE_CONSTANTS
    GridXRange ,
    GridYRange ,
    Grid ,
    Homebase ,
    Starbase ,
    Asteroids

PROPERTIES
    GridXRange <: NAT1 &
    GridXRange = 1 .. 12 &
    GridYRange <: NAT1 &
    GridYRange =  1 .. 7 &
    Grid : POW ( NAT1 * NAT1 ) &
    Grid =  GridXRange * GridYRange &
    Asteroids : POW ( NAT1 * NAT1 ) &
    Asteroids = { ( 7 |-> 1 ) , ( 3 |-> 2 ) , ( 11 |-> 2 ) , ( 8 |-> 3 ) , ( 5 |-> 4 ) , ( 3 |-> 5 ) , ( 7 |-> 5 ) , ( 12 |-> 5 ) , ( 10 |-> 6 ) , ( 6 |-> 7 ) , ( 7 |-> 7 ) } &
    Homebase : POW ( NAT1 * NAT1 ) &
    Homebase = { ( 1 |-> 1 ) } &
    Starbase : POW ( NAT1 * NAT1 ) &
    Starbase = { ( 6 |-> 4 ) }



END
