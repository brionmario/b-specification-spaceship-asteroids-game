/* Spaceship
 * Author: Brion Silva
 * Creation date: 21/12/2018
 */
MACHINE
    Spaceship
    
SEES
    Space
    
SETS
    REPORT = { movement_successful, movement_failed_out_of_bound,  movement_failed_asteroid_collision,  movement_failed_insufficient_power, warp_drive_successful, warp_drive_failed_out_of_bound,  warp_drive_failed_asteroid_collision, warp_drive_failed_insufficient_power };
    MOVEMENTS = { move_up, move_down, move_forward, move_backward, warp_drive };

END
