# Hash.to_underscore_keys
class Hash
  # Recursively converts CamelCase hash keys to underscore
  def to_underscore_keys(value = self)
    case value
    when Array
      value.map { |v| to_underscore_keys(v) }
    when Hash
      underscore_hash(value)
    else
      value
    end
  end

  private

  def underscore_hash(value)
    Hash[value.map { |k, v| [underscore_key(k), to_underscore_keys(v)] }]
  end

  def underscore_key(key)
    if key.is_a?(Symbol)
      underscore(key.to_s).to_sym
    elsif key.is_a?(String)
      underscore(key)
    else
      key # can't snakify anything except strings and symbols
    end
  end

  def underscore(camel_cased_word)
    return camel_cased_word unless /[A-Z-]|::/.match?(camel_cased_word)
    word = camel_cased_word.to_s.gsub("::".freeze, "/".freeze)
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
    word.tr!("-".freeze, "_".freeze)
    word.downcase!
    word
  end
end
