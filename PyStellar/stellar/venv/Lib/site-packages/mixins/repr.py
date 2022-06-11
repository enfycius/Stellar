from typing import List, Any, Optional


class ReprMixin:
    """
    Sets class __repr__ method based on the attributes named in repr_cols.
    """
    repr_cols: List[str] = []
    _truncate_length: Optional[int] = None

    def __repr__(self):
        orig_repr = get_repr(self, self.repr_cols)
        if self._truncate_length is None:
            return orig_repr

        return _truncate_repr(orig_repr, self._truncate_length)

    @property
    def _full_repr(self):
        return get_repr(self, self.repr_cols)

    @property
    def readable_repr(self):
        return _readable_repr(self._full_repr)


def get_repr(obj: Any, cols: Optional[List[str]]) -> str:
    if cols:
        repr_col_strs = [f'{col}={repr(getattr(obj, col, None))}' for col in cols]
        repr_col_str = f'({", ".join(repr_col_strs)})'
    else:
        repr_col_str = ''
    return f'<{type(obj).__name__}{repr_col_str}>'


def show_contents(obj):
    """
    Used to view what's inside an object with pretty printing
    :param obj:
    :return:
    """
    print(_readable_repr(repr(obj)))


def _readable_repr(repr_str):
    out_letters = []
    num_tabs = 1
    for letter in repr_str:
        if letter in (')',']'):
            num_tabs -= 1
            out_letters += ['\n'] + ['   '] * num_tabs
        out_letters.append(letter)
        if letter in ('(','['):
            num_tabs += 1
            out_letters += ['\n'] + ['   '] * num_tabs
    return ''.join(out_letters)


def _truncate_repr(repr_str: str, length: int) -> str:
    if len(repr_str) <= length + 3:
        # Add 3 because truncating would add ...
        return repr_str

    return repr_str[:length] + '...' + repr_str[-1]