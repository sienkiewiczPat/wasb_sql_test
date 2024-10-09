CREATE TABLE SUPPLIER (
    supplier_id TINYINT,
    name VARCHAR(255)
);

CREATE TABLE INVOICE (
    supplier_id TINYINT,
    invoice_amount DECIMAL(8, 2),
    due_date DATE
);


INSERT INTO SUPPLIER (supplier_id, name) VALUES
(1, 'Catering Plus'),
(2, 'Dave''s Discos'),
(3, 'Entertainment tonight'),
(4, 'Ice Ice Baby'),
(5, 'Party Animals');


INSERT INTO INVOICE (supplier_id, invoice_amount, due_date) VALUES
(1, 2000.00, DATE('2024-12-31')),
(1, 1500.00, DATE('2025-01-31')),
(2, 500.00, DATE('2024-11-30')),
(3, 6000.00, DATE('2025-01-31')),
(4, 4000.00, DATE('2025-04-30')),
(5, 6000.00, DATE('2025-01-31'));
