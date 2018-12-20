/* Grid
 * Author: Brion Silva
 * Creation date: 21/12/2018
 */
MACHINE
    Grid

END

/* Maze
 * Author: Sharanjaa_2014184
 * Creation date: 12/27/2017
 */
MACHINE
    Maze

CONSTANTS
    mazeX, mazeY, panel, dark_walls, exit_cell, entrance_cell
    
PROPERTIES
    mazeX <: NAT1 & mazeX = 1..7 &
    mazeY <: NAT1 & mazeY =  1..5 &
    panel : PANEL & panel =  mazeX * mazeY &
    dark_walls : PANEL & dark_walls = { 2|->1, 6|->1, 4|->2, 6|->2, 1|->3, 2|->3, 3|->3, 4|->3, 4|->4, 6|->4, 7|->4, 2|->5 } &
    exit_cell : PANEL & exit_cell = {(1|->5)} &
    entrance_cell : PANEL & entrance_cell = {(1|->1)}
    
DEFINITIONS
    PANEL == POW(NAT1 * NAT1)    
         
END
