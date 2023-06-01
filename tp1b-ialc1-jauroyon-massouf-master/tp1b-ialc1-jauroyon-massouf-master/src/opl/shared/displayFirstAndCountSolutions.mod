/*********************************************
 * Generic main bloc for displaying the first found solution 
 * and displaying the total number of solutions
 *********************************************/
 
main {
    thisOplModel.generate();
    cp.startNewSearch();
    var compteur = 0;
    while (cp.next()) {
        if (compteur == 0) {
            thisOplModel.postProcess();
        }
        compteur++;
    }
    writeln("Nombre de solutions : ", compteur);
}
