Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(Spaceship))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(Spaceship))==(Machine(Spaceship));
  Level(Machine(Spaceship))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(Spaceship)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(Spaceship))==(Space)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(Spaceship))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(Spaceship))==(?);
  List_Includes(Machine(Spaceship))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(Spaceship))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(Spaceship))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(Spaceship))==(?);
  Context_List_Variables(Machine(Spaceship))==(?);
  Abstract_List_Variables(Machine(Spaceship))==(?);
  Local_List_Variables(Machine(Spaceship))==(gameStatus,spaceshipRoute,spaceshipCurrentPosition,noOfAsteroidCollisions,spaceshipPower,spaceshipY,spaceshipX);
  List_Variables(Machine(Spaceship))==(gameStatus,spaceshipRoute,spaceshipCurrentPosition,noOfAsteroidCollisions,spaceshipPower,spaceshipY,spaceshipX);
  External_List_Variables(Machine(Spaceship))==(gameStatus,spaceshipRoute,spaceshipCurrentPosition,noOfAsteroidCollisions,spaceshipPower,spaceshipY,spaceshipX)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(Spaceship))==(?);
  Abstract_List_VisibleVariables(Machine(Spaceship))==(?);
  External_List_VisibleVariables(Machine(Spaceship))==(?);
  Expanded_List_VisibleVariables(Machine(Spaceship))==(?);
  List_VisibleVariables(Machine(Spaceship))==(?);
  Internal_List_VisibleVariables(Machine(Spaceship))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(Spaceship))==(btrue);
  Gluing_List_Invariant(Machine(Spaceship))==(btrue);
  Expanded_List_Invariant(Machine(Spaceship))==(btrue);
  Abstract_List_Invariant(Machine(Spaceship))==(btrue);
  Context_List_Invariant(Machine(Spaceship))==(btrue);
  List_Invariant(Machine(Spaceship))==(spaceshipX: GridXRange & spaceshipY: GridYRange & spaceshipPower: NAT & noOfAsteroidCollisions: NAT & spaceshipCurrentPosition: Grid & spaceshipRoute: seq(Grid) & gameStatus <: STATUS)
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(Spaceship))==(btrue);
  Abstract_List_Assertions(Machine(Spaceship))==(btrue);
  Context_List_Assertions(Machine(Spaceship))==(btrue);
  List_Assertions(Machine(Spaceship))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(Spaceship))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(Spaceship))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(Spaceship))==(spaceshipX,spaceshipY,spaceshipPower,noOfAsteroidCollisions,spaceshipCurrentPosition,spaceshipRoute,gameStatus:=1,1,80,0,1|->1,[1|->1],{GameNotOver});
  Context_List_Initialisation(Machine(Spaceship))==(skip);
  List_Initialisation(Machine(Spaceship))==(spaceshipX:=1 || spaceshipY:=1 || spaceshipPower:=80 || noOfAsteroidCollisions:=0 || spaceshipCurrentPosition:=1|->1 || spaceshipRoute:=[1|->1] || gameStatus:={GameNotOver})
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(Spaceship))==(?)
END
&
THEORY ListInstanciatedParametersX IS
  List_Instanciated_Parameters(Machine(Spaceship),Machine(Space))==(?)
END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(Spaceship))==(btrue);
  List_Constraints(Machine(Spaceship))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(Spaceship))==(MoveUp,MoveDown,MoveBackward,MoveForward,EngageWarpDrive,MissionStatus,MissionRoute,DockedAtStarbase,GameStatus);
  List_Operations(Machine(Spaceship))==(MoveUp,MoveDown,MoveBackward,MoveForward,EngageWarpDrive,MissionStatus,MissionRoute,DockedAtStarbase,GameStatus)
END
&
THEORY ListInputX IS
  List_Input(Machine(Spaceship),MoveUp)==(?);
  List_Input(Machine(Spaceship),MoveDown)==(?);
  List_Input(Machine(Spaceship),MoveBackward)==(?);
  List_Input(Machine(Spaceship),MoveForward)==(?);
  List_Input(Machine(Spaceship),EngageWarpDrive)==(xx,yy);
  List_Input(Machine(Spaceship),MissionStatus)==(?);
  List_Input(Machine(Spaceship),MissionRoute)==(?);
  List_Input(Machine(Spaceship),DockedAtStarbase)==(?);
  List_Input(Machine(Spaceship),GameStatus)==(?)
