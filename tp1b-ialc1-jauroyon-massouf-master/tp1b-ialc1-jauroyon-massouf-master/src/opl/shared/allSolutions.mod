/*********************************************
 * Generic main bloc for computing and displaying all solutions
 * as well as the total number of solutions
 *********************************************/
 
main {
    thisOplModel.generate();
    cp.startNewSearch();
    var compteur = 0;
    while (cp.next()) {
        if (compteur > 0) {
            writeln("--------------------------------------------------");
        
        }
        writeln("Solution ", compteur, " : ");
        thisOplModel.postProcess();
        compteur++;
    }
    writeln("Nombre de solutions : ", compteur);
}