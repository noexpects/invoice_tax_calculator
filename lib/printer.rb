# frozen_string_literal: true

class Printer
  def print_message(message)
    puts message
  end

  def print_errors(errors)
    print_message('Validation errors:')

    errors.each do |error|
      print_message("- #{error}")
    end
  end

  def print_items_list(items_list)
    if items_list.empty?
      print_message('No items in the list')
      return
    end

    items_list.each_with_index do |item, index|
      print_message("#{index}: #{item}")
    end
  end

  def print_deleted_item(item_name)
    print_message("Deleted: #{item_name}")
  end

  def print_receipt(receipt)
    receipt.items.each do |item|
      print_message("#{item.quantity} #{item.name}: #{format('%.2f', item.total_price)}")
    end

    print_message("Sales Taxes: #{format('%.2f', receipt.sales_taxes)}")
    print_message("Total: #{format('%.2f', receipt.total)}")
  end
end
