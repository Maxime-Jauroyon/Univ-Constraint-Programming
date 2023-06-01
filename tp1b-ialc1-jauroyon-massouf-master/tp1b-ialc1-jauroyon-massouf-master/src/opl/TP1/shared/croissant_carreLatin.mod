/*********************************************
 * OPL 22.1.1.0 Model
 * Author: maxim
 * Creation Date: 12 mars 2023 at 20:04:16
 *********************************************/
execute{
    var f = cp.factory;
    for (var i in d){
      cp.setSearchPhases(
    	f.searchPhase(t,
    				  f.selectSmallest(f.varIndex(t[i])),
    				  f.selectSmallest(f.value())
    	)
    );
    }
}