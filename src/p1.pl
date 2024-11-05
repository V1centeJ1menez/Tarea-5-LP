% esPalindroma(Lista, [L, R]) es cierto si el subsegmento de Lista desde el índice L hasta el índice R es un palíndromo.
% Lista: La lista original que se examina.
% [L, R]: Los índices de inicio (L) y fin (R) del subsegmento en Lista que queremos verificar.
% Este predicado utiliza el sub_predicado sub_segmento/4 para extraer el subsegmento especificado 
% y luego verifica si dicho subsegmento es un palíndromo usando es_palindromo/1.
esPalindroma(Lista, [L, R]) :-
    sub_segmento(Lista, L, R, SubLista),  % Extrae el subsegmento de Lista entre los índices L y R en SubLista.
    es_palindromo(SubLista).              % Verifica si el subsegmento (SubLista) es un palíndromo.

% sub_segmento(Lista, L, R, SubLista) es cierto si SubLista es el segmento de Lista desde el índice L hasta el índice R.
% Lista: La lista original de la que se extrae el subsegmento.
% L: El índice inicial del subsegmento.
% R: El índice final del subsegmento.
% SubLista: El subsegmento extraído desde L hasta R en Lista.
% Este predicado divide la lista original en un prefijo, el subsegmento de interés (SubLista), y el resto.
sub_segmento(Lista, L, R, SubLista) :-
    Inicio is L - 1,                      % Calcula el número de elementos antes del índice L (Prolog usa índice basado en 1).
    Longitud is R - L + 1,                % Calcula la longitud del subsegmento entre L y R (incluyendo ambos extremos).
    length(Prefix, Inicio),               % Crea una lista Prefix de longitud 'Inicio' para representar los elementos antes del subsegmento.
    append(Prefix, Rest, Lista),          % Divide Lista en dos partes: Prefix (hasta L-1) y Rest (desde L en adelante).
    length(SubLista, Longitud),           % Define SubLista con la longitud calculada entre L y R.
    append(SubLista, _, Rest).            % Divide Rest en SubLista (el subsegmento deseado) y una parte ignorada (_) después de R.

% es_palindromo(Lista) es cierto si Lista es igual a su reverso, es decir, si es un palíndromo.
% Lista: La lista que se va a verificar si es palíndroma.
% Este predicado utiliza el predicado predefinido reverse/2 para invertir la lista y compara 
% si el resultado es igual a la lista original.
es_palindromo(Lista) :-
    reverse(Lista, Lista).                % Verifica si Lista es igual a su reverso. True si es palíndroma, false si no.
