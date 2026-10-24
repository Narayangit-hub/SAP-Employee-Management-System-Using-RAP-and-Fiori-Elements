CLASS lhc_employee DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS promoteEmployee
      FOR MODIFY
      IMPORTING keys FOR ACTION Employee~promoteEmployee
      RESULT result.

    METHODS validateSalary
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR Employee~validateSalary.

    METHODS calculateSalaryStatus
      FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Employee~calculateSalaryStatus.

    METHODS get_instance_features
      FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features
      FOR Employee
      RESULT result.
ENDCLASS.

CLASS lhc_employee IMPLEMENTATION.

  METHOD promoteEmployee.
    READ ENTITIES OF ZI_EMPLOYEE IN LOCAL MODE
      ENTITY Employee
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_employee).

    MODIFY ENTITIES OF ZI_EMPLOYEE IN LOCAL MODE
      ENTITY Employee
      UPDATE FIELDS ( Salary )
      WITH VALUE #(
        FOR ls_employee IN lt_employee
        (
          %tky = ls_employee-%tky
          Salary = ls_employee-Salary
                    + ( ls_employee-Salary * 20 / 100 )
        )
      )
      FAILED DATA(lt_failed)
      REPORTED DATA(lt_reported).

    READ ENTITIES OF ZI_EMPLOYEE IN LOCAL MODE
      ENTITY Employee
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_updated).

    result = VALUE #(
      FOR ls_employee IN lt_updated
      (
        %tky   = ls_employee-%tky
        %param = ls_employee
      )
    ).
  ENDMETHOD.

  METHOD validateSalary.
    READ ENTITIES OF ZI_EMPLOYEE IN LOCAL MODE
      ENTITY Employee
      FIELDS ( Salary )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_employee).

    LOOP AT lt_employee INTO DATA(ls_employee).
      IF ls_employee-Salary < 30000.
        APPEND VALUE #( %tky = ls_employee-%tky )
          TO failed-employee.

        APPEND VALUE #(
          %tky = ls_employee-%tky
          %msg = new_message(
            id       = 'ZEMPLOYEE'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = 'Salary must be at least 30000'
          )
        ) TO reported-employee.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculateSalaryStatus.
    READ ENTITIES OF ZI_EMPLOYEE IN LOCAL MODE
      ENTITY Employee
      FIELDS ( Salary )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_employee).

    MODIFY ENTITIES OF ZI_EMPLOYEE IN LOCAL MODE
      ENTITY Employee
      UPDATE FIELDS ( SalaryStatus )
      WITH VALUE #(
        FOR ls_employee IN lt_employee
        (
          %tky = ls_employee-%tky
          SalaryStatus =
            COND #(
              WHEN ls_employee-Salary < 30000 THEN 1
              WHEN ls_employee-Salary <= 60000 THEN 2
              ELSE 3
            )
        )
      )
      FAILED DATA(lt_failed)
      REPORTED DATA(lt_reported).
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF ZI_EMPLOYEE IN LOCAL MODE
      ENTITY Employee
      FIELDS ( EmployeeStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_employee).

    result = VALUE #(
      FOR ls_employee IN lt_employee
      (
        %tky = ls_employee-%tky
        %action-promoteEmployee =
          COND #(
            WHEN ls_employee-EmployeeStatus = 'A'
              THEN if_abap_behv=>fc-o-enabled
            ELSE if_abap_behv=>fc-o-disabled
          )
      )
    ).
  ENDMETHOD.

ENDCLASS.
