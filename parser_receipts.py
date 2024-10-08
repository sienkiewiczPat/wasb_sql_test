import os
import re
import csv


def parse_receipt(file_path):
    """Parses a receipt file and extracts employee name, unit price, and quantity."""

    try:
        with open(file_path, 'r') as f:
            content = f.read()

            employee_match = re.search(r"Employee:\s*(.*)", content)
            unit_price_match = re.search(r"Unit Price:\s*([\d.]+)", content)
            quantity_match = re.search(r"Quantity:\s*(\d+)", content)

            if employee_match and unit_price_match and quantity_match:
                employee_name = employee_match.group(1).strip()
                unit_price = float(unit_price_match.group(1))
                quantity = int(quantity_match.group(1))
                return employee_name, unit_price, quantity
            else:
                print(f"Error parsing file: {file_path}")
                return None

    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return None


def process_receipts_directory(receipts_dir, output_csv_path):
    """Parses all receipt files and writes the extracted data to a CSV file."""

    with open(output_csv_path, 'w', newline='', encoding='utf-8') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow(["employee_name", "unit_price", "quantity"])

        for filename in os.listdir(receipts_dir):
            file_path = os.path.join(receipts_dir, filename)
            if os.path.isfile(file_path):
                parsed_data = parse_receipt(file_path)
                if parsed_data:
                    employee_name, unit_price, quantity = parsed_data
                    csv_writer.writerow([employee_name, unit_price, quantity])


# Example usage:
receipts_dir = "finance/receipts_from_last_night"
output_csv_path = "expenses.csv"

process_receipts_directory(receipts_dir, output_csv_path)
