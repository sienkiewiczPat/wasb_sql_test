import os
import re
from datetime import datetime, timedelta
import calendar
import csv

def parse_invoice(file_path):
    """Parses an invoice file and extracts company name, invoice amount, and due date."""
    try:
        with open(file_path, 'r') as f:
            content = f.read()

            company_name_match = re.search(r"Company Name:\s*(.*)", content)
            invoice_amount_match = re.search(r"Invoice Amount:\s*([\d.]+)", content)
            due_date_match = re.search(r"Due Date:\s*(.*)", content)

            if company_name_match and invoice_amount_match and due_date_match:
                company_name = company_name_match.group(1).strip()
                invoice_amount = float(invoice_amount_match.group(1))

                due_date_str = due_date_match.group(1).strip()
                try:
                    months_ahead = int(re.search(r"(\d+)\s+month", due_date_str).group(1))
                    due_date = (datetime.now().replace(day=1) + timedelta(days=32 * months_ahead)).replace(day=1)
                    due_date = due_date.replace(day = calendar.monthrange(due_date.year, due_date.month)[1])
                    due_date_str = due_date.strftime("%Y-%m-%d")

                except (ValueError, AttributeError):
                    print(f"Invalid due date format: {due_date_str} in {file_path}")
                    return None


                return company_name, invoice_amount, due_date_str

            else:
                print(f"Error parsing file: {file_path}")
                return None

    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return None


def process_invoices_directory(invoices_dir, output_csv_path):
    """Parses all invoice files and writes the extracted data to a CSV file."""

    with open(output_csv_path, 'w', newline='', encoding='utf-8') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow(["company_name", "invoice_amount", "due_date"])

        for filename in sorted(os.listdir(invoices_dir)):
            file_path = os.path.join(invoices_dir, filename)
            if os.path.isfile(file_path):
                parsed_data = parse_invoice(file_path)
                if parsed_data:
                    csv_writer.writerow(parsed_data)


invoices_dir = "finance/invoices_due"
output_csv_path = "invoices.csv"
process_invoices_directory(invoices_dir, output_csv_path)