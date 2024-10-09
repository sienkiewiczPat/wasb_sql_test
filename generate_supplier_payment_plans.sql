WITH invoice_payments AS (
    SELECT
        supplier_id,
        invoice_amount,
        due_date,
        date_trunc('month', date_add('month', n, current_date)) AS payment_date
    FROM 
        invoice, 
        UNNEST(SEQUENCE(1, date_diff('month', current_date, due_date))) AS t(n)
),
payment_schedule AS (
    SELECT
        ip.supplier_id,
        s.name AS supplier_name,
        ip.payment_date,
        invoice_amount / (date_diff('month', current_date, due_date)) AS payment_amount,
        invoice_amount,
        due_date,
        ROW_NUMBER() OVER (PARTITION BY ip.supplier_id, due_date ORDER BY ip.payment_date) AS row_num,
        date_diff('month', current_date, due_date) + 1 AS total_payments
    FROM 
        invoice_payments ip
    JOIN supplier s ON ip.supplier_id = s.supplier_id
)
SELECT 
    supplier_id, 
    supplier_name, 
    SUM(payment_amount) payment_amount, 
    SUM(balance_outstanding) balance_outstanding, 
    payment_date 
FROM (
    SELECT
        supplier_id,
        supplier_name,
        payment_amount,
        invoice_amount - payment_amount * row_num AS balance_outstanding,
        payment_date
    FROM
        payment_schedule
) AS payment_details
GROUP BY 
    supplier_id,
    supplier_name,
    payment_date
ORDER BY
    supplier_id,
    payment_date;
