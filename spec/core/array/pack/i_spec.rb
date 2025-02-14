require_relative '../../../spec_helper'
require_relative '../fixtures/classes'
require_relative 'shared/basic'
require_relative 'shared/numeric_basic'
require_relative 'shared/integer'

describe "Array#pack with format 'I'" do
  it_behaves_like :array_pack_basic, 'I'
  it_behaves_like :array_pack_basic_non_float, 'I'
  it_behaves_like :array_pack_arguments, 'I'
  it_behaves_like :array_pack_numeric_basic, 'I'
  it_behaves_like :array_pack_integer, 'I'
end

describe "Array#pack with format 'i'" do
  it_behaves_like :array_pack_basic, 'i'
  it_behaves_like :array_pack_basic_non_float, 'i'
  it_behaves_like :array_pack_arguments, 'i'
  it_behaves_like :array_pack_numeric_basic, 'i'
  it_behaves_like :array_pack_integer, 'i'
end

# NATFIXME: < modifier
xdescribe "Array#pack with format 'I'" do
  describe "with modifier '<'" do
    it_behaves_like :array_pack_32bit_le, 'I<'
  end

  describe "with modifier '<' and '_'" do
    it_behaves_like :array_pack_32bit_le, 'I<_'
    it_behaves_like :array_pack_32bit_le, 'I_<'
  end

  describe "with modifier '<' and '!'" do
    it_behaves_like :array_pack_32bit_le, 'I<!'
    it_behaves_like :array_pack_32bit_le, 'I!<'
  end

  describe "with modifier '>'" do
    it_behaves_like :array_pack_32bit_be, 'I>'
  end

  describe "with modifier '>' and '_'" do
    it_behaves_like :array_pack_32bit_be, 'I>_'
    it_behaves_like :array_pack_32bit_be, 'I_>'
  end

  describe "with modifier '>' and '!'" do
    it_behaves_like :array_pack_32bit_be, 'I>!'
    it_behaves_like :array_pack_32bit_be, 'I!>'
  end
end

# NATFIXME: < modifier
xdescribe "Array#pack with format 'i'" do
  describe "with modifier '<'" do
    it_behaves_like :array_pack_32bit_le, 'i<'
  end

  describe "with modifier '<' and '_'" do
    it_behaves_like :array_pack_32bit_le, 'i<_'
    it_behaves_like :array_pack_32bit_le, 'i_<'
  end

  describe "with modifier '<' and '!'" do
    it_behaves_like :array_pack_32bit_le, 'i<!'
    it_behaves_like :array_pack_32bit_le, 'i!<'
  end

  describe "with modifier '>'" do
    it_behaves_like :array_pack_32bit_be, 'i>'
  end

  describe "with modifier '>' and '_'" do
    it_behaves_like :array_pack_32bit_be, 'i>_'
    it_behaves_like :array_pack_32bit_be, 'i_>'
  end

  describe "with modifier '>' and '!'" do
    it_behaves_like :array_pack_32bit_be, 'i>!'
    it_behaves_like :array_pack_32bit_be, 'i!>'
  end
end

little_endian do
  describe "Array#pack with format 'I'" do
    it_behaves_like :array_pack_32bit_le, 'I'
  end

  # NATFIXME: _ modifier
  xdescribe "Array#pack with format 'I' with modifier '_'" do
    it_behaves_like :array_pack_32bit_le_platform, 'I_'
  end

  # NATFIXME: ! modifier
  xdescribe "Array#pack with format 'I' with modifier '!'" do
    it_behaves_like :array_pack_32bit_le_platform, 'I!'
  end

  describe "Array#pack with format 'i'" do
    it_behaves_like :array_pack_32bit_le, 'i'
  end

  # NATFIXME: _ modifier
  xdescribe "Array#pack with format 'i' with modifier '_'" do
    it_behaves_like :array_pack_32bit_le_platform, 'i_'
  end

  # NATFIXME: ! modifier
  xdescribe "Array#pack with format 'i' with modifier '!'" do
    it_behaves_like :array_pack_32bit_le_platform, 'i!'
  end
end

big_endian do
  describe "Array#pack with format 'I'" do
    it_behaves_like :array_pack_32bit_be, 'I'
  end

  describe "Array#pack with format 'I' with modifier '_'" do
    it_behaves_like :array_pack_32bit_be_platform, 'I_'
  end

  describe "Array#pack with format 'I' with modifier '!'" do
    it_behaves_like :array_pack_32bit_be_platform, 'I!'
  end

  describe "Array#pack with format 'i'" do
    it_behaves_like :array_pack_32bit_be, 'i'
  end

  describe "Array#pack with format 'i' with modifier '_'" do
    it_behaves_like :array_pack_32bit_be_platform, 'i_'
  end

  describe "Array#pack with format 'i' with modifier '!'" do
    it_behaves_like :array_pack_32bit_be_platform, 'i!'
  end
end
