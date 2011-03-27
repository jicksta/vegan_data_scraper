require 'mechanize'

class DetailsPage

  BR = /<br\s*\/?>/i

  def self.from_url(url)
    page = Mechanize.new.get(url)
    new(page)
  end

  def initialize(page=Mechanize.new)
    @page = page
  end

  def company_name
    @page.search("#content h1").text[/^(.+):[^:]+$/, 1]
  rescue
    nil
  end

  def address
    content_node = value_node_for_table_row "Address"
    content_node.children.to_html.split(BR).map(&:strip)
  end

  def phone_number
    value_text_for_table_row "Phone"
  end

  def fax_number
    value_text_for_table_row "Fax"
  end

  def contact_email
    value_text_for_table_row "Email"
  end

  def url
    value_text_for_table_row "URL"
  end

  def first_checker_name
    value_text_for_table_row "Checked by"
  end

  def date_added
    value_text_for_table_row "Added"
  end

  def date_updated
    value_text_for_table_row "Last updated"
  end

  def double_checker_name
    name = value_text_for_table_row "Double Checked by"
    case name
      when /Nobody Yet/i
        :nobody
      else
        name
    end
  end

  def products
    products_table = @page.search("p:contains('Products')").first.next_element
    product_data_pairs = products_table.search("tr td").to_a.in_groups_of(2)
    product_data_pairs.inject(ActiveSupport::OrderedHash.new) do |table_hash, (product_name, veganosity)|
      table_hash[product_name.inner_text.strip] = parse_veganosity veganosity.inner_text
      table_hash
    end
  end

  def company_email
    email_element = @page.search("p").find { |element| element.inner_text =~ /Company Email/i }
    if email_element.present?
      lines = email_element.inner_html.split(BR).map(&:strip)
      lines.shift
      lines.join("\n")
    end
  end

  private

  def value_node_for_table_row(name)
    cells = @page.search("#content tr > td:first")
    key_cell = cells.find { |node| node.inner_text.include? name } and key_cell.next_element
  end

  def value_text_for_table_row(name)
    node = value_node_for_table_row(name)
    node.inner_text.strip if node
  end

  def parse_veganosity(veganosity)
    veganosity.strip == "Vegan Friendly"
  end

end