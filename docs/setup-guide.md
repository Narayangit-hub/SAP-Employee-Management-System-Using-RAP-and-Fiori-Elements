# Setup Guide

## Recommended object creation order

1. Create package.
2. Create `ZEMPLOYEE` database table.
3. Create `ZDEPARTMENT` database table.
4. Create `ZI_DEPARTMENT`.
5. Create `ZI_EMPLOYEE`.
6. Create `ZC_EMPLOYEE` projection view.
7. Create interface behavior `ZI_EMPLOYEE`.
8. Create behavior implementation class `ZBP_I_EMPLOYEE`.
9. Create projection behavior for `ZC_EMPLOYEE`.
10. Create metadata extension `ZC_EMPLOYEE_MDE`.
11. Create service definition `ZUI_EMPLOYEE`.
12. Create an OData V4 UI service binding, e.g. `ZUI_EMPLOYEE_O4`.
13. Activate and publish the binding.
14. Preview the Fiori Elements application.
15. Execute the test cases.

## Message class

Create message class `ZEMPLOYEE`.

Message 001:
`Salary must be at least 30000`