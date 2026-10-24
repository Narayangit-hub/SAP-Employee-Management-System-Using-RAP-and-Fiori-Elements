# Employee Management System — SAP RAP

End-to-end SAP RAP portfolio/learning project using ABAP RAP, CDS, OData V4 and Fiori Elements.

## Features
- Employee CRUD
- Salary validation (minimum 30000)
- Salary status determination
- Promote Employee action (+20%)
- Department association
- Instance feature control
- Locking and ETag concepts
- Projection CDS and projection behavior
- OData V4 UI service
- Fiori Elements
- Test cases and architecture notes

## Business Rules
- Salary below 30000 is rejected.
- Salary < 30000 → Status 1
- Salary 30000–60000 → Status 2
- Salary > 60000 → Status 3
- Promotion increases salary by 20%.
- Promotion is disabled for retired employees (`EmployeeStatus = 'R'`).

## Setup
Create the objects in ADT in the order documented in `docs/setup-guide.md`.
Create message class `ZEMPLOYEE`, message 001: `Salary must be at least 30000`.

Then create and publish an OData V4 UI Service Binding for `ZUI_EMPLOYEE`.

> Syntax can vary by SAP S/4HANA / ABAP release and ADT version. Activate and test in your target system.
