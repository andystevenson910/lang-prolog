% Base case, empty list, do nothing
printList([]).

%other cases
printList([H | T]) :-
    write(H), nl,
    printList(T).

% Check if X is a member of the list.
member(X, [X|_]).
member(X, [_|T]) :-
    member(X, T).

% Start the search from 'enter', and then use dfs to explore.
solveRooms(Castle, RequiredRooms) :-
    dfs(Castle, enter, RequiredRooms, [], Path),
    reverse(Path, ReversedPath), % To print the path in correct order
    printList(ReversedPath),!.

% Base Case: When reaching 'exit', check if we''ve visited all required rooms.
dfs(_, exit, [], Visited, [exit|Visited]).

% Recursive Case: 
% If we''re in a room and it''s in our required list, then select it from the list.
dfs(Castle, Room, Required, Visited, Path) :-
    \+ member(Room, Visited),
    room(Castle, Room, NextRoom, _),
    select(Room, Required, NewRequired),
    dfs(Castle, NextRoom, NewRequired, [Room|Visited], Path).

% If the room is not required, don't remove it from the required list.
dfs(Castle, Room, Required, Visited, Path) :-
    \+ member(Room, Visited),
    room(Castle, Room, NextRoom, _),
    dfs(Castle, NextRoom, Required, [Room|Visited], Path).

%%%%%%
% Base case: When reaching 'exit', print the path if the current cost is within the limit.
dfs_cost(_, exit, CurrentCost, Limit, Visited, [exit|Visited]) :-
    CurrentCost =< Limit,
    write('Cost is '), write(CurrentCost), write(' within limit of '), write(Limit), nl.

% Recursive case:
% If we're in a room, add the cost of the room to the current cost, then proceed if it doesn't exceed the limit.
dfs_cost(Castle, Room, CurrentCost, Limit, Visited, Path) :-
    \+ member(Room, Visited),
    room(Castle, Room, NextRoom, RoomCost),
    NewCost is CurrentCost + RoomCost,
    NewCost =< Limit,
    dfs_cost(Castle, NextRoom, NewCost, Limit, [Room|Visited], Path).

solveRoomsWithinCost(Castle, Limit) :- 
    dfs_cost(Castle, enter, 0, Limit, [], Path),
    reverse(Path, ReversedPath), % To print the path in correct order
    printList(ReversedPath),!.


