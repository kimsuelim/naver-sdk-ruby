class Hash
  # Returns a new hash with all keys converted using the +block+ operation.
  def transform_keys
    return enum_for(:transform_keys) { size } unless block_given?
    result = {}
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end unless method_defined?(:transform_keys)

  # Returns a new hash with all keys converted to underscore strings.
  #
  #   hash = { firstName: "Rob", lastName: "Bob" }
  #
  #   hash.underscore_keys
  #   # => {:first_name=>"Rob", :last_name=>"Bob"}
  def underscore_keys
    transform_keys { |key| underscore_key(key) }
  end

  # Returns a new hash with all keys converted to camelcase strings.
  #
  #   hash = { first_name: "Rob", last_name: "Bob" }
  #
  #   hash.camelize_keys
  #   # => {:firstName=>"Rob", :lastName=>"Bob"}
  def camelize_keys
    transform_keys { |key| camelize_key(key) }
  end

  # Returns a new hash with all keys converted to underscore strings.
  # This includes the keys from the root hash and from all
  # nested hashes and arrays.
  #
  #  hash = { person: { firstName: "Rob", lastName: "Bob" } }
  #
  #  hash.deep_underscore_keys
  #  # => {:person=>{:first_name=>"Rob", :last_name=>"Bob"}}
  def deep_underscore_keys
    deep_transform_keys_in_object(self) { |key| underscore_key(key) }
  end

  # Returns a new hash with all keys converted to camelcase strings.
  # This includes the keys from the root hash and from all
  # nested hashes and arrays.
  #
  #  hash = { person: { first_name: "Rob", last_name: "Bob" } }
  #
  #  hash.deep_camelize_keys
  #  # => {:person=>{:firstName=>"Rob", :lastName=>"Bob"}}
  def deep_camelize_keys
    deep_transform_keys_in_object(self) { |key| camelize_key(key) }
  end

  private

  # support methods for deep transforming nested hashes and arrays
  def deep_transform_keys_in_object(object, &block)
    case object
    when Array
      object.map { |e| deep_transform_keys_in_object(e, &block) }
    when Hash
      object.each_with_object({}) do |(key, value), result|
        result[yield(key)] = deep_transform_keys_in_object(value, &block)
      end
      # Hash[object.map { |key, value| [yield(key), deep_transform_keys_in_object(value, &block)] }]
    else
      object
    end
  end

  def underscore_key(key)
    if key.is_a?(Symbol)
      underscore(key.to_s).to_sym
    elsif key.is_a?(String)
      underscore(key)
    else
      key
    end
  end

  def underscore(camel_cased_word)
    return camel_cased_word unless camel_cased_word =~ /[A-Z-]|::/
    word = camel_cased_word.to_s.gsub("::".freeze, "/".freeze)
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
    word.tr!("-".freeze, "_".freeze)
    word.downcase!
    word
  end

  def camelize_key(key)
    if key.is_a?(Symbol)
      camelize(key.to_s, :lower).to_sym
    elsif key.is_a?(String)
      camelize(key, :lower)
    else
      key
    end
  end

  def camelize(underscore_word, first_letter = :upper)
    word = underscore_word.to_s
    case first_letter
    when :upper
      word = word.sub(/^[a-z\d]*/) { $&.capitalize }
    when :lower
      word = word.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
    end

    word.gsub!(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }
    word.gsub!(/\//, "::".freeze)
    word
  end
end
