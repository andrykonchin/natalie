require_relative '../../spec_helper'
require_relative 'fixtures/classes'

describe "Kernel#p" do
  before :all do
    @rs_f, @rs_b, @rs_c = $/, $\, $,
  end

  after :each do
    suppress_warning {
      $/, $\, $, = @rs_f, @rs_b, @rs_c
    }
  end

  it "is a private method" do
    Kernel.should have_private_instance_method(:p)
  end

  # TODO: fix
  # NATFIXME: add tmp() and $$
  xit "flushes output if receiver is a File" do
    filename = tmp("Kernel_p_flush") + $$.to_s
    begin
      File.open(filename, "w") do |f|
        begin
          old_stdout = $stdout
          $stdout = f
          p("abcde")
        ensure
          $stdout = old_stdout
        end

        File.open(filename) do |f2|
          f2.read(7).should == "\"abcde\""
        end
      end
    ensure
      rm_r filename
    end
  end

  it "prints obj.inspect followed by system record separator for each argument given" do
    o = mock("Inspector Gadget")
    o.should_receive(:inspect).any_number_of_times.and_return "Next time, Gadget, NEXT TIME!"

    -> { p(o) }.should output("Next time, Gadget, NEXT TIME!\n")
    -> { p(*[o]) }.should output("Next time, Gadget, NEXT TIME!\n")
    -> { p(*[o, o]) }.should output("Next time, Gadget, NEXT TIME!\nNext time, Gadget, NEXT TIME!\n")
    -> { p([o])}.should output("[#{o.inspect}]\n")
  end

  it "is not affected by setting $\\, $/ or $," do
    o = mock("Inspector Gadget")
    o.should_receive(:inspect).any_number_of_times.and_return "Next time, Gadget, NEXT TIME!"

    suppress_warning {
      $, = " *helicopter sound*\n"
    }
    -> { p(o) }.should output_to_fd("Next time, Gadget, NEXT TIME!\n")

    suppress_warning {
      $\ = " *helicopter sound*\n"
    }
    -> { p(o) }.should output_to_fd("Next time, Gadget, NEXT TIME!\n")

    suppress_warning {
      $/ = " *helicopter sound*\n"
    }
    -> { p(o) }.should output_to_fd("Next time, Gadget, NEXT TIME!\n")
  end

  it "prints nothing if no argument is given" do
    -> { p }.should output("")
  end

  it "prints nothing if called splatting an empty Array" do
    -> { p(*[]) }.should output("")
  end

=begin Not sure how to spec this, but wanted to note the behavior here
  it "does not flush if receiver is not a TTY or a File" do
  end
=end
end

describe "Kernel.p" do
  it "needs to be reviewed for spec completeness"
end
