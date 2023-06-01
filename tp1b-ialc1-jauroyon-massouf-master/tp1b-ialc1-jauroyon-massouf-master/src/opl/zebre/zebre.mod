/*********************************************
 * Modèle pour le problème du zebre (Lewis Caroll)
 *********************************************/

using CP;

//----- Parametrage Solveur -----
// TODO

execute {
    cp.param.logVerbosity = "Quiet";
}

/*** Données du problème  ***/
// TODO

range d = 1..5; // les cinq premières maisons d'une rue
 
/*** Variables et domaines  ***/
// TODO

{string} nationalites = {"Anglais", "Espagnol", "Italien", "Norvegien", "Japonais"};
{string} couleurs = {"Rouge", "Vert", "Blanc", "Jaune", "Bleu"};
{string} professions = {"Sculpteur", "Peintre", "Violoniste", "Medecin", "Diplomate"};
{string} boissons = {"The", "Cafe", "Lait", "Eau", "Fruits"};
{string} animaux = {"Chien", "Zebre", "Escargot", "Cheval", "Renard"};

{string} total = nationalites union couleurs union professions union boissons union animaux;

dvar int t[total] in d;

/*  t["Anglais"] = 1 signifie "la personne de nationalité anglaise habite dans la 1ere maison" 
    t["Rouge"] = 1 signifie "la personne qui aime le rouge habite dans la 1ere maison" 
    t["Sculpteur"]= 1 signifie "la personne qui est sculpteur habite dans la 1ere maison" 
    t["The"] = 1 signifie "la personne qui aime le thé habite dans la 1ere maison"
    t["Chien"] = 1 signifie "la personne qui aime les chiens habite dans la 1ere maison" */

/*** Contraintes  ***/
// TODO

constraints {

    // contraintes de différences

    forall(i,j in nationalites: i < j){
        t[i] != t[j];
    }
    forall(i,j in couleurs: i < j){
        t[i] != t[j];
    }
    forall(i,j in professions: i < j){
        t[i] != t[j];
    }
    forall(i,j in boissons: i < j){
        t[i] != t[j];
    }
    forall(i,j in animaux: i < j){
        t[i] != t[j];
    }


    // 1. L'anglais habite la maison rouge
    t["Anglais"] == t["Rouge"];

    // 2. L'espagnol possède un chien.
    t["Espagnol"] == t["Chien"];

    // 3. Le japonais est peintre.
    t["Japonais"] == t["Peintre"];

    // 4. L'italien boit du thé.
    t["Italien"] == t["The"];

    // 5. Le norvégien habite la première maison à gauche.
    t["Norvegien"] == 1;

    // 6. Le propriétaire de la maison verte boit du café.
    t["Vert"] == t["Cafe"];

    // 7. La maison verte est à droite de la blanche.
    t["Vert"] == t["Blanc"] + 1;

    // 8. Le sculpteur élève des escargots.
    t["Sculpteur"] == t["Escargot"];

    // 9. Le diplomate habite la maison jaune.
    t["Diplomate"] == t["Jaune"];

    // 10. On boit du lait dans la maison du milieu.
    t["Lait"] == 3;

    // 11. Le norvégien habite à coté de la maison bleue.
    abs(t["Norvegien"] - t["Bleu"]) == 1;

    // 12. Le violoniste boit des jus de fruits. 
    t["Violoniste"] == t["Fruits"];

    // 13. Le renard est dans la maison voisine du médecin.
    abs(t["Renard"] - t["Medecin"]) == 1;

    // 14. Le cheval est à coté de celle du diplomate.
    abs(t["Cheval"] - t["Diplomate"]) == 1;

}


/*** Post-traitement  ***/
// TODO

execute {
    for(var i in d){
        write("Maison ",i," : ");
        for(var j in total){
            if(t[j] == i){
                write(j,"  ");
            }
        }
        writeln();
    }
}
