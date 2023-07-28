1
)
SELECT *
FROM coureurs
WHERE codepays is NULL;
2
)
SELECT COUNT(*) as coureurs,
    COUNT(codepays) as coureurs_avec_pays
FROM coureurs;
3
)
SELECT t.numerocoureur,
    c.nomcoureur,
    t.numeroetape
FROM coureurs as c,
    temps as t
WHERE t.numerocoureur = c.numerocoureur
ORDER BY t.numeroetape;
4
)
SELECT COUNT(*)
FROM coureurs;
5
)
SELECT AVG(t.tempsrealise) as "temps moyen",
    SUM(DISTINCT e.nbKm) as "nombre total de kms"
FROM etapes as e,
    temps as t
WHERE t.numerocoureur = 31;
6
)
SELECT *
FROM etapes
WHERE etapes.nbKm >= (
        SELECT max(nbKm)
        FROM etapes
    );
7
)
SELECT c.nomcoureur
FROM coureurs as c,
    temps as t
WHERE t.numeroetape = 2
    and c.numerocoureur = t.numerocoureur
    and t.tempsrealise <= (
        SELECT min(tempsrealise)
        FROM temps
        WHERE temps.numeroetape = 2
    );
8
) kk
SELECT c.nomcoureur,
    round(e.nbKm / t.tempsrealise) as "vitesse moyenne"
FROM coureurs as c,
    etapes as e,
    temps as t
WHERE c.numerocoureur = t.numerocoureur
    and t.numeroetape = e.numeroetape
    and e.numeroetape = 4
ORDER BY "vitesse moyenne";
9
)
SELECT ROUND(
        AVG(
            2023 - EXTRACT(
                'Year'
                FROM dateNaiss
            )
        )
    ) as "age moyen"
FROM coureurs;
10
)
SELECT COUNT(*)
FROM coureurs
WHERE (
        2023 - EXTRACT(
            'Year'
            FROM dateNaiss
        )
    ) > (
        SELECT ROUND(
                AVG(
                    2023 - EXTRACT(
                        'Year'
                        FROM dateNaiss
                    )
                )
            ) as "age moyen"
        FROM coureurs
    );
11
)
SELECT codeequipe,
    COUNT(*)
FROM coureurs
GROUP BY codeequipe;
12
)
SELECT c.codeequipe,
    e.nomequipe,
    COUNT(*)
FROM coureurs as c,
    equipestour as e
WHERE c.codeequipe = e.codeequipe
GROUP BY c.codeequipe,
    e.nomequipe;
13
)
SELECT DISTINCT c.codeequipe,
    t.tempsrealise
FROM coureurs as c,
    temps as t
WHERE c.numerocoureur = t.numerocoureur
    and t.numeroetape = 2
    and t.tempsrealise = (
        SELECT MAX(y.tempsrealise)
        FROM temps as y,
            coureurs as P
        WHERE c.codeequipe = P.codeequipe
            and y.numerocoureur = P.numerocoureur
    );
14
)
SELECT DISTINCT c.codeequipe,
    t.tempsrealise
FROM coureurs as c,
    temps as t
WHERE c.numerocoureur = t.numerocoureur
    and t.numeroetape = (
        SELECT numeroEtape
        FROM etapes
        WHERE nbKm = (
                SELECT MIN(nbKm)
                FROM etapes
            )
    )
    and t.tempsrealise = (
        SELECT MIN(y.tempsrealise)
        FROM temps as y,
            coureurs as P
        WHERE c.codeequipe = P.codeequipe
            and y.numerocoureur = P.numerocoureur
    );
15
)
SELECT DISTINCT t.numeroetape,
    c.codeequipe,
    t.tempsrealise as "min"
FROM coureurs as c,
    temps as t
WHERE c.numerocoureur = t.numerocoureur
    and t.tempsrealise = (
        SELECT MIN(y.tempsrealise)
        FROM temps as y,
            coureurs as P
        WHERE c.codeequipe = P.codeequipe
            and y.numerocoureur = P.numerocoureur
            and y.numeroEtape = t.numeroEtape
    )
GROUP BY t.numeroetape,
    c.codeequipe,
    "min";
16
)
SELECT DISTINCT t.numeroetape,
    MAX(t.tempsrealise) - MIN(t.tempsrealise) as "difference de chrono"
FROM temps as t,
    coureurs
GROUP BY t.numeroetape
ORDER BY t.numeroetape;
17
)
SELECT DISTINCT c.codeequipe,
    COUNT(*)
FROM coureurs as c
WHERE 2 <= (
        SELECT COUNT(*)
        FROM coureurs as c2
        WHERE c2.codeequipe = c.codeequipe
    )
GROUP BY c.codeequipe;
18
)
SELECT c.numerocoureur,
    c.nomcoureur
FROM coureurs as c
WHERE (
        SELECT COUNT(*)
        FROM etapes
    ) <= (
        SELECT COUNT(*)
        FROM temps
        WHERE temps.numerocoureur = c.numerocoureur
    )
GROUP BY c.numerocoureur;
19
) ? ? CALCULER VITESSE ? ?
SELECT c.numerocoureur,
    c.nomcoureur,
    AVG(t.tempsrealise)
FROM coureurs as c,
    temps as t
WHERE 3 <= (
        SELECT COUNT(*)
        FROM temps
        WHERE temps.numerocoureur = c.numerocoureur
    )
    and c.numerocoureur = t.numerocoureur
GROUP BY c.numerocoureur;
20
) A FAIRE AVEC VUE CREATE view temps_total AS (
    SELECT SUM(tempsrealise)
    FROM temps
    GROUP BY numerocoureur
    HAVING COUNT(numeroEtape) =
    SELECT COUNT(numeroEtape)
    FROM etapes
)
23)
SELECT numerocoureur,
    numeroEtape,
    SUM(T2.tempsrealise)
FROM temps T1,
    temps T2
WHERE T1.numerocoureur = T2.numerocoureur
    AND T1.numeroEtape >= T2.numeroEtape
GROUP BY T1.numerocoureur,
    T1.numeroEtape