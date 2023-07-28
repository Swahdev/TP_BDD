\! echo "(a)"
SELECT nom, annaiss
FROM joueurtennis NATURAL JOIN gain
WHERE lieutournoi='Roland Garros' AND annee=1994;

/* ou */

SELECT nom, annaiss
FROM joueurtennis J, gain G
WHERE lieutournoi='Roland Garros' AND annee=1994 AND J.nujoueur=G.nujoueur;

\! echo "(b)"

SELECT nom, nationalite
FROM joueurtennis  natural join gain G
WHERE lieutournoi='Roland Garros' AND annee=1992 AND
 G.nujoueur in (SELECT nujoueur
                FROM gain
		WHERE lieutournoi='Wimbledon' AND annee=1992
               );

/* ou */

SELECT nom, nationalite
FROM joueurtennis J, gain G1, gain G2
WHERE J.nujoueur=G1.nujoueur AND G1.lieutournoi='Roland Garros'
AND G1.annee=1992 AND J.nujoueur=G2.nujoueur
AND G2.lieutournoi='Wimbledon' AND G2.annee=1992;


\! echo "(c)"

SELECT DISTINCT nom, nationalite
FROM joueurtennis natural join gain G, rencontre R
WHERE sponsor='Peugeot' AND R.lieutournoi='Roland Garros'
      AND G.nujoueur=nugagnant;

\! echo "(d)"

SELECT DISTINCT nuperdant
FROM rencontre
WHERE lieutournoi='Wimbledon'
      AND NOT nuperdant in ( SELECT nugagnant
                             FROM rencontre
                             WHERE lieutournoi='Wimbledon' )
     AND nuperdant in     ( SELECT nugagnant
                            FROM rencontre
                            WHERE lieutournoi='Roland Garros' )
     AND NOT nuperdant in ( SELECT nuperdant
                            FROM rencontre
                            WHERE lieutournoi='Roland Garros' );

\! echo "(d)" avec les opérations ensemblistes

(
(SELECT nuperdant        -- les perdants à Wimbledon
from rencontre
where lieutournoi = 'Wimbledon')
EXCEPT
(select nugagnant        -- moins les gagnants à Wimbledon
from rencontre
where lieutournoi = 'Wimbledon')
)
INTERSECT
(
(SELECT nugagnant     -- les gagnants à Roland Garros
from rencontre
where lieutournoi = 'Roland Garros')
EXCEPT
(select nuperdant     -- moins les perdants à Roland Garros
from rencontre
where lieutournoi = 'Roland Garros')
	);


\! echo "(e)"
/* Solution 1 */
SELECT DISTINCT nom, lieutournoi, annee
FROM joueurtennis JOIN rencontre R1 ON( nujoueur=nugagnant )
WHERE  nujoueur NOT in ( SELECT nuperdant
                           FROM rencontre R2
                           WHERE R2.lieutournoi=R1.lieutournoi
                                 AND
                                 R2.annee=R1.annee );
/* Solution 2 */
SELECT DISTINCT nom, lieutournoi, annee
FROM joueurtennis, rencontre R1
WHERE nujoueur=nugagnant
      AND NOT EXISTS( SELECT *
                      FROM rencontre R2
                      WHERE R2.nuperdant=nujoueur
                            AND
                            R2.lieutournoi=R1.lieutournoi
                            AND R2.annee=R1.annee );
                            
--- les solutions ci dessus sont fausses dues à des données manquantes dans la table "rencontre" 
--- il faut plutot aller chercher le vainqueur dans la table gain (prime maximale)
--- sinon on se retrouve avec plusieurs vainqueurs pour certains tournois ...

--- Le problème que nous ne savons pas trop qu'elle est la signification de gain
--- et le deuxièlme problème c'est de melanger les femmes et les hommes, pourtant ils ne jouent pas ensemble
--- il manque l'attribut sexe
\! echo "(e)" plutôt gain maximal par tournoi avec un tri

SELECT  g1.lieutournoi, g1.annee, nom 
FROM gain g1 natural join joueurtennis
WHERE prime  >= ALL (select g2.prime
                          from gain g2
			  where g2.lieutournoi=g1.lieutournoi and g2.annee=g1.annee)
ORDER BY annee, lieutournoi;			  

--- ou 

SELECT lieutournoi, annee, nom 
FROM gain g1 natural join joueurtennis
WHERE prime=(select MAX(g2.prime)
                  from gain g2
		  where g2.lieutournoi=g1.lieutournoi and g2.annee=g1.annee);

-- ci-dessous "participer" veut dire etre dans la table gain pour le tournois donne
\! echo "(f)"
SELECT J.nom
FROM joueurtennis J
WHERE NOT EXISTS ( SELECT *          -- le gain G1 est selectionne si le jourur J avait un gain pour le même tournoi en 1992
                   FROM gain G1
                   WHERE G1.annee=1992
		   AND NOT EXISTS ( SELECT *
                                    FROM gain G2
                                    WHERE G2.annee=1992
                                          AND G2.lieutournoi=G1.lieutournoi
                                          AND G2.nujoueur=J.nujoueur ));

\echo "(f)" une autre solution
select nom
from joueurtennis natural join gain 
where  annee = 1992
group by nom
having count( lieutournoi ) = (select count(distinct lieutournoi)
                               from gain
			       where annee = 1992);

\echo "(f)" encore
select nom
from joueurtennis J
where not exists( 
	  (select distinct lieutournoi from gain where annee = 1992 ) 
	  EXCEPT 
	 (  select lieutournoi from gain where annee = 1992 and J.nujoueur = nujoueur) 
);  


