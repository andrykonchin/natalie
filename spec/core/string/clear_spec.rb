require_relative '../../spec_helper'

describe "String#clear" do
  before :each do
    @s = "Jolene"
  end

  it "sets self equal to the empty String" do
    @s.clear
    @s.should == ""
  end

  it "returns self after emptying it" do
    cleared = @s.clear
    cleared.should == ""
    cleared.should equal @s
  end

  # NATFIXME: Add back once we have encoding.
  xit "preserves its encoding" do
    @s.encode!(Encoding::SHIFT_JIS)
    @s.encoding.should == Encoding::SHIFT_JIS
    @s.clear.encoding.should == Encoding::SHIFT_JIS
    @s.encoding.should == Encoding::SHIFT_JIS
  end

  it "works with multibyte Strings" do
    s = "\u{9765}\u{876}"
    s.clear
    s.should == ""
  end

  it "raises a FrozenError if self is frozen" do
    @s.freeze
    -> { @s.clear        }.should raise_error(FrozenError)
    -> { "".freeze.clear }.should raise_error(FrozenError)
  end
end