END
&
THEORY ListOutputX IS
  List_Output(Machine(Spaceship),MoveUp)==(report);
  List_Output(Machine(Spaceship),MoveDown)==(report);
  List_Output(Machine(Spaceship),MoveBackward)==(report);
  List_Output(Machine(Spaceship),MoveForward)==(report);
  List_Output(Machine(Spaceship),EngageWarpDrive)==(report);
  List_Output(Machine(Spaceship),MissionStatus)==(location,power,collisions);
  List_Output(Machine(Spaceship),MissionRoute)==(report);
  List_Output(Machine(Spaceship),DockedAtStarbase)==(report);
  List_Output(Machine(Spaceship),GameStatus)==(report)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(Spaceship),MoveUp)==(report <-- MoveUp);
  List_Header(Machine(Spaceship),MoveDown)==(report <-- MoveDown);
  List_Header(Machine(Spaceship),MoveBackward)==(report <-- MoveBackward);
  List_Header(Machine(Spaceship),MoveForward)==(report <-- MoveForward);
  List_Header(Machine(Spaceship),EngageWarpDrive)==(report <-- EngageWarpDrive(xx,yy));
  List_Header(Machine(Spaceship),MissionStatus)==(location,power,collisions <-- MissionStatus);
  List_Header(Machine(Spaceship),MissionRoute)==(report <-- MissionRoute);
  List_Header(Machine(Spaceship),DockedAtStarbase)==(report <-- DockedAtStarbase);
  List_Header(Machine(Spaceship),GameStatus)==(report <-- GameStatus)
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(Spaceship),MoveUp)==(report: REPORT);
  List_Precondition(Machine(Spaceship),MoveDown)==(report: REPORT);
  List_Precondition(Machine(Spaceship),MoveBackward)==(report: REPORT);
  List_Precondition(Machine(Spaceship),MoveForward)==(report: REPORT);
  List_Precondition(Machine(Spaceship),EngageWarpDrive)==(report: REPORT & xx: NAT1 & yy: NAT1);
  List_Precondition(Machine(Spaceship),MissionStatus)==(btrue);
  List_Precondition(Machine(Spaceship),MissionRoute)==(btrue);
  List_Precondition(Machine(Spaceship),DockedAtStarbase)==(report: REPORT);
  List_Precondition(Machine(Spaceship),GameStatus)==(report: REPORT)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(Spaceship),GameStatus)==(report: REPORT | GameWon: gameStatus ==> report:=GAME_WON [] not(GameWon: gameStatus) ==> (GameLost: gameStatus ==> report:=GAME_LOST [] not(GameLost: gameStatus) ==> (GameNotOver: gameStatus ==> report:=GAME_NOT_OVER [] not(GameNotOver: gameStatus) ==> skip)));
  Expanded_List_Substitution(Machine(Spaceship),DockedAtStarbase)==(report: REPORT | spaceshipCurrentPosition: Starbase ==> report:=STARSHIP_IS_DOCKED_AT_STARBASE [] not(spaceshipCurrentPosition: Starbase) ==> report:=STARSHIP_IS_NOT_AT_STARBASE);
  Expanded_List_Substitution(Machine(Spaceship),MissionRoute)==(btrue | report:=spaceshipRoute);
  Expanded_List_Substitution(Machine(Spaceship),MissionStatus)==(btrue | location,power,collisions:=spaceshipCurrentPosition,spaceshipPower,noOfAsteroidCollisions);
  Expanded_List_Substitution(Machine(Spaceship),EngageWarpDrive)==(report: REPORT & xx: NAT1 & yy: NAT1 | GameNotOver: gameStatus ==> (spaceshipPower>=WarpDrivePowerConsumption ==> (xx|->yy: Grid & not(xx|->yy: Asteroids) & not(spaceshipCurrentPosition: Homebase & xx|->yy: Starbase) ==> (xx|->yy: Starbase ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=xx,yy,xx|->yy,spaceshipPower-WarpDrivePowerConsumption,spaceshipRoute^[xx|->yy],{GameWon},GAME_WON [] not(xx|->yy: Starbase) ==> (spaceshipPower-WarpDrivePowerConsumption>=NormalMovePowerConsumption ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=xx,yy,xx|->yy,spaceshipPower-WarpDrivePowerConsumption,spaceshipRoute^[xx|->yy],{GameNotOver},MOVEMENT_SUCCESSFUL [] not(spaceshipPower-WarpDrivePowerConsumption>=NormalMovePowerConsumption) ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=xx,yy,xx|->yy,spaceshipPower-WarpDrivePowerConsumption,spaceshipRoute^[xx|->yy],{GameLost},GAME_LOST)) [] not(xx|->yy: Grid & not(xx|->yy: Asteroids) & not(spaceshipCurrentPosition: Homebase & xx|->yy: Starbase)) ==> (spaceshipCurrentPosition: Homebase & xx|->yy: Starbase ==> report:=UNABLE_TO_DIRECTLY_WARP_TO_STARBASE [] not(spaceshipCurrentPosition: Homebase & xx|->yy: Starbase) ==> (xx|->yy: Asteroids ==> (spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameNotOver},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,WARP_DRIVE_FAILED_ASTEROID_COLLISION [] not(spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption) ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameLost},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,GAME_LOST) [] not(xx|->yy: Asteroids) ==> (not(xx|->yy: Grid) ==> report:=WARP_DRIVE_FAILED_OUT_OF_BOUND [] not(not(xx|->yy: Grid)) ==> report:=WARP_DRIVE_FAILED)))) [] not(spaceshipPower>=WarpDrivePowerConsumption) ==> report:=WARP_DRIVE_FAILED_INSUFFICIENT_POWER) [] not(GameNotOver: gameStatus) ==> (GameWon: gameStatus or GameLost: gameStatus ==> report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME [] not(GameWon: gameStatus or GameLost: gameStatus) ==> skip));
  Expanded_List_Substitution(Machine(Spaceship),MoveForward)==(report: REPORT | GameNotOver: gameStatus ==> (spaceshipPower>=NormalMovePowerConsumption ==> (succ(spaceshipX)|->spaceshipY: Grid & not(succ(spaceshipX)|->spaceshipY: Asteroids) ==> (succ(spaceshipX)|->spaceshipY: Starbase ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=succ(spaceshipX),spaceshipY,succ(spaceshipX)|->spaceshipY,spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[succ(spaceshipX)|->spaceshipY],{GameWon},GAME_WON [] not(succ(spaceshipX)|->spaceshipY: Starbase) ==> (spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=succ(spaceshipX),spaceshipY,succ(spaceshipX)|->spaceshipY,spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[succ(spaceshipX)|->spaceshipY],{GameNotOver},MOVEMENT_SUCCESSFUL [] not(spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption) ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=succ(spaceshipX),spaceshipY,succ(spaceshipX)|->spaceshipY,spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[succ(spaceshipX)|->spaceshipY],{GameLost},GAME_LOST)) [] not(succ(spaceshipX)|->spaceshipY: Grid & not(succ(spaceshipX)|->spaceshipY: Asteroids)) ==> (succ(spaceshipX)|->spaceshipY: Asteroids ==> (spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameNotOver},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,MOVEMENT_FAILED_ASTEROID_COLLISION [] not(spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption) ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameLost},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,GAME_LOST) [] not(succ(spaceshipX)|->spaceshipY: Asteroids) ==> (not(succ(spaceshipX)|->spaceshipY: Grid) ==> report:=MOVEMENT_FAILED_OUT_OF_BOUND [] not(not(succ(spaceshipX)|->spaceshipY: Grid)) ==> report:=MOVEMENT_FAILED))) [] not(spaceshipPower>=NormalMovePowerConsumption) ==> gameStatus,report:={GameLost},MOVEMENT_FAILED_INSUFFICIENT_POWER) [] not(GameNotOver: gameStatus) ==> (GameWon: gameStatus or GameLost: gameStatus ==> report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME [] not(GameWon: gameStatus or GameLost: gameStatus) ==> skip));
  Expanded_List_Substitution(Machine(Spaceship),MoveBackward)==(report: REPORT | GameNotOver: gameStatus ==> (spaceshipPower>=NormalMovePowerConsumption ==> (pred(spaceshipX)|->spaceshipY: Grid & not(pred(spaceshipX)|->spaceshipY: Asteroids) ==> (pred(spaceshipX)|->spaceshipY: Starbase ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=pred(spaceshipX),spaceshipY,pred(spaceshipX)|->spaceshipY,spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[pred(spaceshipX)|->spaceshipY],{GameWon},GAME_WON [] not(pred(spaceshipX)|->spaceshipY: Starbase) ==> (spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=pred(spaceshipX),spaceshipY,pred(spaceshipX)|->spaceshipY,spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[pred(spaceshipX)|->spaceshipY],{GameNotOver},MOVEMENT_SUCCESSFUL [] not(spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption) ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=pred(spaceshipX),spaceshipY,pred(spaceshipX)|->spaceshipY,spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[pred(spaceshipX)|->spaceshipY],{GameLost},GAME_LOST)) [] not(pred(spaceshipX)|->spaceshipY: Grid & not(pred(spaceshipX)|->spaceshipY: Asteroids)) ==> (pred(spaceshipX)|->spaceshipY: Asteroids ==> (spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameNotOver},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,MOVEMENT_FAILED_ASTEROID_COLLISION [] not(spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption) ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameLost},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,GAME_LOST) [] not(pred(spaceshipX)|->spaceshipY: Asteroids) ==> (not(pred(spaceshipX)|->spaceshipY: Grid) ==> report:=MOVEMENT_FAILED_OUT_OF_BOUND [] not(not(pred(spaceshipX)|->spaceshipY: Grid)) ==> report:=MOVEMENT_FAILED))) [] not(spaceshipPower>=NormalMovePowerConsumption) ==> gameStatus,report:={GameLost},MOVEMENT_FAILED_INSUFFICIENT_POWER) [] not(GameNotOver: gameStatus) ==> (GameWon: gameStatus or GameLost: gameStatus ==> report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME [] not(GameWon: gameStatus or GameLost: gameStatus) ==> skip));
  Expanded_List_Substitution(Machine(Spaceship),MoveDown)==(report: REPORT | GameNotOver: gameStatus ==> (spaceshipPower>=NormalMovePowerConsumption ==> (spaceshipX|->pred(spaceshipY): Grid & not(spaceshipX|->pred(spaceshipY): Asteroids) ==> (spaceshipX|->pred(spaceshipY): Starbase ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=spaceshipX,pred(spaceshipY),spaceshipX|->pred(spaceshipY),spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[spaceshipX|->pred(spaceshipY)],{GameWon},GAME_WON [] not(spaceshipX|->pred(spaceshipY): Starbase) ==> (spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=spaceshipX,pred(spaceshipY),spaceshipX|->pred(spaceshipY),spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[spaceshipX|->pred(spaceshipY)],{GameNotOver},MOVEMENT_SUCCESSFUL [] not(spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption) ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=spaceshipX,pred(spaceshipY),spaceshipX|->pred(spaceshipY),spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[spaceshipX|->pred(spaceshipY)],{GameLost},GAME_LOST)) [] not(spaceshipX|->pred(spaceshipY): Grid & not(spaceshipX|->pred(spaceshipY): Asteroids)) ==> (spaceshipX|->pred(spaceshipY): Asteroids ==> (spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameNotOver},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,MOVEMENT_FAILED_ASTEROID_COLLISION [] not(spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption) ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameLost},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,GAME_LOST) [] not(spaceshipX|->pred(spaceshipY): Asteroids) ==> (not(spaceshipX|->pred(spaceshipY): Grid) ==> report:=MOVEMENT_FAILED_OUT_OF_BOUND [] not(not(spaceshipX|->pred(spaceshipY): Grid)) ==> report:=MOVEMENT_FAILED))) [] not(spaceshipPower>=NormalMovePowerConsumption) ==> gameStatus,report:={GameLost},MOVEMENT_FAILED_INSUFFICIENT_POWER) [] not(GameNotOver: gameStatus) ==> (GameWon: gameStatus or GameLost: gameStatus ==> report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME [] not(GameWon: gameStatus or GameLost: gameStatus) ==> skip));
  Expanded_List_Substitution(Machine(Spaceship),MoveUp)==(report: REPORT | GameNotOver: gameStatus ==> (spaceshipPower>=NormalMovePowerConsumption ==> (spaceshipX|->succ(spaceshipY): Grid & not(spaceshipX|->succ(spaceshipY): Asteroids) ==> (spaceshipX|->succ(spaceshipY): Starbase ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=spaceshipX,succ(spaceshipY),spaceshipX|->succ(spaceshipY),spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[spaceshipX|->succ(spaceshipY)],{GameWon},GAME_WON [] not(spaceshipX|->succ(spaceshipY): Starbase) ==> (spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=spaceshipX,succ(spaceshipY),spaceshipX|->succ(spaceshipY),spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[spaceshipX|->succ(spaceshipY)],{GameNotOver},MOVEMENT_SUCCESSFUL [] not(spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption) ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,spaceshipPower,spaceshipRoute,gameStatus,report:=spaceshipX,succ(spaceshipY),spaceshipX|->succ(spaceshipY),spaceshipPower-NormalMovePowerConsumption,spaceshipRoute^[spaceshipX|->succ(spaceshipY)],{GameLost},GAME_LOST)) [] not(spaceshipX|->succ(spaceshipY): Grid & not(spaceshipX|->succ(spaceshipY): Asteroids)) ==> (spaceshipX|->succ(spaceshipY): Asteroids ==> (spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameNotOver},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,MOVEMENT_FAILED_ASTEROID_COLLISION [] not(spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption) ==> gameStatus,noOfAsteroidCollisions,spaceshipPower,report:={GameLost},noOfAsteroidCollisions+1,spaceshipPower-AsteroidCollisionPowerConsumption,GAME_LOST) [] not(spaceshipX|->succ(spaceshipY): Asteroids) ==> (not(spaceshipX|->succ(spaceshipY): Grid) ==> report:=MOVEMENT_FAILED_OUT_OF_BOUND [] not(not(spaceshipX|->succ(spaceshipY): Grid)) ==> report:=MOVEMENT_FAILED))) [] not(spaceshipPower>=NormalMovePowerConsumption) ==> gameStatus,report:={GameLost},MOVEMENT_FAILED_INSUFFICIENT_POWER) [] not(GameNotOver: gameStatus) ==> (GameWon: gameStatus or GameLost: gameStatus ==> report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME [] not(GameWon: gameStatus or GameLost: gameStatus) ==> skip));
  List_Substitution(Machine(Spaceship),MoveUp)==(IF GameNotOver: gameStatus THEN IF spaceshipPower>=NormalMovePowerConsumption THEN IF spaceshipX|->succ(spaceshipY): Grid & not(spaceshipX|->succ(spaceshipY): Asteroids) THEN IF spaceshipX|->succ(spaceshipY): Starbase THEN spaceshipX,spaceshipY:=spaceshipX,succ(spaceshipY) || spaceshipCurrentPosition:=spaceshipX|->succ(spaceshipY) || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[spaceshipX|->succ(spaceshipY)] || gameStatus:={GameWon} || report:=GAME_WON ELSE IF spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption THEN spaceshipX,spaceshipY:=spaceshipX,succ(spaceshipY) || spaceshipCurrentPosition:=spaceshipX|->succ(spaceshipY) || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[spaceshipX|->succ(spaceshipY)] || gameStatus:={GameNotOver} || report:=MOVEMENT_SUCCESSFUL ELSE spaceshipX,spaceshipY:=spaceshipX,succ(spaceshipY) || spaceshipCurrentPosition:=spaceshipX|->succ(spaceshipY) || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[spaceshipX|->succ(spaceshipY)] || gameStatus:={GameLost} || report:=GAME_LOST END END ELSIF spaceshipX|->succ(spaceshipY): Asteroids THEN IF spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption THEN gameStatus:={GameNotOver} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=MOVEMENT_FAILED_ASTEROID_COLLISION ELSE gameStatus:={GameLost} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=GAME_LOST END ELSIF not(spaceshipX|->succ(spaceshipY): Grid) THEN report:=MOVEMENT_FAILED_OUT_OF_BOUND ELSE report:=MOVEMENT_FAILED END ELSE gameStatus:={GameLost} || report:=MOVEMENT_FAILED_INSUFFICIENT_POWER END ELSIF GameWon: gameStatus or GameLost: gameStatus THEN report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME END);
  List_Substitution(Machine(Spaceship),MoveDown)==(IF GameNotOver: gameStatus THEN IF spaceshipPower>=NormalMovePowerConsumption THEN IF spaceshipX|->pred(spaceshipY): Grid & not(spaceshipX|->pred(spaceshipY): Asteroids) THEN IF spaceshipX|->pred(spaceshipY): Starbase THEN spaceshipX,spaceshipY:=spaceshipX,pred(spaceshipY) || spaceshipCurrentPosition:=spaceshipX|->pred(spaceshipY) || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[spaceshipX|->pred(spaceshipY)] || gameStatus:={GameWon} || report:=GAME_WON ELSE IF spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption THEN spaceshipX,spaceshipY:=spaceshipX,pred(spaceshipY) || spaceshipCurrentPosition:=spaceshipX|->pred(spaceshipY) || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[spaceshipX|->pred(spaceshipY)] || gameStatus:={GameNotOver} || report:=MOVEMENT_SUCCESSFUL ELSE spaceshipX,spaceshipY:=spaceshipX,pred(spaceshipY) || spaceshipCurrentPosition:=spaceshipX|->pred(spaceshipY) || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[spaceshipX|->pred(spaceshipY)] || gameStatus:={GameLost} || report:=GAME_LOST END END ELSIF spaceshipX|->pred(spaceshipY): Asteroids THEN IF spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption THEN gameStatus:={GameNotOver} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=MOVEMENT_FAILED_ASTEROID_COLLISION ELSE gameStatus:={GameLost} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=GAME_LOST END ELSIF not(spaceshipX|->pred(spaceshipY): Grid) THEN report:=MOVEMENT_FAILED_OUT_OF_BOUND ELSE report:=MOVEMENT_FAILED END ELSE gameStatus:={GameLost} || report:=MOVEMENT_FAILED_INSUFFICIENT_POWER END ELSIF GameWon: gameStatus or GameLost: gameStatus THEN report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME END);
  List_Substitution(Machine(Spaceship),MoveBackward)==(IF GameNotOver: gameStatus THEN IF spaceshipPower>=NormalMovePowerConsumption THEN IF pred(spaceshipX)|->spaceshipY: Grid & not(pred(spaceshipX)|->spaceshipY: Asteroids) THEN IF pred(spaceshipX)|->spaceshipY: Starbase THEN spaceshipX,spaceshipY:=pred(spaceshipX),spaceshipY || spaceshipCurrentPosition:=pred(spaceshipX)|->spaceshipY || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[pred(spaceshipX)|->spaceshipY] || gameStatus:={GameWon} || report:=GAME_WON ELSE IF spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption THEN spaceshipX,spaceshipY:=pred(spaceshipX),spaceshipY || spaceshipCurrentPosition:=pred(spaceshipX)|->spaceshipY || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[pred(spaceshipX)|->spaceshipY] || gameStatus:={GameNotOver} || report:=MOVEMENT_SUCCESSFUL ELSE spaceshipX,spaceshipY:=pred(spaceshipX),spaceshipY || spaceshipCurrentPosition:=pred(spaceshipX)|->spaceshipY || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[pred(spaceshipX)|->spaceshipY] || gameStatus:={GameLost} || report:=GAME_LOST END END ELSIF pred(spaceshipX)|->spaceshipY: Asteroids THEN IF spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption THEN gameStatus:={GameNotOver} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=MOVEMENT_FAILED_ASTEROID_COLLISION ELSE gameStatus:={GameLost} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=GAME_LOST END ELSIF not(pred(spaceshipX)|->spaceshipY: Grid) THEN report:=MOVEMENT_FAILED_OUT_OF_BOUND ELSE report:=MOVEMENT_FAILED END ELSE gameStatus:={GameLost} || report:=MOVEMENT_FAILED_INSUFFICIENT_POWER END ELSIF GameWon: gameStatus or GameLost: gameStatus THEN report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME END);
  List_Substitution(Machine(Spaceship),MoveForward)==(IF GameNotOver: gameStatus THEN IF spaceshipPower>=NormalMovePowerConsumption THEN IF succ(spaceshipX)|->spaceshipY: Grid & not(succ(spaceshipX)|->spaceshipY: Asteroids) THEN IF succ(spaceshipX)|->spaceshipY: Starbase THEN spaceshipX,spaceshipY:=succ(spaceshipX),spaceshipY || spaceshipCurrentPosition:=succ(spaceshipX)|->spaceshipY || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[succ(spaceshipX)|->spaceshipY] || gameStatus:={GameWon} || report:=GAME_WON ELSE IF spaceshipPower-NormalMovePowerConsumption>=NormalMovePowerConsumption THEN spaceshipX,spaceshipY:=succ(spaceshipX),spaceshipY || spaceshipCurrentPosition:=succ(spaceshipX)|->spaceshipY || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[succ(spaceshipX)|->spaceshipY] || gameStatus:={GameNotOver} || report:=MOVEMENT_SUCCESSFUL ELSE spaceshipX,spaceshipY:=succ(spaceshipX),spaceshipY || spaceshipCurrentPosition:=succ(spaceshipX)|->spaceshipY || spaceshipPower:=spaceshipPower-NormalMovePowerConsumption || spaceshipRoute:=spaceshipRoute^[succ(spaceshipX)|->spaceshipY] || gameStatus:={GameLost} || report:=GAME_LOST END END ELSIF succ(spaceshipX)|->spaceshipY: Asteroids THEN IF spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption THEN gameStatus:={GameNotOver} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=MOVEMENT_FAILED_ASTEROID_COLLISION ELSE gameStatus:={GameLost} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=GAME_LOST END ELSIF not(succ(spaceshipX)|->spaceshipY: Grid) THEN report:=MOVEMENT_FAILED_OUT_OF_BOUND ELSE report:=MOVEMENT_FAILED END ELSE gameStatus:={GameLost} || report:=MOVEMENT_FAILED_INSUFFICIENT_POWER END ELSIF GameWon: gameStatus or GameLost: gameStatus THEN report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME END);
  List_Substitution(Machine(Spaceship),EngageWarpDrive)==(IF GameNotOver: gameStatus THEN IF spaceshipPower>=WarpDrivePowerConsumption THEN IF xx|->yy: Grid & not(xx|->yy: Asteroids) & not(spaceshipCurrentPosition: Homebase & xx|->yy: Starbase) THEN IF xx|->yy: Starbase THEN spaceshipX,spaceshipY:=xx,yy || spaceshipCurrentPosition:=xx|->yy || spaceshipPower:=spaceshipPower-WarpDrivePowerConsumption || spaceshipRoute:=spaceshipRoute^[xx|->yy] || gameStatus:={GameWon} || report:=GAME_WON ELSE IF spaceshipPower-WarpDrivePowerConsumption>=NormalMovePowerConsumption THEN spaceshipX,spaceshipY:=xx,yy || spaceshipCurrentPosition:=xx|->yy || spaceshipPower:=spaceshipPower-WarpDrivePowerConsumption || spaceshipRoute:=spaceshipRoute^[xx|->yy] || gameStatus:={GameNotOver} || report:=MOVEMENT_SUCCESSFUL ELSE spaceshipX,spaceshipY:=xx,yy || spaceshipCurrentPosition:=xx|->yy || spaceshipPower:=spaceshipPower-WarpDrivePowerConsumption || spaceshipRoute:=spaceshipRoute^[xx|->yy] || gameStatus:={GameLost} || report:=GAME_LOST END END ELSIF spaceshipCurrentPosition: Homebase & xx|->yy: Starbase THEN report:=UNABLE_TO_DIRECTLY_WARP_TO_STARBASE ELSIF xx|->yy: Asteroids THEN IF spaceshipPower-AsteroidCollisionPowerConsumption>=NormalMovePowerConsumption THEN gameStatus:={GameNotOver} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=WARP_DRIVE_FAILED_ASTEROID_COLLISION ELSE gameStatus:={GameLost} || noOfAsteroidCollisions:=noOfAsteroidCollisions+1 || spaceshipPower:=spaceshipPower-AsteroidCollisionPowerConsumption || report:=GAME_LOST END ELSIF not(xx|->yy: Grid) THEN report:=WARP_DRIVE_FAILED_OUT_OF_BOUND ELSE report:=WARP_DRIVE_FAILED END ELSE report:=WARP_DRIVE_FAILED_INSUFFICIENT_POWER END ELSIF GameWon: gameStatus or GameLost: gameStatus THEN report:=GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME END);
  List_Substitution(Machine(Spaceship),MissionStatus)==(location:=spaceshipCurrentPosition || power:=spaceshipPower || collisions:=noOfAsteroidCollisions);
  List_Substitution(Machine(Spaceship),MissionRoute)==(report:=spaceshipRoute);
  List_Substitution(Machine(Spaceship),DockedAtStarbase)==(IF spaceshipCurrentPosition: Starbase THEN report:=STARSHIP_IS_DOCKED_AT_STARBASE ELSE report:=STARSHIP_IS_NOT_AT_STARBASE END);
  List_Substitution(Machine(Spaceship),GameStatus)==(IF GameWon: gameStatus THEN report:=GAME_WON ELSIF GameLost: gameStatus THEN report:=GAME_LOST ELSIF GameNotOver: gameStatus THEN report:=GAME_NOT_OVER END)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Spaceship))==(NormalMovePowerConsumption,WarpDrivePowerConsumption,AsteroidCollisionPowerConsumption);
  Inherited_List_Constants(Machine(Spaceship))==(?);
  List_Constants(Machine(Spaceship))==(NormalMovePowerConsumption,WarpDrivePowerConsumption,AsteroidCollisionPowerConsumption)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(Spaceship),REPORT)==({MOVEMENT_SUCCESSFUL,MOVEMENT_FAILED,MOVEMENT_FAILED_OUT_OF_BOUND,MOVEMENT_FAILED_ASTEROID_COLLISION,MOVEMENT_FAILED_INSUFFICIENT_POWER,WARP_DRIVE_SUCCESSFUL,WARP_DRIVE_FAILED,WARP_DRIVE_FAILED_OUT_OF_BOUND,WARP_DRIVE_FAILED_ASTEROID_COLLISION,WARP_DRIVE_FAILED_INSUFFICIENT_POWER,UNABLE_TO_DIRECTLY_WARP_TO_STARBASE,STARSHIP_IS_DOCKED_AT_STARBASE,STARSHIP_IS_NOT_AT_STARBASE,GAME_WON,GAME_LOST,GAME_NOT_OVER,GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME});
  Context_List_Enumerated(Machine(Spaceship))==(?);
  Context_List_Defered(Machine(Spaceship))==(?);
  Context_List_Sets(Machine(Spaceship))==(?);
  List_Valuable_Sets(Machine(Spaceship))==(?);
  Inherited_List_Enumerated(Machine(Spaceship))==(?);
  Inherited_List_Defered(Machine(Spaceship))==(?);
  Inherited_List_Sets(Machine(Spaceship))==(?);
  List_Enumerated(Machine(Spaceship))==(REPORT,STATUS);
  List_Defered(Machine(Spaceship))==(?);
  List_Sets(Machine(Spaceship))==(REPORT,STATUS);
  Set_Definition(Machine(Spaceship),STATUS)==({GameWon,GameLost,GameNotOver})
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(Spaceship))==(?);
  Expanded_List_HiddenConstants(Machine(Spaceship))==(?);
  List_HiddenConstants(Machine(Spaceship))==(?);
  External_List_HiddenConstants(Machine(Spaceship))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(Spaceship))==(btrue);
  Context_List_Properties(Machine(Spaceship))==(GridXRange <: NAT1 & GridXRange = 1..12 & GridYRange <: NAT1 & GridYRange = 1..7 & Grid: POW(NAT1*NAT1) & Grid = GridXRange*GridYRange & Asteroids: POW(NAT1*NAT1) & Asteroids = {7|->1,3|->2,11|->2,8|->3,5|->4,3|->5,7|->5,12|->5,10|->6,6|->7,7|->7} & Homebase: POW(NAT1*NAT1) & Homebase = {1|->1} & Starbase: POW(NAT1*NAT1) & Starbase = {6|->4});
  Inherited_List_Properties(Machine(Spaceship))==(btrue);
  List_Properties(Machine(Spaceship))==(NormalMovePowerConsumption: NAT1 & NormalMovePowerConsumption = 5 & WarpDrivePowerConsumption: NAT1 & WarpDrivePowerConsumption = 20 & AsteroidCollisionPowerConsumption: NAT1 & AsteroidCollisionPowerConsumption = 10 & REPORT: FIN(INTEGER) & not(REPORT = {}) & STATUS: FIN(INTEGER) & not(STATUS = {}))
