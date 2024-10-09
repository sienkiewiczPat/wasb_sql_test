CREATE TABLE tmp_expenses (
    employee_name VARCHAR(255),
    unit_price DECIMAL(8, 2),
    quantity INT
);

-- load data from expenses.csv
INSERT INTO tmp_expenses (employee_name, unit_price, quantity) VALUES
('Alex Jacobson', 13.00, 75),
('Alex Jacobson', 22.00, 18),
('Darren Poynton', 40.00, 9),
('Andrea Ghibaudi', 300.00, 1),
('Umberto Torrielli', 17.50, 4),
('Alex Jacobson', 11.00, 20),
('Alex Jacobson', 6.50, 14);

CREATE TABLE EXPENSE (
    employee_id TINYINT,
    unit_price DECIMAL(8, 2),
    quantity TINYINT
);

INSERT INTO EXPENSE (employee_id, unit_price, quantity)
SELECT e.employee_id, te.unit_price, te.quantity
FROM tmp_expenses te
JOIN employee e ON te.employee_name = e.first_name || ' ' || e.last_name;
