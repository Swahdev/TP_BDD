-- a) Donner les adresses qui appartiennent à Adalberto.

SELECT adresseid FROM adresse WHERE nom = 'Adalberto';

-- +-----------+
-- | adresseid |
-- +-----------+
-- | 12ib7d    |
-- | 12WRnQ    |
-- | 15h6A2    |
-- +-----------+



-- b) Donner les entrées du transfert numéro 1.

SELECT * FROM entree WHERE txid = 1;

-- +------+-----------+---------+
-- | txid | adresseid | montant |
-- +------+-----------+---------+
-- |    1 | 12MHLS    |    1944 |
-- |    1 | 1JsVdt    |    2382 |
-- |    1 | 1KX8EP    |     663 |
-- |    1 | 1PB4xX    |     969 |
-- +------+-----------+---------+


-- c) Donnez les numéros des transferts ayant eu lieu en juillet 2013.

SELECT DISTINCT txid
FROM transfert,bloc 
WHERE 
  transfert.blocid = bloc.blocid AND
  bloctime >= '2013-07-01' AND bloctime < '2013-08-01';


select distinct txid
from transfert natural join bloc
where extract( MONTH FROM bloctime) =7;


-- +------+
-- | txid |
-- +------+
-- |    1 |
-- |    2 |
-- |    3 |
-- |    4 |
-- |    5 |
-- |    6 |
-- |    7 |
-- |    8 |
-- |    9 |
-- |   10 |
-- |   11 |
-- |   12 |
-- |   13 |
-- |   14 |
-- |   15 |
-- |   16 |
-- |   17 |
-- |   18 |
-- |   19 |
-- |   20 |
-- +------+



-- d) Donnez le nombre de personnes dont le nom commence par un 'A'.

SELECT COUNT(*) FROM personne WHERE nom LIKE 'A%';

-- +----------+
-- | COUNT(*) |
-- +----------+
-- |        4 |
-- +----------+



-- e) Donnez le nombre de transferts dans laquelle l'adresse '1FpqQn' a participé.


SELECT COUNT(*) 
FROM transfert t
WHERE 
  EXISTS (SELECT * FROM entree e WHERE e.txid = t.txid AND adresseid = '1FpqQn') OR
  EXISTS (SELECT * FROM sortie s WHERE s.txid = t.txid AND adresseid = '1FpqQn');



-- +----------+
-- | COUNT(*) |
-- +----------+
-- |       19 |
-- +----------+

  
-- f)  Donnez le montant total des transferts de 2014.

SELECT SUM(montant)
FROM transfert,entree,bloc
WHERE 
  transfert.blocid = bloc.blocid AND
  entree.txid = transfert.txid AND
  bloc.bloctime >= '2014-01-01' AND
  bloc.bloctime <= '2014-12-31';
  
-- +--------------+
-- | SUM(montant) |
-- +--------------+
-- |       641828 |
-- +--------------+


-- g) Donnez la somme des montant pour chaque transfert.

SELECT txid, SUM(montant) FROM entree GROUP BY txid;

