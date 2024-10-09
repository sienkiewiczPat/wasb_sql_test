SELECT 
    e1.employee_id, 
    ARRAY_AGG(e2.employee_id) AS manages
FROM 
    memory.default.employee AS e1
LEFT JOIN 
    memory.default.employee AS e2 ON e1.employee_id = e2.manager_id
GROUP BY e1.employee_id
ORDER BY e1.employee_id;
