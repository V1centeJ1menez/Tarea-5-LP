% Definición del grafo: puentes entre planetas con el costo de combustible.
% Cada predicado puente/3 representa una conexión entre dos planetas con un costo asociado.
% puente(PlanetaOrigen, PlanetaDestino, Costo): Existe un puente entre PlanetaOrigen y PlanetaDestino con el costo de combustible especificado.
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
% S: El planeta de inicio.
% [S|Camino]: La lista completa de planetas en la ruta hacia el centro c, incluyendo el planeta de inicio.
% Este predicado usa el predicado auxiliar camino_aux/4 para construir la lista de planetas que llevan al destino.
camino(S, [S|Camino]) :-
    camino_aux(S, c, [S], Camino).

% Predicado auxiliar camino_aux/4 con control de visitados para evitar ciclos.
% Actual: El planeta actual en el recorrido.
% Destino: El planeta de destino, en este caso 'c'.
% Visitados: Lista de planetas ya visitados en el recorrido, para evitar ciclos.
% [Destino]: Si el planeta actual (Actual) está conectado directamente con el destino, se completa el camino.
camino_aux(Actual, Destino, _Visitados, [Destino]) :-
    puente(Actual, Destino, _).

% camino_aux/4: Si no se ha alcanzado el destino, se busca un planeta siguiente para continuar el camino.
% puente(Actual, Siguiente, _): Encuentra un puente entre el planeta Actual y un siguiente planeta (Siguiente).
% \+ member(Siguiente, Visitados): Asegura que el siguiente planeta no haya sido visitado, evitando ciclos.
% camino_aux(Siguiente, Destino, [Siguiente|Visitados], Camino): Continua buscando el camino desde Siguiente al Destino.
camino_aux(Actual, Destino, Visitados, [Siguiente|Camino]) :-
    puente(Actual, Siguiente, _),
    \+ member(Siguiente, Visitados),
    camino_aux(Siguiente, Destino, [Siguiente|Visitados], Camino).

% Predicado combustible/3: Encuentra un camino de S a c, manteniendo el seguimiento del combustible restante.
% S: Planeta de inicio.
% V: Cantidad inicial de combustible disponible.
% [[S, V]|CaminoConCombustible]: Lista de pares [Planeta, CombustibleRestante] en el recorrido hacia el centro c.
% Este predicado usa el predicado auxiliar combustible_aux/5 para construir la ruta considerando el combustible.
combustible(S, V, [[S, V]|CaminoConCombustible]) :-
    combustible_aux(S, c, V, [S], CaminoConCombustible).

% Predicado auxiliar combustible_aux/5, controla visitados y combustible en cada paso.
% Actual: Planeta actual en el recorrido.
% Destino: Planeta de destino (c).
% Combustible: Cantidad de combustible disponible en el planeta actual.
% Visitados: Lista de planetas ya visitados.
% [[Destino, RestoCombustible]]: Si hay conexión directa entre Actual y Destino, calcula el combustible restante y verifica que sea >= 0.
combustible_aux(Actual, Destino, Combustible, _Visitados, [[Destino, RestoCombustible]]) :-
    puente(Actual, Destino, Costo),
    RestoCombustible is Combustible - Costo,
    RestoCombustible >= 0.

% Si no hay conexión directa al destino, se busca un puente intermedio (Siguiente) para continuar.
% NuevoCombustible: Calcula el combustible restante tras recorrer el puente al siguiente planeta.
% \+ member(Siguiente, Visitados): Asegura que Siguiente no haya sido visitado, evitando ciclos.
% combustible_aux(Siguiente, Destino, NuevoCombustible, [Siguiente|Visitados], Camino): Continúa la búsqueda con el combustible restante.
combustible_aux(Actual, Destino, Combustible, Visitados, [[Siguiente, NuevoCombustible]|Camino]) :-
    puente(Actual, Siguiente, Costo),
    NuevoCombustible is Combustible - Costo,
    NuevoCombustible >= 0,
    \+ member(Siguiente, Visitados),
    combustible_aux(Siguiente, Destino, NuevoCombustible, [Siguiente|Visitados], Camino).