-- +------+--------------+
-- | txid | SUM(montant) |
-- +------+--------------+
-- |    1 |         5958 |
-- |    2 |         7528 |
-- |    3 |         5824 |
-- |    4 |         5142 |
-- |    5 |         8773 |
-- |    6 |         8407 |
-- |    7 |          264 |
-- |    8 |         9668 |
-- |    9 |         8804 |
-- |   10 |          383 |
-- |   11 |         2324 |
-- |   12 |         2697 |
-- |   13 |        11666 |
-- |   14 |         1749 |
-- |   15 |        10743 |
-- |   16 |        10361 |
-- |   17 |         1884 |
-- |   18 |         2343 |
-- |   19 |         5703 |
-- |   20 |         4644 |
-- |   21 |         1477 |
-- |   22 |         6820 |
-- |   23 |         9901 |
-- |   24 |          547 |
-- |   25 |        16369 |
-- |   26 |         8130 |
-- |   27 |         6707 |
-- |   28 |         4394 |
-- |   29 |        10860 |
-- |   30 |         7726 |
-- |   31 |        11154 |
-- |   32 |         7361 |
-- |   33 |         5163 |
-- |   34 |         2290 |
-- |   35 |         7900 |
-- |   36 |         1700 |
-- |   37 |         6069 |
-- |   38 |         4420 |
-- |   39 |         6862 |
-- |   40 |         7681 |
-- |   41 |         5477 |
-- |   42 |        22260 |
-- |   43 |         3074 |
-- |   44 |         3331 |
-- |   45 |         1406 |
-- |   46 |        13120 |
-- |   47 |        10508 |
-- |   48 |         9169 |
-- |   49 |        11034 |
-- |   50 |        27736 |
-- |   51 |          265 |
-- |   52 |         8885 |
-- |   53 |         3597 |
-- |   54 |         1964 |
-- |   55 |         2997 |
-- |   56 |          332 |
-- |   57 |         5171 |
-- |   58 |         2151 |
-- |   59 |         1458 |
-- |   60 |        20327 |
-- |   61 |         2097 |
-- |   62 |         9337 |
-- |   63 |         2226 |
-- |   64 |          323 |
-- |   65 |         8586 |
-- |   66 |          657 |
-- |   67 |         5307 |
-- |   68 |        14753 |
-- |   69 |        25772 |
-- |   70 |        16008 |
-- |   71 |         6585 |
-- |   72 |         3373 |
-- |   73 |         5285 |
-- |   74 |         2702 |
-- |   75 |         3867 |
-- |   76 |         4242 |
-- |   77 |         9399 |
-- |   78 |         3887 |
-- |   79 |         3217 |
-- |   80 |         6329 |
-- |   81 |         6602 |
-- |   82 |        11980 |
-- |   83 |        15799 |
-- |   84 |         1477 |
-- |   85 |         1647 |
-- |   86 |         3460 |
-- |   87 |         2440 |
-- |   88 |          617 |
-- |   89 |        13622 |
-- |   90 |         4127 |
-- |   91 |         4038 |
-- |   92 |         8018 |
-- |   93 |        13487 |
-- |   94 |        16633 |
-- |   95 |         3568 |
-- |   96 |          671 |
-- |   97 |         6069 |
-- |   98 |        10884 |
-- |   99 |         4563 |
-- |  100 |         3298 |
-- |  101 |        14179 |
-- |  102 |         9026 |
-- |  103 |         1179 |
-- |  104 |        19302 |
-- |  105 |          950 |
-- |  106 |          857 |
-- |  107 |         6411 |
-- |  108 |          461 |
-- |  109 |         6882 |
-- |  110 |         3632 |
-- |  111 |         4444 |
-- |  112 |         2086 |
-- |  113 |          400 |
-- |  114 |         8699 |
-- |  115 |         1722 |
-- |  116 |         9893 |
-- |  117 |         4131 |
-- |  118 |          336 |
-- |  119 |         6971 |
-- |  120 |        13408 |
-- |  121 |         1154 |
-- |  122 |        11094 |
-- |  123 |         3160 |
-- |  124 |         4822 |
-- |  125 |        10413 |
-- |  126 |         5344 |
-- |  127 |         7901 |
-- |  128 |          156 |
-- |  129 |         6280 |
-- |  130 |         5496 |
-- |  131 |         5326 |
-- |  132 |         1664 |
-- |  133 |         3755 |
-- |  134 |         7527 |
-- |  135 |         6719 |
-- |  136 |         3313 |
-- |  137 |         1801 |
-- |  138 |          559 |
-- |  139 |         3123 |
-- |  140 |         8105 |
-- |  141 |         1942 |
-- |  142 |         6037 |
-- |  143 |         2475 |
-- |  144 |         3984 |
-- |  145 |        16717 |
-- |  146 |          855 |
-- |  147 |         3319 |
-- |  148 |         3619 |
-- |  149 |        10682 |
-- |  150 |         9593 |
-- |  151 |         3061 |
-- |  152 |         3154 |
-- |  153 |         1143 |
-- |  154 |         3244 |
-- |  155 |        11565 |
-- |  156 |        17196 |
-- |  157 |          545 |
-- |  158 |        33656 |
-- |  159 |         1375 |
-- |  160 |        11755 |
-- |  161 |         6451 |
-- |  162 |         4903 |
-- |  163 |           18 |
-- |  164 |         5578 |
-- |  165 |         9881 |
-- |  166 |        20884 |
-- |  167 |         7842 |
-- |  168 |        19986 |
-- |  169 |         5135 |
-- |  170 |         1991 |
-- |  171 |         7463 |
-- |  172 |         3628 |
-- |  173 |        14840 |
-- |  174 |        13926 |
-- |  175 |        12173 |
-- |  176 |         9636 |
-- |  177 |         3534 |
-- |  178 |         5549 |
-- |  179 |         6555 |
-- |  180 |        12061 |
-- |  181 |         3845 |
-- |  182 |         5407 |
-- |  183 |         8423 |
-- |  184 |         3078 |
-- |  185 |         5893 |
-- |  186 |         3073 |
-- |  187 |         4451 |
-- |  188 |         3287 |
-- |  189 |          777 |
-- |  190 |         8941 |
-- |  191 |        12171 |
-- |  192 |         3803 |
-- |  193 |         6650 |
-- |  194 |        11772 |
-- |  195 |         5550 |
-- |  196 |         6262 |
-- |  197 |         1610 |
-- |  198 |         1294 |
-- |  199 |        10960 |
-- |  200 |         3949 |
-- +------+--------------+

