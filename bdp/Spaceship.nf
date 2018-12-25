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
  Local_List_Variables(Machine(Spaceship))==(spaceshipMovements,spaceshipRoute,spaceshipCurrentPosition,noOfMovements,visitedRegions,spaceshipPower,spaceshipY,spaceshipX);
  List_Variables(Machine(Spaceship))==(spaceshipMovements,spaceshipRoute,spaceshipCurrentPosition,noOfMovements,visitedRegions,spaceshipPower,spaceshipY,spaceshipX);
  External_List_Variables(Machine(Spaceship))==(spaceshipMovements,spaceshipRoute,spaceshipCurrentPosition,noOfMovements,visitedRegions,spaceshipPower,spaceshipY,spaceshipX)
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
  List_Invariant(Machine(Spaceship))==(spaceshipX: GridXRange & spaceshipY: GridYRange & spaceshipPower: NAT & visitedRegions <: Grid & noOfMovements: NAT & spaceshipCurrentPosition: Grid & spaceshipRoute: seq(Grid) & spaceshipMovements: seq(MOVEMENTS))
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
  Expanded_List_Initialisation(Machine(Spaceship))==(spaceshipX,spaceshipY,spaceshipPower,visitedRegions,noOfMovements,spaceshipCurrentPosition,spaceshipRoute,spaceshipMovements:=1,1,30,{},0,1|->1,[1|->1],<>);
  Context_List_Initialisation(Machine(Spaceship))==(skip);
  List_Initialisation(Machine(Spaceship))==(spaceshipX:=1 || spaceshipY:=1 || spaceshipPower:=30 || visitedRegions:={} || noOfMovements:=0 || spaceshipCurrentPosition:=1|->1 || spaceshipRoute:=[1|->1] || spaceshipMovements:=<>)
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
  Internal_List_Operations(Machine(Spaceship))==(MoveUpwards);
  List_Operations(Machine(Spaceship))==(MoveUpwards)
END
&
THEORY ListInputX IS
  List_Input(Machine(Spaceship),MoveUpwards)==(?)
