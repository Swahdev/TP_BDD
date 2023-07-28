\ ! echo Requête << 1 >>
SELECT nom,
    annaiss
from joueurtennis
WHERE (
        nujoueur = nugagnant
        OR nujoueur = nuperdant
    )
    AND annee = 1994
    AND lieutournoi = 'Roland Garros';
\ ! echo Requête << 2 >>
SELECT nom,
    nationalite
from joueurtennis,
    gain
WHERE nujoueur = nugagnant
    AND annee = 1992
    AND lieutournoi = 'Roland Garros'
    AND nujoueur in (
        SELECT nujoueur
        from gain
        WHERE annee = 1992
            AND lieutournoi = 'Wimbledon'
    );
\ ! echo Requête << 3 >> 