#include "ImplicitEuler.h"

#ifndef COUPLEDDARCYIMPLICITEULER
#define COUPLEDDARCYIMPLICITEULER

//Forward Declarations
class CoupledDarcyImplicitEuler;

template<>
InputParameters validParams<CoupledDarcyImplicitEuler>();

class CoupledDarcyImplicitEuler : public Kernel
{
public:

  CoupledDarcyImplicitEuler(std::string name, MooseSystem & moose_system, InputParameters parameters);

protected:
  virtual Real computeQpResidual();

  virtual Real computeQpJacobian();

  bool _has_enthalpy;
  MooseArray<Real> & _enthalpy;
  MooseArray<Real> & _enthalpy_old;
  MooseArray<Real> & _porosity;
  
  
};
#endif //COUPLEDDARCYIMPLICITEULER