END
&
THEORY ListOutputX IS
  List_Output(Machine(Spaceship),MoveUpwards)==(report)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(Spaceship),MoveUpwards)==(report <-- MoveUpwards)
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(Spaceship),MoveUpwards)==(report: REPORT)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(Spaceship),MoveUpwards)==(report: REPORT | spaceshipX|->succ(spaceshipY): Grid & not(spaceshipX|->succ(spaceshipY): Asteroids) ==> spaceshipX,spaceshipY,spaceshipCurrentPosition,noOfMovements,visitedRegions,spaceshipRoute,spaceshipMovements,report:=spaceshipX,succ(spaceshipY),spaceshipX|->spaceshipY,noOfMovements+1,visitedRegions\/{spaceshipX|->succ(spaceshipY)},spaceshipRoute^[spaceshipX|->succ(spaceshipY)],spaceshipMovements^[Up],Movement_Successful [] not(spaceshipX|->succ(spaceshipY): Grid & not(spaceshipX|->succ(spaceshipY): Asteroids)) ==> (spaceshipX|->succ(spaceshipY): Asteroids ==> spaceshipPower,report:=spaceshipPower-10,Movement_Failed_Asteroid_Collision [] not(spaceshipX|->succ(spaceshipY): Asteroids) ==> (not(spaceshipX|->succ(spaceshipY): Grid) ==> report:=Movement_failed_out_of_bound [] not(not(spaceshipX|->succ(spaceshipY): Grid)) ==> skip)));
  List_Substitution(Machine(Spaceship),MoveUpwards)==(IF spaceshipX|->succ(spaceshipY): Grid & not(spaceshipX|->succ(spaceshipY): Asteroids) THEN spaceshipX,spaceshipY:=spaceshipX,succ(spaceshipY) || spaceshipCurrentPosition:=spaceshipX|->spaceshipY || noOfMovements:=noOfMovements+1 || visitedRegions:=visitedRegions\/{spaceshipX|->succ(spaceshipY)} || spaceshipRoute:=spaceshipRoute^[spaceshipX|->succ(spaceshipY)] || spaceshipMovements:=spaceshipMovements^[Up] || report:=Movement_Successful ELSIF spaceshipX|->succ(spaceshipY): Asteroids THEN spaceshipPower:=spaceshipPower-10 || report:=Movement_Failed_Asteroid_Collision ELSIF not(spaceshipX|->succ(spaceshipY): Grid) THEN report:=Movement_failed_out_of_bound END)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Spaceship))==(?);
  Inherited_List_Constants(Machine(Spaceship))==(?);
  List_Constants(Machine(Spaceship))==(?)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(Spaceship),REPORT)==({Movement_Successful,Movement_failed_out_of_bound,Movement_Failed_Asteroid_Collision,Movement_Failed_Insufficient_Power,Warp_Drive_Successful,Warp_Drive_Failed_Out_Of_Bound,Warp_Drive_Failed_Asteroid_Collision,Warp_Drive_Failed_Insufficient_Power,Can_Not_Warp_To_Starbase,Starship_Docked,Game_Won,Game_Lost,Game_Not_Over});
  Context_List_Enumerated(Machine(Spaceship))==(?);
  Context_List_Defered(Machine(Spaceship))==(?);
  Context_List_Sets(Machine(Spaceship))==(?);
  List_Valuable_Sets(Machine(Spaceship))==(?);
  Inherited_List_Enumerated(Machine(Spaceship))==(?);
  Inherited_List_Defered(Machine(Spaceship))==(?);
  Inherited_List_Sets(Machine(Spaceship))==(?);
  List_Enumerated(Machine(Spaceship))==(REPORT,MOVEMENTS);
  List_Defered(Machine(Spaceship))==(?);
  List_Sets(Machine(Spaceship))==(REPORT,MOVEMENTS);
  Set_Definition(Machine(Spaceship),MOVEMENTS)==({Up,Down,Left,Right,WarpDrive})
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
  List_Properties(Machine(Spaceship))==(REPORT: FIN(INTEGER) & not(REPORT = {}) & MOVEMENTS: FIN(INTEGER) & not(MOVEMENTS = {}))
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
  List_ANY_Var(Machine(Spaceship),MoveUpwards)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(Spaceship)) == (REPORT,MOVEMENTS,Movement_Successful,Movement_failed_out_of_bound,Movement_Failed_Asteroid_Collision,Movement_Failed_Insufficient_Power,Warp_Drive_Successful,Warp_Drive_Failed_Out_Of_Bound,Warp_Drive_Failed_Asteroid_Collision,Warp_Drive_Failed_Insufficient_Power,Can_Not_Warp_To_Starbase,Starship_Docked,Game_Won,Game_Lost,Game_Not_Over,Up,Down,Left,Right,WarpDrive | ? | spaceshipMovements,spaceshipRoute,spaceshipCurrentPosition,noOfMovements,visitedRegions,spaceshipPower,spaceshipY,spaceshipX | ? | MoveUpwards | ? | seen(Machine(Space)) | ? | Spaceship);
  List_Of_HiddenCst_Ids(Machine(Spaceship)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Spaceship)) == (?);
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
  Sets(Machine(Spaceship)) == (Type(REPORT) == Cst(SetOf(etype(REPORT,0,12)));Type(MOVEMENTS) == Cst(SetOf(etype(MOVEMENTS,0,4))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(Spaceship)) == (Type(Movement_Successful) == Cst(etype(REPORT,0,12));Type(Movement_failed_out_of_bound) == Cst(etype(REPORT,0,12));Type(Movement_Failed_Asteroid_Collision) == Cst(etype(REPORT,0,12));Type(Movement_Failed_Insufficient_Power) == Cst(etype(REPORT,0,12));Type(Warp_Drive_Successful) == Cst(etype(REPORT,0,12));Type(Warp_Drive_Failed_Out_Of_Bound) == Cst(etype(REPORT,0,12));Type(Warp_Drive_Failed_Asteroid_Collision) == Cst(etype(REPORT,0,12));Type(Warp_Drive_Failed_Insufficient_Power) == Cst(etype(REPORT,0,12));Type(Can_Not_Warp_To_Starbase) == Cst(etype(REPORT,0,12));Type(Starship_Docked) == Cst(etype(REPORT,0,12));Type(Game_Won) == Cst(etype(REPORT,0,12));Type(Game_Lost) == Cst(etype(REPORT,0,12));Type(Game_Not_Over) == Cst(etype(REPORT,0,12));Type(Up) == Cst(etype(MOVEMENTS,0,4));Type(Down) == Cst(etype(MOVEMENTS,0,4));Type(Left) == Cst(etype(MOVEMENTS,0,4));Type(Right) == Cst(etype(MOVEMENTS,0,4));Type(WarpDrive) == Cst(etype(MOVEMENTS,0,4)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(Spaceship)) == (Type(spaceshipMovements) == Mvl(SetOf(btype(INTEGER,?,?)*etype(MOVEMENTS,?,?)));Type(spaceshipRoute) == Mvl(SetOf(btype(INTEGER,?,?)*(btype(INTEGER,?,?)*btype(INTEGER,?,?))));Type(spaceshipCurrentPosition) == Mvl(btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(noOfMovements) == Mvl(btype(INTEGER,?,?));Type(visitedRegions) == Mvl(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)));Type(spaceshipPower) == Mvl(btype(INTEGER,?,?));Type(spaceshipY) == Mvl(btype(INTEGER,?,?));Type(spaceshipX) == Mvl(btype(INTEGER,?,?)))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(Spaceship)) == (Type(MoveUpwards) == Cst(etype(REPORT,?,?),No_type))
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