END
&
THEORY ListSeenInfoX IS
  Seen_Internal_List_Operations(Machine(Spaceship),Machine(Space))==(?);
  Seen_Context_List_Enumerated(Machine(Spaceship))==(?);
  Seen_Context_List_Invariant(Machine(Spaceship))==(btrue);
  Seen_Context_List_Assertions(Machine(Spaceship))==(btrue);
  Seen_Context_List_Properties(Machine(Spaceship))==(btrue);
  Seen_List_Constraints(Machine(Spaceship))==(btrue);
  Seen_List_Operations(Machine(Spaceship),Machine(Space))==(?);
  Seen_Expanded_List_Invariant(Machine(Spaceship),Machine(Space))==(btrue)
END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(Spaceship),MoveUp)==(?);
  List_ANY_Var(Machine(Spaceship),MoveDown)==(?);
  List_ANY_Var(Machine(Spaceship),MoveBackward)==(?);
  List_ANY_Var(Machine(Spaceship),MoveForward)==(?);
  List_ANY_Var(Machine(Spaceship),EngageWarpDrive)==(?);
  List_ANY_Var(Machine(Spaceship),MissionStatus)==(?);
  List_ANY_Var(Machine(Spaceship),MissionRoute)==(?);
  List_ANY_Var(Machine(Spaceship),DockedAtStarbase)==(?);
  List_ANY_Var(Machine(Spaceship),GameStatus)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(Spaceship)) == (NormalMovePowerConsumption,WarpDrivePowerConsumption,AsteroidCollisionPowerConsumption,REPORT,STATUS,MOVEMENT_SUCCESSFUL,MOVEMENT_FAILED,MOVEMENT_FAILED_OUT_OF_BOUND,MOVEMENT_FAILED_ASTEROID_COLLISION,MOVEMENT_FAILED_INSUFFICIENT_POWER,WARP_DRIVE_SUCCESSFUL,WARP_DRIVE_FAILED,WARP_DRIVE_FAILED_OUT_OF_BOUND,WARP_DRIVE_FAILED_ASTEROID_COLLISION,WARP_DRIVE_FAILED_INSUFFICIENT_POWER,UNABLE_TO_DIRECTLY_WARP_TO_STARBASE,STARSHIP_IS_DOCKED_AT_STARBASE,STARSHIP_IS_NOT_AT_STARBASE,GAME_WON,GAME_LOST,GAME_NOT_OVER,GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME,GameWon,GameLost,GameNotOver | ? | gameStatus,spaceshipRoute,spaceshipCurrentPosition,noOfAsteroidCollisions,spaceshipPower,spaceshipY,spaceshipX | ? | MoveUp,MoveDown,MoveBackward,MoveForward,EngageWarpDrive,MissionStatus,MissionRoute,DockedAtStarbase,GameStatus | ? | seen(Machine(Space)) | ? | Spaceship);
  List_Of_HiddenCst_Ids(Machine(Spaceship)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Spaceship)) == (NormalMovePowerConsumption,WarpDrivePowerConsumption,AsteroidCollisionPowerConsumption);
  List_Of_VisibleVar_Ids(Machine(Spaceship)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Spaceship)) == (?: ?);
  List_Of_Ids(Machine(Space)) == (GridXRange,GridYRange,Grid,Homebase,Starbase,Asteroids | ? | ? | ? | ? | ? | ? | ? | Space);
  List_Of_HiddenCst_Ids(Machine(Space)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Space)) == (GridXRange,GridYRange,Grid,Homebase,Starbase,Asteroids);
  List_Of_VisibleVar_Ids(Machine(Space)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Space)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(Spaceship)) == (Type(REPORT) == Cst(SetOf(etype(REPORT,0,16)));Type(STATUS) == Cst(SetOf(etype(STATUS,0,2))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(Spaceship)) == (Type(MOVEMENT_SUCCESSFUL) == Cst(etype(REPORT,0,16));Type(MOVEMENT_FAILED) == Cst(etype(REPORT,0,16));Type(MOVEMENT_FAILED_OUT_OF_BOUND) == Cst(etype(REPORT,0,16));Type(MOVEMENT_FAILED_ASTEROID_COLLISION) == Cst(etype(REPORT,0,16));Type(MOVEMENT_FAILED_INSUFFICIENT_POWER) == Cst(etype(REPORT,0,16));Type(WARP_DRIVE_SUCCESSFUL) == Cst(etype(REPORT,0,16));Type(WARP_DRIVE_FAILED) == Cst(etype(REPORT,0,16));Type(WARP_DRIVE_FAILED_OUT_OF_BOUND) == Cst(etype(REPORT,0,16));Type(WARP_DRIVE_FAILED_ASTEROID_COLLISION) == Cst(etype(REPORT,0,16));Type(WARP_DRIVE_FAILED_INSUFFICIENT_POWER) == Cst(etype(REPORT,0,16));Type(UNABLE_TO_DIRECTLY_WARP_TO_STARBASE) == Cst(etype(REPORT,0,16));Type(STARSHIP_IS_DOCKED_AT_STARBASE) == Cst(etype(REPORT,0,16));Type(STARSHIP_IS_NOT_AT_STARBASE) == Cst(etype(REPORT,0,16));Type(GAME_WON) == Cst(etype(REPORT,0,16));Type(GAME_LOST) == Cst(etype(REPORT,0,16));Type(GAME_NOT_OVER) == Cst(etype(REPORT,0,16));Type(GAME_ALREADY_ENDED_PLEASE_START_A_NEW_GAME) == Cst(etype(REPORT,0,16));Type(GameWon) == Cst(etype(STATUS,0,2));Type(GameLost) == Cst(etype(STATUS,0,2));Type(GameNotOver) == Cst(etype(STATUS,0,2));Type(NormalMovePowerConsumption) == Cst(btype(INTEGER,?,?));Type(WarpDrivePowerConsumption) == Cst(btype(INTEGER,?,?));Type(AsteroidCollisionPowerConsumption) == Cst(btype(INTEGER,?,?)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(Spaceship)) == (Type(gameStatus) == Mvl(SetOf(etype(STATUS,?,?)));Type(spaceshipRoute) == Mvl(SetOf(btype(INTEGER,?,?)*(btype(INTEGER,?,?)*btype(INTEGER,?,?))));Type(spaceshipCurrentPosition) == Mvl(btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(noOfAsteroidCollisions) == Mvl(btype(INTEGER,?,?));Type(spaceshipPower) == Mvl(btype(INTEGER,?,?));Type(spaceshipY) == Mvl(btype(INTEGER,?,?));Type(spaceshipX) == Mvl(btype(INTEGER,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(Spaceship)) == (Type(GameStatus) == Cst(etype(REPORT,?,?),No_type);Type(DockedAtStarbase) == Cst(etype(REPORT,?,?),No_type);Type(MissionRoute) == Cst(SetOf(btype(INTEGER,?,?)*(btype(INTEGER,?,?)*btype(INTEGER,?,?))),No_type);Type(MissionStatus) == Cst(btype(INTEGER,?,?)*btype(INTEGER,?,?)*btype(INTEGER,?,?)*btype(INTEGER,?,?),No_type);Type(EngageWarpDrive) == Cst(etype(REPORT,?,?),btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(MoveForward) == Cst(etype(REPORT,?,?),No_type);Type(MoveBackward) == Cst(etype(REPORT,?,?),No_type);Type(MoveDown) == Cst(etype(REPORT,?,?),No_type);Type(MoveUp) == Cst(etype(REPORT,?,?),No_type));
  Observers(Machine(Spaceship)) == (Type(GameStatus) == Cst(etype(REPORT,?,?),No_type);Type(DockedAtStarbase) == Cst(etype(REPORT,?,?),No_type);Type(MissionRoute) == Cst(SetOf(btype(INTEGER,?,?)*(btype(INTEGER,?,?)*btype(INTEGER,?,?))),No_type);Type(MissionStatus) == Cst(btype(INTEGER,?,?)*btype(INTEGER,?,?)*btype(INTEGER,?,?)*btype(INTEGER,?,?),No_type))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)
