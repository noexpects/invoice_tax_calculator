# frozen_string_literal: true

RSpec.describe 'Invoice Tax Calculator Integration' do
  describe 'processing receipts' do
    it 'processes input 1 correctly' do
      input = <<~INPUT
        add_item 2 book at 12.49
        add_item 1 music CD at 14.99
        add_item 1 chocolate bar at 0.85
        generate_invoice
        exit
      INPUT

      expected_output = <<~OUTPUT
        Invoice Tax Calculator App
        Supported commands: add_item, list_items, delete_item, generate_invoice, exit

        > Item added
        
        > Item added

        > Item added
        
        > 2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
        
        > Goodbye!
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(*input.lines)
        Main.new.run
      end.to output(expected_output).to_stdout
    end

    it 'processes input 2 correctly' do
      input = <<~INPUT
        add_item 1 imported box of chocolates at 10.00
        add_item 1 imported bottle of perfume at 47.50
        generate_invoice
        exit
      INPUT

      expected_output = <<~OUTPUT
        Invoice Tax Calculator App
        Supported commands: add_item, list_items, delete_item, generate_invoice, exit

        > Item added
        
        > Item added
        
        > 1 imported box of chocolates: 10.50
        1 imported bottle of perfume: 54.65
        Sales Taxes: 7.65
        Total: 65.15
        
        > Goodbye!
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(*input.lines)
        Main.new.run
      end.to output(expected_output).to_stdout
    end

    it 'processes input 3 correctly' do
      input = <<~INPUT
        add_item 1 imported bottle of perfume at 27.99
        add_item 1 bottle of perfume at 18.99
        add_item 1 packet of headache pills at 9.75
        add_item 3 imported boxes of chocolates at 11.25
        generate_invoice
        exit
      INPUT

      expected_output = <<~OUTPUT
        Invoice Tax Calculator App
        Supported commands: add_item, list_items, delete_item, generate_invoice, exit

        > Item added
        
        > Item added

        > Item added

        > Item added
        
        > 1 imported bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 packet of headache pills: 9.75
        3 imported boxes of chocolates: 35.55
        Sales Taxes: 7.90
        Total: 98.38
        
        > Goodbye!
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(*input.lines)
        Main.new.run
      end.to output(expected_output).to_stdout
    end
  end
end
