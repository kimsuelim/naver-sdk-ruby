require "test_helper"

class ObjectifiedHashTest < Minitest::Spec
  before do
    @hash = { a: 1, b: 2, "string" => "string", symbol: :symbol, items: [{ a: 1 }] }
    @oh = Naver::ObjectifiedHash.new(@hash)
  end

  it "should objectify hash" do
    @oh.a.must_equal @hash[:a]
    @oh.b.must_equal @hash[:b]
    @oh.items.count.must_equal @hash[:items].count
    @oh.items[0].a.must_equal @hash[:items][0][:a]
  end

  describe "#to_hash" do
    it "should return an original hash" do
      @oh.to_hash.must_equal @hash
    end

    it "should have an alias #to_h" do
      @oh.respond_to?(:to_h).must_equal true
    end
  end

  describe "#inspect" do
    it "should return a formatted string" do
      pretty_string = "#<#{@oh.class.name}:#{@oh.object_id} {hash: #{@hash}}"
      @oh.inspect.must_equal pretty_string
    end
  end

  describe "#respond_to" do
    it "should return true for methods this object responds to through method_missing as sym" do
      @oh.respond_to?(:a).must_equal true
    end

    it "should return true for methods this object responds to through method_missing as string" do
      @oh.respond_to?("string").must_equal true
    end

    it "should not care if you use a string or symbol to reference a method" do
      @oh.respond_to?(:string).must_equal true
    end

    it "should not care if you use a string or symbol to reference a method" do
      @oh.respond_to?("symbol").must_equal true
    end
  end
end