\echo (h)
-- h) Donnez la liste des transferts dont le montant total est supérieur à 10000 et dont le txid est supérieur à 100

SELECT txid FROM entree WHERE txid > 100 GROUP BY txid HAVING SUM(montant) > 10000;

-- +------+
-- | txid |
-- +------+
-- |  101 |
-- |  104 |
-- |  120 |
-- |  122 |
-- |  125 |
-- |  145 |
-- |  149 |
-- |  155 |
-- |  156 |
-- |  158 |
-- |  160 |
-- |  166 |
-- |  168 |
-- |  173 |
-- |  174 |
-- |  175 |
-- |  180 |
-- |  191 |
-- |  194 |
-- |  199 |
-- +------+
-- 20 rows in set (0.02 sec)


\echo (i)
-- i) Donnez le montant total qu'il y a sur l'adresse '1FpqQn'.

SELECT ((
  SELECT SUM(sortie.montant)
  FROM sortie
  WHERE sortie.adresseid = '1FpqQn'
) - (
  SELECT SUM(entree.montant)
  FROM entree
  WHERE entree.adresseid = '1FpqQn'
) + soldeinitial) AS montantTotal
FROM adresse
WHERE adresseid = '1FpqQn';


\echo (i) plus simple ?
SELECT
   (select soldeinitial
    from adresse
    WHERE adresseid = '1FpqQn')
   -
   (  SELECT SUM(montant)
      FROM entree
      WHERE adresseid = '1FpqQn'
   )
   +
   ( SELECT SUM(montant)
     FROM sortie
     WHERE adresseid = '1FpqQn'
   ) as "montant total";
   
-- +--------------+
-- | montantTotal |
-- +--------------+
-- |         7964 |
-- +--------------+


\echo "(j)"
-- j)  Donnez le nombre d'adresses utilisées en 2013 mais pas en octobre 2014.

DROP VIEW IF EXISTS entreesortie;
CREATE VIEW entreesortie AS
SELECT * FROM entree 
UNION
SELECT * FROM sortie;

SELECT COUNT(*)
FROM adresse
WHERE
  EXISTS (
    SELECT * FROM entreesortie natural join transfert natural join bloc
    WHERE 
      entreesortie.adresseid = adresse.adresseid and
      (bloc.bloctime >= '2013-01-01') and (bloc.bloctime <= '2013-12-31')
  ) and
  NOT EXISTS (
    SELECT * FROM entreesortie natural join transfert natural join bloc
    WHERE 
      entreesortie.adresseid = adresse.adresseid and
      (bloc.bloctime >= '2014-10-01') and (bloc.bloctime <= '2014-10-31')
  );


\Echo "(j)" sans vues
-- j) sans les vues
SELECT COUNT(DISTINCT adress)
FROM ((SELECT DISTINCT e.adresseid AS adress
       FROM entree e
       WHERE EXISTS ( SELECT *
                      FROM transfert t, bloc b
                      WHERE e.txid = t.txid AND
		      t.blocid = b.blocid
                      AND EXTRACT(YEAR FROM b.bloctime)=2013)
                     AND NOT EXISTS (SELECT *
		                     FROM transfert t, bloc b
                                     WHERE e.txid = t.txid
				     AND t.blocid = b.blocid
                                     AND b.bloctime>='2014-10-01'
				     AND b.bloctime<'2014-11-01'
)) 
UNION
(SELECT DISTINCT s.adresseid AS adress
FROM sortie s
WHERE EXISTS (
SELECT * FROM transfert t, bloc b
WHERE s.txid = t.txid AND t.blocid = b.blocid
AND EXTRACT(YEAR FROM b.bloctime)='2013')
AND NOT EXISTS (
SELECT * FROM transfert t, bloc b
WHERE s.txid = t.txid AND t.blocid = b.blocid
AND b.bloctime>='2014-10-01' AND b.bloctime<'2014-11-01'
))) AS ff; 


