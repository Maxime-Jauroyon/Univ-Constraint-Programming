/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 7 mars 2023 at 17:17:17
 *********************************************/
execute{
    var f = cp.factory;
    cp.setSearchPhases(
    	f.searchPhase(t,
    				  f.selectLargest(f.explicitVarEval(t,f.selectSmallest(number_of_queen/2 + number_of_queen%2 ,f.varIndex(t)))),
    				  f.selectRandomValue(f.value())
    	)
    );
}