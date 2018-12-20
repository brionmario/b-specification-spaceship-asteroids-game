/* Space
 * Author: Brion Silva
 * Creation date: 21/12/2018
 */
MACHINE Space

CONCRETE_CONSTANTS
    spacewidth , spaceheight , space , homebase , starbase , asteroids

PROPERTIES
    spacewidth <: NAT1 & spacewidth = 1 .. 12 &
    spaceheight <: NAT1 & spaceheight =  1 .. 7 &
    space : POW ( NAT1 * NAT1 ) & space = spacewidth * spaceheight &
    asteroids : POW ( NAT1 * NAT1 ) & asteroids = { 7 |-> 1 , 3 |-> 2 , 11 |-> 2 , 8 |-> 3 , 5 |-> 4 , 3 |-> 5 , 7 |-> 5 , 12 |-> 5 , 10 |-> 6 , 6 |-> 7 , 7 |-> 7 } &
    homebase : POW ( NAT1 * NAT1 ) & homebase = { 1 |-> 1 } &
    starbase : POW ( NAT1 * NAT1 ) & starbase = { 6 |-> 4 }




END