\! echo "(g)"
SELECT count(*) FROM rencontre;

\! echo "(h)"  encore une fois "participer" == "avoir un gain"
SELECT lieutournoi, annee, count(*)
FROM gain
GROUP BY lieutournoi,annee;

\! echo "(i)"  
SELECT nujoueur
FROM gain
GROUP BY nujoueur
HAVING count(DISTINCT sponsor)>1;

SELECT DISTINCT G.nujoueur
FROM gain G, gain H
WHERE G.nujoueur=H.nujoueur
AND G.sponsor<>H.sponsor;

\! echo "(j)"
SELECT nujoueur
FROM gain
GROUP BY nujoueur
HAVING count(DISTINCT sponsor)=2;  

SELECT DISTINCT G.nujoueur
FROM gain G, gain H
WHERE G.nujoueur=H.nujoueur
AND G.sponsor<>H.sponsor
AND NOT EXISTS ( SELECT *
                 FROM gain I
                 WHERE I.nujoueur=G.nujoueur
                       AND I.sponsor<>G.sponsor
                       AND I.sponsor<>H.sponsor );  


\! echo "(k)"
select annee, round(avg(prime)) as MoyPrimes
from gain
group by annee;

\! echo "(l)"
select nom, prime
from joueurtennis NATURAL JOIN gain 
where annee=1992
and prime = ( select MAX(prime)
              from gain
              where annee=1992 ); 

select nom, prime
from joueurtennis NATURAL JOIN  gain 
where annee=1992
and prime >= ALL ( select prime
                   from gain
                   where annee=1992 );

\! echo "(m)"
select nom, sum(prime) as SOMME_PRIMES
from joueurtennis natural join gain 
where annee=1992
group by nom
order by SOMME_PRIMES DESC;

\! echo "(n)"      

select distinct nationalite
from joueurtennis JOIN rencontre R1 ON( nujoueur = R1.nugagnant ) -- joueurTennis a gagne dans une rencontre
where nujoueur  not in ( select R2.nuperdant                      -- et jamais perdu dans le même tournoi
                         from rencontre R2
                         where R2.lieutournoi=R1.lieutournoi and
                         R2.annee=R1.annee )
group by nationalite
having count(distinct R1.annee) = ( select count(distinct annee)
                                    from rencontre );


--- avec une table auxiliaire vainqueurs(annee, nationalite)
--- pour chaque nationalité qui a gagné un tournois dans l'annee
SELECT nationalite
FROM
(SELECT distinct annee, nationalite   --table vainquers(annee, nationalité) dans FROM
 from gain g natural join joueurtennis  
 where g.prime=(select MAX(g2.prime) 
				from gain g2 
				where g2.lieutournoi=g.lieutournoi and g2.annee=g.annee))  AS vainqueurs
GROUP BY nationalite
HAVING count( * ) = (SELECT COUNT( distinct annee ) FROM gain ) ; --selectionnée un groupe s'il contient toutes les annees

--- meme chose avec WITH
WITH vainqueurs(annee, nationalite) AS
(SELECT distinct annee, nationalite 
 from gain g natural join joueurtennis  
 where g.prime=(select MAX(g2.prime) 
				from gain g2 
				where g2.lieutournoi=g.lieutournoi and g2.annee=g.annee)) 
SELECT nationalite
FROM vainqueurs
GROUP BY nationalite
HAVING count(*) = (SELECT count(distinct annee) FROM vainqueurs);




/*
                                    -- ou --
         -- creer une table temporaire "scores" qui donne, nation par nation et annee par annee,
       --- le nombre de tournois remporté cette année-là, par des joueurs de cette nationalité là.
WITH scores(nation,annee, wins) AS

(WITH vainqueurs(lieu, an,nation) AS
(SELECT distinct g.lieutournoi, g.annee, j.nationalite from gain g, joueurtennis j where j.nujoueur=g.nujoueur
AND g.prime=(select MAX(g2.prime) from gain g2 where g2.lieutournoi=g.lieutournoi and g2.annee=g.annee))

SELECT nation, an, COUNT(distinct lieu) as wins 
FROM vainqueurs 
GROUP BY nation, an  ORDER BY an, wins )

SELECT distinct s1.nation from scores s1 where s1.wins>0 
AND NOT EXISTS (Select * from scores s2 where s1.nation=s2.nation and s2.wins=0)
AND NOT EXISTS (select * from scores s3 where s3.nation<>s1.nation and s3.wins>0 
and s1.nation NOT IN (select distinct s4.nation from scores s4 where s4.annee=s3.annee and s4.wins>0)) ;

--- se servir de la table scores, pour trouver les nations qui ont gagné au moins un tournoi par an
--- il n'existe pas d'année où elles remportent 0 tournoi
--- et il n'existe pas d'année où d'autres nations remportent au moins un tournoi, et elle ne figure pas dans la table.
*/

------ ou (solution plus simple) ---
-- il n'existe pas une annee g.annee où aucun joueur de cette nation n'a remporté un tournoi.

SELECT distinct nationalite
FROM joueurtennis j
WHERE NOT EXISTS (select * from gain g   -- gain g selectionne si un joueur de la même nationalite que j
                                         -- n'a  gagne aucun  tournoi  l'anne g.annee
                  where NOT EXISTS --g.annee NOT IN
                       (Select distinct g2.annee
		        from gain g2, joueurtennis j2
			where g2.annee=g.annee
                              And j2.nationalite=j.nationalite
			      and j2.nujoueur=g2.nujoueur
                              And g2.prime=(select MAX(g3.prime)
			                    from gain g3
					    where g3.lieutournoi=g2.lieutournoi and g3.annee=g2.annee)));
