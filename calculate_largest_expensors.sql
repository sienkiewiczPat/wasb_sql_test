WITH employee_expenses AS (
    SELECT 
        e.employee_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        e.manager_id,
        SUM(ex.unit_price * ex.quantity) AS total_expensed_amount
    FROM 
        EMPLOYEE e
    JOIN 
        EXPENSE ex ON e.employee_id = ex.employee_id
    GROUP BY 
        e.employee_id, e.first_name, e.last_name, e.manager_id
    HAVING 
        SUM(ex.unit_price * ex.quantity) > 1000  
)
SELECT 
    ee.employee_id,
    ee.employee_name,
    ee.manager_id,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    ee.total_expensed_amount
FROM 
    employee_expenses ee
JOIN 
    EMPLOYEE m ON ee.manager_id = m.employee_id
ORDER BY 
    ee.total_expensed_amount DESC;
