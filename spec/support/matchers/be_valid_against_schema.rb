RSpec::Matchers.define :be_valid_against_schema do |expected|
  # actual here should be a ruby or JSON object, exepcted is the schema name
  # called like: expect(data).to be_valid_against_schema('user')
  match do |actual|
    file_name = File.join(File.dirname(__FILE__), "../..", 'schemas', "#{expected}.json")
      JSON::Validator.validate!(file_name, actual, validate_schema: true)
  end
end
