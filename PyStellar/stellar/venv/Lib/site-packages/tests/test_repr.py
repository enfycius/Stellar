from typing import Type, List, Optional

from mixins import ReprMixin

EXPECT_NO_COLS_REPR = "<ExampleClass>"
EXPECT_COLS_REPR = "<ExampleClass(a=1, b='hello')>"
EXPECT_COLS_TRUNC_15_REPR = "<ExampleClass(a...>"


class ReprTest:
    def make_class(
        self,
        use_repr_cols: Optional[List[str]] = None,
        truncate: Optional[int] = None,
    ) -> Type:
        if use_repr_cols is None:
            use_repr_cols = ["a", "b"]

        class ExampleClass(ReprMixin):
            repr_cols = use_repr_cols
            _truncate_length = truncate

            def __init__(self, a: int, b: str):
                self.a = a
                self.b = b

        return ExampleClass


class TestRepr(ReprTest):
    def test_long_repr_no_cols(self):
        klass = self.make_class(use_repr_cols=[])
        obj = klass(1, "hello")
        assert repr(obj) == EXPECT_NO_COLS_REPR
        assert repr(obj) == obj._full_repr

    def test_long_repr_with_cols(self):
        klass = self.make_class()
        obj = klass(1, "hello")
        assert repr(obj) == EXPECT_COLS_REPR
        assert repr(obj) == obj._full_repr

    def test_too_short_to_truncate_repr(self):
        klass = self.make_class(truncate=15, use_repr_cols=[])
        obj = klass(1, "hello")
        assert repr(obj) == EXPECT_NO_COLS_REPR
        assert repr(obj) == obj._full_repr

    def test_truncate_repr(self):
        klass = self.make_class(truncate=15)
        obj = klass(1, "hello")
        assert repr(obj) == EXPECT_COLS_TRUNC_15_REPR
        assert repr(obj) != obj._full_repr
