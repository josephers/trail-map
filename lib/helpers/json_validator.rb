class JSONValidator
  SCHEMA = 'lib/helpers/schema.json'

  def initialize(file_name)
    @file_name = file_name
    @contents = File.open(@file_name).read
  end

  def run
    check_json_validation
  end

  private

  def check_json_validation
    if valid_json?
      print_progress_marker
      true
    else
      print_error_message
      false
    end
  end

  def valid_json?
    begin
      puts
      ap JSON::Validator.fully_validate(SCHEMA, @contents)
      puts

      true
    # rescue Exception => e
    #   false
    end
  end

  def print_progress_marker
    print '.'
  end

  def print_error_message
    puts "\nERROR: #{@file_name} is not valid JSON. Learn more:"
    puts "cat #{@file_name} | pbcopy; open http://jsonlint.com"
  end
end
