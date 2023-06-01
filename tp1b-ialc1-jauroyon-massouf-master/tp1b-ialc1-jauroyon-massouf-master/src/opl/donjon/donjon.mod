/*************************************************************
 * Problème du Donjon
 *
 * Modèle simple permettant de trouver une solution au problème du Donjon
 * 
 * Un conseil : 
 *    essayer de "visualiser" la solution plutôt
 *    sous une forme "graphique" (bien qu'en mode texte)
 *    pour mieux visualiser l'emplacement des soldats.
 *
 * Binôme :   TP1B Maxime, Philippe
 *
 *********************************************/
using CP;

//----- Parametrage Solveur -----
// TODO

execute {
    cp.param.logVerbosity = "Quiet";
}


//----- Données du problème -----
// TODO
 
 range d = 0..12; //nombre de gardes


//----- Variables et domaines -----
// TODO

{string} p = {"NW", "N", "NE", "SW", "S", "SE", "W", "E" };
dvar int t[p] in d;
{string} coteNord = {"NW", "N", "NE"};
{string} coteSud = {"SW", "S", "SE"};
{string} coteWest = {"NW","SW","W"};
{string} coteEst = {"NE","SE", "E" };

/* t["NW"] = 3 signifie "3 gardes regardent vers le Nord et l'Ouest" */

//----- Contraintes -----
// TODO

constraints {
    /* Il doit y avoir exactement 12 gardes */

    (sum(i in p) t[i]) == 12;

    /*Comment doivent-ils se répartir afin qu'il y ait toujours au moins 
    5 paires d'yeux scrutant vers le Nord, l'Est, le Sud et vers l'Ouest. */

    (sum(i in coteNord) t[i]) >= 5;
    (sum(i in coteSud) t[i]) >= 5;
    (sum(i in coteEst) t[i]) >= 5;
    (sum(i in coteWest) t[i]) >= 5;
}

//----- Post-traitement -----
// TODO


execute {
    writeln("Solution :");
    writeln("  ", t["NW"], " ", t["N"], " ", t["NE"]);
    writeln("  ", t["W"], "   ", t["E"]);
    writeln("  ", t["SW"], " ", t["S"], " ", t["SE"]);
}