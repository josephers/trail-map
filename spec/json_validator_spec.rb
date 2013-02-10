require 'spec_helper'
require 'awesome_print'

describe JSONValidator, '#run' do
  it 'uses a schema file' do
    dir = File.dirname(__FILE__)
    file_name = File.open(dir + '/fixtures/valid.json').read

    result = JSON::Validator.
      fully_validate('lib/helpers/schema.json', file_name)

    ap result
  end

  it 'returns true and outputs a dot if the JSON is valid' do
    $stdout = io = StringIO.new
    dir = File.dirname(__FILE__)
    file_name = File.open(dir + '/fixtures/valid.json')

    result = JSONValidator.new(file_name).run

    result.should be_true
    io.string.should eq '.'
  end


  it 'returns false and outputs an error if the JSON is not valid' do
    $stdout = io = StringIO.new
    dir = File.dirname(__FILE__)
    file_name = File.open(dir + '/fixtures/invalid.json')

    result = JSONValidator.new(file_name).run

    result.should be_false
    io.string.should =~ /ERROR/
  end
end