-- (j) sans Views avec WITH
\echo "(j)" avec WITH
WITH total as ( (select * from entree) UNION (select * from sortie )  ),
TTB as (select * from total natural join transfert natural join bloc)
select count( distinct adresseid )
from total
where adresseid in (select adresseid
                    from TTB
		    WHERE EXTRACT(YEAR FROM bloctime) = 2013)
      AND
      adresseid NOT IN (select adresseid
                    from TTB
		    WHERE EXTRACT(YEAR FROM bloctime) = 2014
		          AND
			  EXTRACT(MONTH FROM bloctime) = 10);



\echo "(j)" avec les operations ensemblistes
SELECT COUNT(*)
FROM 
(((select adresseid 
from entree natural join transfert  natural join bloc
where EXTRACT( YEAR FROM bloctime ) = 2013
union
select adresseid 
from sortie natural join transfert  natural join bloc
where EXTRACT( YEAR FROM bloctime ) = 2013))

EXCEPT

((select adresseid 
from entree natural join transfert  natural join bloc
where EXTRACT( YEAR FROM bloctime ) = 2014 AND EXTRACT( MONTH FROM bloctime ) = 10)
union
(select adresseid 
from sortie natural join transfert  natural join bloc
where EXTRACT( YEAR FROM bloctime ) = 2014 AND EXTRACT( MONTH FROM bloctime ) = 10))) T;

-- +----------+
-- | COUNT(*) |
-- +----------+
-- |       90 |
-- +----------+



-- k) Donnez les numéros des transferts qui ont strictement plus d'entrées que de sorties.

SELECT transfert.txid
FROM transfert
WHERE 
  (SELECT COUNT(*) FROM entree WHERE entree.txid = transfert.txid) >
  (SELECT COUNT(*) FROM sortie WHERE sortie.txid = transfert.txid);
  
-- ou (plus compliqué, mais normalement plus efficace)

SELECT counts.txid
FROM (
  SELECT transfert.txid as txid,centree.n as nentrees,csortie.n as nsorties
  FROM transfert
  LEFT JOIN (SELECT entree.txid,COUNT(*) as n FROM entree GROUP BY entree.txid) as centree
  ON transfert.txid = centree.txid
  LEFT JOIN (SELECT sortie.txid,COUNT(*) as n FROM sortie GROUP BY sortie.txid) as csortie
  ON transfert.txid = csortie.txid
) as counts
WHERE
  counts.nentrees > counts.nsorties OR
  ((counts.nentrees IS NOT NULL) AND (counts.nsorties IS NULL));
  
-- +------+
-- | txid |
-- +------+
-- |    4 |
-- |    6 |
-- |   13 |
-- |   18 |
-- |   21 |
-- |   23 |
-- |   27 |
-- |   29 |
-- |   30 |
-- |   34 |
-- |   37 |
-- |   42 |
-- |   46 |
-- |   50 |
-- |   52 |
-- |   53 |
-- |   58 |
-- |   60 |
-- |   65 |
-- |   67 |
-- |   71 |
-- |   72 |
-- |   79 |
-- |   81 |
-- |   82 |
-- |   83 |
-- |   85 |
-- |   89 |
-- |   91 |
-- |   99 |
-- |  102 |
-- |  106 |
-- |  107 |
-- |  109 |
-- |  114 |
-- |  116 |
-- |  119 |
-- |  120 |
-- |  124 |
-- |  126 |
-- |  129 |
-- |  130 |
-- |  135 |
-- |  138 |
-- |  140 |
-- |  142 |
-- |  147 |
-- |  148 |
-- |  149 |
-- |  150 |
-- |  158 |
-- |  165 |
-- |  166 |
-- |  168 |
-- |  170 |
-- |  174 |
-- |  177 |
-- |  183 |
-- |  187 |
-- |  190 |
-- |  198 |
-- |  200 |
-- +------+
-- 62 rows in set (0.00 sec)





-- l) Assurez-vous que pour chaque transfert, la somme des montants des 
--    entrées est égale à la somme des montants des sorties


SELECT transfert.txid
FROM transfert
WHERE 
  (SELECT SUM(montant) FROM entree WHERE entree.txid = transfert.txid) !=
  (SELECT SUM(montant) FROM sortie WHERE sortie.txid = transfert.txid);
  
-- Empty set (0.01 sec)




