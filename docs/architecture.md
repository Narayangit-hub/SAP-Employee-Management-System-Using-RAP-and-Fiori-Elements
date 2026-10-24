# Architecture

```text
ZEMPLOYEE / ZDEPARTMENT
        |
        v
ZI_EMPLOYEE / ZI_DEPARTMENT
        |
        v
ZC_EMPLOYEE (Projection)
        |
        v
Behavior Definition
 |-- CRUD
 |-- Validation
 |-- Determination
 |-- Promote Action
 `-- Feature Control
        |
        v

Service Definition
        |
        v

OData V4 UI Service Binding
        |
        v
        
Fiori Elements
 |-- List Report
 `-- Object Page
```
