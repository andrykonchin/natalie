describe :string_replace, shared: true do
  it "returns self" do
    a = "a"
    a.send(@method, "b").should equal(a)
  end

  it "replaces the content of self with other" do
    a = "some string"
    a.send(@method, "another string")
    a.should == "another string"
  end

  ruby_version_is ''...'2.7' do
    it "taints self if other is tainted" do
      a = ""
      b = "".taint
      a.send(@method, b)
      a.should.tainted?
    end

    it "does not untaint self if other is untainted" do
      a = "".taint
      b = ""
      a.send(@method, b)
      a.should.tainted?
    end

    it "untrusts self if other is untrusted" do
      a = ""
      b = "".untrust
      a.send(@method, b)
      a.should.untrusted?
    end

    it "does not trust self if other is trusted" do
      a = "".untrust
      b = ""
      a.send(@method, b)
      a.should.untrusted?
    end
  end

  it "replaces the encoding of self with that of other" do
    # NATFIXME: Implement Encoding::UTF-16LE
    #a = "".encode("UTF-16LE")
    a = "".encode("US-ASCII")
    b = "".encode("UTF-8")
    a.send(@method, b)
    a.encoding.should == Encoding::UTF_8
  end

  it "carries over the encoding invalidity" do
    a = "\u{8765}".force_encoding('ascii')
    "".send(@method, a).valid_encoding?.should be_false
  end

  it "tries to convert other to string using to_str" do
    other = mock('x')
    other.should_receive(:to_str).and_return("converted to a string")
    "hello".send(@method, other).should == "converted to a string"
  end

  it "raises a TypeError if other can't be converted to string" do
    -> { "hello".send(@method, 123)       }.should raise_error(TypeError)
    -> { "hello".send(@method, [])        }.should raise_error(TypeError)
    -> { "hello".send(@method, mock('x')) }.should raise_error(TypeError)
  end

  it "raises a FrozenError on a frozen instance that is modified" do
    a = "hello".freeze
    -> { a.send(@method, "world") }.should raise_error(FrozenError)
  end

  # see [ruby-core:23666]
  it "raises a FrozenError on a frozen instance when self-replacing" do
    a = "hello".freeze
    -> { a.send(@method, a) }.should raise_error(FrozenError)
  end
end