-- m) Donnez le montant total qu'il y a sur les adresses d'Abby.

  
SELECT ((
  SELECT SUM(sortie.montant)
  FROM sortie,adresse
  WHERE 
    sortie.adresseid = adresse.adresseid AND
    adresse.nom = 'Abby'
) - (
  SELECT SUM(entree.montant)
  FROM entree,adresse
  WHERE
    entree.adresseid = adresse.adresseid AND
    adresse.nom = 'Abby'
) + (
  SELECT SUM(soldeinitial)
  FROM adresse
  WHERE nom = 'Abby'
)) AS SoldeAbby;


-- +-----------+
-- | SoldeAbby |
-- +-----------+
-- |     19899 |
-- +-----------+



  
  
-- n) Donnez la liste des noms avec leur solde final correspondant
\echo (n) avec vues
DROP VIEW IF EXISTS soldesinitiaux,etotaux,stotaux;
CREATE VIEW soldesinitiaux AS
SELECT nom,SUM(soldeinitial) AS soldeinitialtotal 
FROM adresse
GROUP BY nom;

CREATE VIEW etotaux AS
SELECT nom,SUM(montant) AS etotal
FROM adresse,entree
WHERE adresse.adresseid = entree.adresseid
GROUP BY nom;

CREATE VIEW stotaux AS
SELECT nom,SUM(montant) AS stotal
FROM adresse,sortie
WHERE adresse.adresseid = sortie.adresseid
GROUP BY nom;


SELECT etotaux.nom,soldeinitialtotal+stotal-etotal as total
FROM soldesinitiaux,etotaux,stotaux
WHERE 
  etotaux.nom = stotaux.nom AND
  etotaux.nom = soldesinitiaux.nom
ORDER BY total DESC;



\echo (n) sans vues

WITH 
soldesinitiaux AS
(SELECT nom,SUM(soldeinitial) AS soldeinitial
FROM adresse
GROUP BY nom),
etotaux AS
(SELECT nom,SUM(montant) AS etotal
FROM adresse,entree
WHERE adresse.adresseid = entree.adresseid
GROUP BY nom),
stotaux AS
(SELECT nom,SUM(montant) AS stotal
FROM adresse,sortie
WHERE adresse.adresseid = sortie.adresseid
GROUP BY nom)
SELECT nom,soldeinitial+stotal-etotal as total
FROM soldesinitiaux natural join etotaux natural join stotaux
ORDER BY total DESC;


-- +-----------+-------+
-- | nom       | total |
-- +-----------+-------+
-- | Latonya   | 25685 |
-- | Brett     | 25488 |
-- | Jacques   | 24253 |
-- | Eun       | 23823 |
-- | Johnnie   | 22867 |
-- | Steven    | 21646 |
-- | Erich     | 20121 |
-- | Idell     | 19922 |
-- | Abby      | 19899 |
-- | Reggie    | 18760 |
-- | Neida     | 17342 |
-- | Elmo      | 16724 |
-- | Matilda   | 14256 |
-- | Arica     | 13748 |
-- | Karyl     | 13455 |
-- | Brenton   | 13197 |
-- | Melia     | 12825 |
-- | Alphonso  | 12451 |
-- | Dirk      | 10869 |
-- | Noble     |  9823 |
-- | Kirby     |  8919 |
-- | Delbert   |  7402 |
-- | Kemberly  |  6169 |
-- | Mayra     |  4612 |
-- | Beata     |  4586 |
-- | Gwendolyn |  3924 |
-- | Chia      |  3917 |
-- | Parker    |  3184 |
-- | Adalberto |  2737 |
-- | Thomasena |  2310 |
-- +-----------+-------+
-- 30 rows in set (0.01 sec)


\echo (o)
-- o) Donnez les noms de la paire (ou des paires) de personnes ayant participé aux plus de transferts ensemble

DROP VIEW IF EXISTS paires;
DROP VIEW IF EXISTS participe;
CREATE VIEW participe AS 
SELECT nom,txid
FROM entree JOIN adresse
ON entree.adresseid = adresse.adresseid
UNION
SELECT nom,txid
FROM sortie JOIN adresse
ON sortie.adresseid = adresse.adresseid;


CREATE VIEW paires AS (
  SELECT participe1.nom AS a,participe2.nom AS b,count(*) AS n
  FROM participe AS participe1
  JOIN participe AS participe2
  ON participe1.txid = participe2.txid
  WHERE participe1.nom < participe2.nom
  GROUP BY participe1.nom,participe2.nom
);

SELECT a,b,n
FROM paires
WHERE n = (SELECT MAX(n) FROM paires);

-- +-------+--------+----+
-- | a     | b      | n  |
-- +-------+--------+----+
-- | Erich | Reggie | 15 |
-- | Karyl | Reggie | 15 |
-- +-------+--------+----+

