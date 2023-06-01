/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 7 mars 2023 at 17:17:17
 *********************************************/
int prio[d] = [i:minl(i,number_of_queen - i + 1) | i in d];
 
execute{
    var f = cp.factory;
    cp.setSearchPhases(
    	f.searchPhase(t,
    				  f.selectLargest(f.explicitVarEval(t,prio)),
    				  f.selectRandomValue()
    	)
    );
}