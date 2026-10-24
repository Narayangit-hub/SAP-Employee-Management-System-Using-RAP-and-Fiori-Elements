@EndUserText.label : 'Employee Master'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
define table zemployee {
  key client          : abap.clnt not null;
  key employee_id     : abap.numc(10) not null;
  employee_name       : abap.char(50);
  salary              : abap.curr(15,2);
  department_id       : abap.numc(4);
  employee_status     : abap.char(1);
  salary_status       : abap.int1;
  created_by          : abp_creation_user;
  created_at          : abp_creation_tstmpl;
  last_changed_by     : abp_lastchange_user;
  last_changed_at     : abp_lastchange_tstmpl;
}
