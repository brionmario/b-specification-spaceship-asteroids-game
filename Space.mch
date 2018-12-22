/* Space
 * Author: Brion Silva
 * Creation date: 21/12/2018
 */
MACHINE 
    Space

CONSTANTS
    GridWidth, GridHeight, Grid, Homebase, Starbase, Asteroids
    
PROPERTIES
    GridWidth <: NAT1 & GridWidth = 1..12 &
    GridHeight <: NAT1 & GridHeight =  1..7 &
    Grid : GRID & Grid =  GridWidth * GridHeight &
    Asteroids : GRID & Asteroids = { 7 |-> 1, 3 |-> 2, 11 |-> 2, 8 |-> 3, 5 |-> 4, 3 |-> 5, 7 |-> 5, 12 |-> 5, 10 |-> 6, 6 |-> 7, 7 |-> 7 } &
    Homebase : GRID & Homebase = { 1 |-> 1 } &
    Starbase : GRID & Starbase = { 6 |-> 4 }
    
DEFINITIONS
    GRID == POW(NAT1 * NAT1)

END
