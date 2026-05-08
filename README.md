# Invoice Tax Calculator

A Ruby-based command-line application to manage and calculate sales taxes for invoices.

## Features
- Add items to an invoice with details like quantity, name, and price.
- Display the list of items in the invoice.
- Delete items from the invoice.
- Automatically calculate sales taxes (basic and import duties) for each item.
- Generate a detailed receipt with sales tax and total price.

---

## Requirements
- Ruby 3.0.0 or higher
- Bundler

## Setup Instructions
Follow the steps below to set up and run the application:

### 1. Clone the repository

```bash
git clone git@github.com:noexpects/invoice_tax_calculator.git
cd invoice_tax_calculator
```


### 2. Install dependencies
Run the following command to install project dependencies:

```bash
bundle install
```


### 3. Verify Configuration
Ensure that `goods_config.yaml` (in the `data` folder) is correctly populated for taxable and non-taxable goods. The YAML file must define:
- **Basic Tax Rate** for goods that are not exempt.
- **Import Duty Rate** for imported goods.
- A list of tax-exempt items (e.g., food, chocolate, pills).

---

## Running the Application

1. Launch the application:
   ```bash
   ruby main.rb
   ```

2. You will be greeted with an interactive prompt:
   ```
   Invoice Tax Calculator App
   Supported commands: add_item, list_items, delete_item, generate_invoice, exit
   >
   ```

3. Use the following commands:
    - **Add an item**:
      ```text
      add_item <quantity> <item_name> at <price>
      ```
      Example: `add_item 2 book at 12.49`

    - **List all items**:
      ```text
      list_items
      ```

    - **Delete an item**:
      ```text
      delete_item <index>
      ```
      Notice: `<index>` here is a number obtained from `list_items` command.
      Example: `delete_item 1`

    - **Generate the receipt**:
      ```text
      generate_invoice
      ```
      This will display the receipt with:
        - Each item's quantity, name, and total price after tax.
        - Total sales tax and overall amount.

    - **Exit the application**:
      ```text
      exit
      ```

---

## Developer Notes

### Assumptions:
1. **Tax Values**:
    - Basic tax and import duty rates are defined in `goods_config.yaml`.
    - All tax calculations round up to the nearest 0.05 based on the `ROUNDING_FACTOR` in `TaxCalculator`.

2. **Command Format**:
    - The system strictly requires commands in the defined format. For example:
        - **Add Item**: Requires `quantity`, `name`, and `price`. Incorrect formats result in validation errors.
        - Example of correct format: `add_item 1 imported book at 20.00`.

3. **Validation**:
    - Input is validated for correct formats and logical constraints. Covered scenarious:
      - Invalid input format 
      - Empty input 
      - Negative prices or quantities 
      - Invalid item entries

4. **Imported Items**:
    - The word `imported` in the item's name indicates an imported item.

5. **Tax-Exempt Items**:
    - Configured in the `goods_config.yaml` (`exempt_keywords` key).

6. **Valid Goods**:
    - Configured in the `goods_config.yaml` (`goods` key).


## Class Responsibilities
- **Item**: Value object representing a shopping item

    - Determines if item is imported
    - Calculates total price with quantity


- **TaxCalculator**: Pure calculation service

    - Handles tax calculation logic
    - Implements rounding rules
    - Separates basic tax and import duty calculations


- **Receipt**: Aggregates items and total calculations

    - Handles item orchestration
    - Maintains a collection of items


- **CommandProcessor**: Handles input processing

    - Orchestrates command execution
    - Creates Item instances
    - Manages output
    

- **InputValidator**: Validates input format
    
    - Applies validation rules to input data
    - Provides clear error messages


- **ValidationResult**: Manages validation results
    
    - Contains validation error messages
    - Contains validated data


- **Printer**: Manages output presentation
    
    - Handles output formatting
    - Provides consistent output interface


- **GoodsConfig**: Manages access to app configuration
    
    - Loads configuration from YAML file
    - Provides access to tax rates and exempt goods

---

## Testing

This project includes unit tests written using RSpec. To run the tests, use:

```bash
  bundle exec rspec
```

Test coverage includes:
- Command validation
- Tax calculation logic
- Input validation
- Printing of receipts and messages

---

## Supported test cases

The tax calculation logic and input parsing are optimized for these exact cases.

### Input
#### Input 1:
```
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

#### Input 2:
```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

#### Input 3:
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

### Output

#### Output 1:
```
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

#### Output 2:
```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```

#### Output 3:
```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```
