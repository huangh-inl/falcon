#ifndef SOLIDMECHTEMPCOUPLEZFALCON
#define SOLIDMECHTEMPCOUPLEZFALCON

#include "SolidMechTempCoupleFalcon.h"


//Forward Declarations
class SolidMechTempCoupleZFalcon;

template<>
InputParameters validParams<SolidMechTempCoupleZFalcon>();

class SolidMechTempCoupleZFalcon : public SolidMechTempCoupleFalcon
{
public:

  SolidMechTempCoupleZFalcon(const std::string & name, InputParameters parameters);
  
protected:
  virtual Real computeQpResidual();
  
  virtual Real computeQpOffDiagJacobian(unsigned int jvar);
  
};
 
#endif //SOLIDMECHTEMPCOUPLEZFALCON