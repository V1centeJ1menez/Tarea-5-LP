% Definición del grafo: puentes entre planetas con el costo de combustible.
puente(p1, c, 4).
puente(p1, p4, 1).
puente(p2, p1, 3).
puente(p2, p3, 7).
puente(p3, c, 2).
puente(p4, c, 3).
puente(p5, p1, 7).
puente(p6, p2, 2).
puente(p7, p6, 4).
puente(p7, p2, 3).
puente(p8, p3, 8).
puente(p8, p9, 3).
puente(p9, p10, 10).
puente(p10, p3, 3).
puente(p10, p4, 6).
puente(p11, p4, 7).
puente(p11, p12, 3).
puente(p12, p5, 2).

% Predicado camino/2: Encuentra un camino desde el planeta S hasta el centro c.
camino(S, [S|Camino]) :-
    camino_aux(S, c, [S], Camino).

% Predicado auxiliar camino_aux/4 con control de visitados para evitar ciclos.
camino_aux(Actual, Destino, _Visitados, [Destino]) :-
    puente(Actual, Destino, _).

camino_aux(Actual, Destino, Visitados, [Siguiente|Camino]) :-
    puente(Actual, Siguiente, _),
    \+ member(Siguiente, Visitados),
    camino_aux(Siguiente, Destino, [Siguiente|Visitados], Camino).

% Predicado combustible/3: Encuentra un camino de S a c con un combustible inicial V.
combustible(S, V, [[S, V]|CaminoConCombustible]) :-
    combustible_aux(S, c, V, [S], CaminoConCombustible).

% Predicado auxiliar combustible_aux/5, control de visitados y combustible.
combustible_aux(Actual, Destino, Combustible, _Visitados, [[Destino, RestoCombustible]]) :-
    puente(Actual, Destino, Costo),
    RestoCombustible is Combustible - Costo,
    RestoCombustible >= 0.

combustible_aux(Actual, Destino, Combustible, Visitados, [[Siguiente, NuevoCombustible]|Camino]) :-
    puente(Actual, Siguiente, Costo),
    NuevoCombustible is Combustible - Costo,
    NuevoCombustible >= 0,
    \+ member(Siguiente, Visitados),
    combustible_aux(Siguiente, Destino, NuevoCombustible, [Siguiente|Visitados], Camino).
