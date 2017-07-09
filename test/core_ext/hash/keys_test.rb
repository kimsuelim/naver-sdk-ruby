require "test_helper"

class KeysTest < Minitest::Spec
  def setup
    @camelcase_strings = { "aA" => 1, "bB" => 2 }
    @camelcase_symbols = { aA: 1, bB: 2 }
    @camelcase_mixed = { :aA => 1, "bB" => 2 }
    @underscore_strings = { "a_a" => 1, "b_b" => 2 }
    @underscore_symbols = { a_a: 1, b_b: 2 }
    @underscore_mixed = { :a_a => 1, "b_b" => 2 }

    @nested_camel_case_strings = { "aA" => { "bB" => { "cC" => 3 } } }
    @nested_camel_case_symbols = { aA: { bB: { cC: 3 } } }
    @nested_camel_case_mixed = { "aA" => { bB: { "cC" => 3 } } }
    @nested_underscore_strings = { "a_a" => { "b_b" => { "c_c" => 3 } } }
    @nested_underscore_symbols = { a_a: { b_b: { c_c: 3 } } }
    @nested_underscore_mixed = { "a_a" => { b_b: { "c_c" => 3 } } }

    @camelcase_string_array_of_hashes = { "aA" => [{ "bB" => 2 }, { "cC" => 3 }, 4] }
    @camelcase_symbol_array_of_hashes = { aA: [{ bB: 2 }, { cC: 3 }, 4] }
    @camelcase_mixed_array_of_hashes = { aA: [{ bB: 2 }, { "cC" => 3 }, 4] }
    @underscore_string_array_of_hashes = { "a_a" => [{ "b_b" => 2 }, { "c_c" => 3 }, 4] }
    @underscore_symbol_array_of_hashes = { a_a: [{ b_b: 2 }, { c_c: 3 }, 4] }
    @underscore_mixed_array_of_hashes = { a_a: [{ b_b: 2 }, { "c_c" => 3 }, 4] }
  end

  it "underscore_keys" do
    @camelcase_strings.underscore_keys.must_equal @underscore_strings
    @camelcase_symbols.underscore_keys.must_equal @underscore_symbols
    @camelcase_mixed.underscore_keys.must_equal @underscore_mixed
  end

  it "camelize_keys" do
    @underscore_strings.camelize_keys.must_equal @camelcase_strings
    @underscore_symbols.camelize_keys.must_equal @camelcase_symbols
    @underscore_mixed.camelize_keys.must_equal @camelcase_mixed
  end

  it "deep_underscore_keys" do
    @nested_camel_case_strings.deep_underscore_keys.must_equal @nested_underscore_strings
    @nested_camel_case_symbols.deep_underscore_keys.must_equal @nested_underscore_symbols
    @nested_camel_case_mixed.deep_underscore_keys.must_equal @nested_underscore_mixed
    @camelcase_string_array_of_hashes.deep_underscore_keys.must_equal @underscore_string_array_of_hashes
    @camelcase_symbol_array_of_hashes.deep_underscore_keys.must_equal @underscore_symbol_array_of_hashes
    @camelcase_mixed_array_of_hashes.deep_underscore_keys.must_equal @underscore_mixed_array_of_hashes
  end

  it "deep_camelize_keys" do
    @nested_underscore_strings.deep_camelize_keys.must_equal @nested_camel_case_strings
    @nested_underscore_symbols.deep_camelize_keys.must_equal @nested_camel_case_symbols
    @nested_underscore_mixed.deep_camelize_keys.must_equal @nested_camel_case_mixed
    @underscore_string_array_of_hashes.deep_camelize_keys.must_equal @camelcase_string_array_of_hashes
    @underscore_symbol_array_of_hashes.deep_camelize_keys.must_equal @camelcase_symbol_array_of_hashes
    @underscore_mixed_array_of_hashes.deep_camelize_keys.must_equal @camelcase_mixed_array_of_hashes
  end
end
