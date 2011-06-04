#ifndef COUPLEDDSTEAMENTHALPYDH_PAux
#define COUPLEDDSTEAMENTHALPYDH_PAux

#include "AuxKernel.h"


//Forward Declarations
class CoupledDsteamenthalpydH_PAux;

template<>
InputParameters validParams<CoupledDsteamenthalpydH_PAux>();

/** 
 * Coupled auxiliary value
 */
class CoupledDsteamenthalpydH_PAux : public AuxKernel
{
public:
    
    /**
     * Factory constructor, takes parameters so that all derived classes can be built using the same
     * constructor.
     */
    CoupledDsteamenthalpydH_PAux(const std::string & name, InputParameters parameters);
    
    virtual ~CoupledDsteamenthalpydH_PAux() {}
    
protected:
    virtual Real computeValue();
};

#endif //COUPLEDDSTEAMENTHALPYDH_PAux