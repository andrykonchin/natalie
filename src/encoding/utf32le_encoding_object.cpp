#include "natalie.hpp"
#include <stdio.h>

namespace Natalie {

std::pair<bool, StringView> Utf32LeEncodingObject::prev_char(const String &string, size_t *index) const {
    if (*index == 0)
        return { true, StringView() };

    if (*index < 4) {
        (*index)--;
        return { false, StringView(&string, *index, 1) };
    }

    size_t i = *index - 4;

    // check codepoint
    StringView character = StringView(&string, i, 4);
    nat_int_t codepoint = decode_codepoint(character);
    if (codepoint < 0 || codepoint > 0x10FFFF || (codepoint >= 0xD800 && codepoint <= 0xDFFF)) {
        (*index)++;
        return { false, StringView(&string, i) };
    }

    *index -= 4;
    return { true, StringView(&string, i, 4) };
}

std::pair<bool, StringView> Utf32LeEncodingObject::next_char(const String &string, size_t *index) const {
    if (*index >= string.size())
        return { true, StringView() };

    size_t i = *index;

    if (*index + 4 > string.size()) {
        (*index)++;
        return { false, StringView(&string, i) };
    }

    // check codepoint
    StringView character = StringView(&string, i, 4);
    nat_int_t codepoint = decode_codepoint(character);
    if (codepoint < 0 || codepoint > 0x10FFFF || (codepoint >= 0xD800 && codepoint <= 0xDFFF)) {
        (*index)++;
        return { false, StringView(&string, i) };
    }

    (*index) += 4;
    return { true, StringView(&string, i, 4) };
}

String Utf32LeEncodingObject::escaped_char(unsigned char c) const {
    char buf[7];
    snprintf(buf, 7, "\\u%04llX", (long long)c);
    return String(buf);
}

nat_int_t Utf32LeEncodingObject::to_unicode_codepoint(nat_int_t codepoint) const {
    return codepoint;
}

nat_int_t Utf32LeEncodingObject::from_unicode_codepoint(nat_int_t codepoint) const {
    return codepoint;
}

String Utf32LeEncodingObject::encode_codepoint(nat_int_t codepoint) const {
    String buf;

    buf.append_char(codepoint & 0xFF);
    buf.append_char((codepoint >> 8) & 0xFF);
    buf.append_char((codepoint >> 16) & 0xFF);
    buf.append_char(0);

    return buf;
}

nat_int_t Utf32LeEncodingObject::decode_codepoint(StringView &str) const {
    if (str.size() != 4) {
        return -1;
    }

    return (unsigned char)str[0]
        + ((unsigned char)str[1] << 8)
        + ((unsigned char)str[2] << 16)
        + ((unsigned char)str[3] << 24);
}

}
