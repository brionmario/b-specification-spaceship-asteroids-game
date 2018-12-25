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
    Grid : NAT <-> NAT &
    Grid =  GridXRange * GridYRange &
    Asteroids : POW ( Grid ) &
    Asteroids = { ( 7 |-> 1 ) , ( 3 |-> 2 ) , ( 11 |-> 2 ) , ( 8 |-> 3 ) , ( 5 |-> 4 ) , ( 3 |-> 5 ) , ( 7 |-> 5 ) , ( 12 |-> 5 ) , ( 10 |-> 6 ) , ( 6 |-> 7 ) , ( 7 |-> 7 ) } &
    Homebase : Grid &
    Homebase = ( 1 |-> 1 ) &
    Starbase : Grid &
    Starbase = ( 6 |-> 4 )

END
