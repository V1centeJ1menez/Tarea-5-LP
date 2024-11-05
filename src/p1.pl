% esPalindroma(Lista, [L, R]) es cierto si el subsegmento de Lista desde el índice L hasta el índice R es palíndromo.
esPalindroma(Lista, [L, R]) :-
    sub_segmento(Lista, L, R, SubLista),
    es_palindromo(SubLista).

% sub_segmento(Lista, L, R, SubLista) es cierto si SubLista es el segmento de Lista desde el índice L hasta el índice R.
sub_segmento(Lista, L, R, SubLista) :-
    Inicio is L - 1,
    Longitud is R - L + 1,
    length(Prefix, Inicio),
    append(Prefix, Rest, Lista),
    length(SubLista, Longitud),
    append(SubLista, _, Rest).

% es_palindromo(Lista) es cierto si Lista es igual a su reverso.
es_palindromo(Lista) :-
    reverse(Lista, Lista).
