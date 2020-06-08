#include "natalie.hpp"
#include "natalie/builtin.hpp"

namespace Natalie {

Value *Encoding_list(Env *env, Value *self_value, ssize_t argc, Value **args, Block *block) {
    ArrayValue *ary = array_new(env);
    ClassValue *self = self_value->as_class();
    array_push(env, ary, self->const_get(env, "ASCII_8BIT", true));
    array_push(env, ary, self->const_get(env, "UTF_8", true));
    return ary;
}

Value *Encoding_inspect(Env *env, Value *self_value, ssize_t argc, Value **args, Block *block) {
    NAT_ASSERT_ARGC(0);
    EncodingValue *self = self_value->as_encoding();
    return StringValue::sprintf(env, "#<Encoding:%S>", vector_get(&self->encoding_names->ary, 0));
}

Value *Encoding_name(Env *env, Value *self_value, ssize_t argc, Value **args, Block *block) {
    NAT_ASSERT_ARGC(0);
    EncodingValue *self = self_value->as_encoding();
    return static_cast<Value *>(vector_get(&self->encoding_names->ary, 0));
}

Value *Encoding_names(Env *env, Value *self_value, ssize_t argc, Value **args, Block *block) {
    NAT_ASSERT_ARGC(0);
    EncodingValue *self = self_value->as_encoding();
    return self->encoding_names;
}

}
