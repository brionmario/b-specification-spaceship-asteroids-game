/* Space
 * Author: Brion Silva
 * Creation date: 21/12/2018
 */
MACHINE Space

CONSTANTS
    spacewidth, spaceheight, space, homebase, starbase, asteroids
    
PROPERTIES
    spacewidth <: NAT1 & spacewidth = 1..12 &
    spaceheight <: NAT1 & spaceheight =  1..7 &
    space : SPACE & space =  spacewidth * spaceheight &
    asteroids : SPACE & asteroids = { 7 |-> 1, 3 |-> 2, 11 |-> 2, 8 |-> 3, 5 |-> 4, 3 |-> 5, 7 |-> 5, 12 |-> 5, 10 |-> 6, 6 |-> 7, 7 |-> 7 } &
    homebase : SPACE & homebase = { 1 |-> 1 } &
    starbase : SPACE & starbase = { 6 |-> 4 }
    
DEFINITIONS
    SPACE == POW(NAT1 * NAT1)

END
