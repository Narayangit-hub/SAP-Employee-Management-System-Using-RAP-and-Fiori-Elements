@EndUserText.label : 'Department Master'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
define table zdepartment {
  key client         : abap.clnt not null;
  key department_id  : abap.numc(4) not null;
  department_name    : abap.char(50);
}
